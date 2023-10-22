extends Area2D

class_name Player

@onready var sprite = $Sprite
@onready var animator = $AnimationPlayer

@export var speed: float = 216

const MARGIN: float = 32.0
var upperLeft: Vector2
var lowerRight: Vector2

func _ready():
	clampViewPort()

func _process(delta):
	var direction = input()
	movement(direction, delta)
	animation(direction)

func input() -> Vector2:
	var direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	)
	direction.normalized()
	return direction

func clampViewPort():
	var viewPort = get_viewport_rect()
	lowerRight = Vector2 (
		viewPort.size.x - MARGIN,
		viewPort.size.y - MARGIN
	)
	upperLeft = Vector2 (MARGIN, MARGIN)

func movement(direction: Vector2, delta):
	global_position += direction * speed * delta
	global_position = global_position.clamp(upperLeft, lowerRight)

func animation(direction: Vector2):
	if direction.x != 0:
		animator.play("Turn")
		if direction.x > 0:
			sprite.flip_h = true
		if direction.x < 0:
			sprite.flip_h = false
	else:
		animator.play("Fly")
