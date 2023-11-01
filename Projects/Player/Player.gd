extends Area2D

class_name Player

@onready var sprite = $Sprite
@onready var animator = $AnimationPlayer

const MARGIN: float = 32.0
var upperLeft: Vector2
var lowerRight: Vector2

@export var speed: float = 216

@export var bulletScene: PackedScene
@export var bulletSpeed: float = 420
@export var bulletDamage: int = 10
@onready var firePoint = $FirePoint
const bulletDirection : = Vector2.UP

func _ready():
	SignalManager.powerUpHit.connect(powerUpHit)
	clampViewPort()

func _process(delta):
	var direction = input()
	movement(direction, delta)
	animation(direction)
	shot()

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

func shot():
	if Input.is_action_just_pressed("shot") == true:
		var shot = bulletScene.instantiate()
		shot.setUpBullet(firePoint.global_position, bulletDirection, bulletSpeed, bulletDamage)
		get_tree().root.add_child(shot)

func powerUpHit(powerUp: GameData.POWERUP_TYPE):
	print("power up", powerUp)

func _on_area_entered(area):
	print("Hit from:", area)
