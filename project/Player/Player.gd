extends Area2D

class_name Player

#Player sprite e movement
@onready var player = $"."
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@export var speed: float = 216.0

#Clamp viewport
const MARGIN: float = 32.0
var upperLeft: Vector2
var lowerRight: Vector2

func _ready():
	var viewPort = get_viewport_rect()
	lowerRight = Vector2(
		viewPort.size.x - MARGIN,
		viewPort.size.y - MARGIN
	)
	upperLeft = Vector2(MARGIN,MARGIN)

func _process(delta):
	var direction = inputs()
	movement(direction, delta)
	animation(direction)

func inputs() -> Vector2:
	var direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	)
	direction.normalized()
	return direction

func movement(direction: Vector2, delta):
	global_position += direction * speed * delta
	global_position = global_position.clamp(
		upperLeft, lowerRight
	)

func animation(direction: Vector2):
	if direction.x != 0:
		anim.play("Turn")
		if direction.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		anim.play("Fly")
