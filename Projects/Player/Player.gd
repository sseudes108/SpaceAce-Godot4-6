extends Area2D

class_name Player

@onready var sound = $Sound

@onready var sprite = $Sprite
@onready var animator = $AnimationPlayer

const MARGIN: float = 32.0
var upperLeft: Vector2
var lowerRight: Vector2

@export var speed: float = 216
@onready var shield = $Shield

@export var heatlhBonus: float = 30

@export var bulletScene: PackedScene
@export var bulletSpeed: float = 420
@export var bulletDamage: int = 10
@onready var firePoint = $FirePoint
const bulletDirection : = Vector2.UP

var shieldActive: bool = false

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
		var projectile = bulletScene.instantiate()
		projectile.setUpBullet(firePoint.global_position, bulletDirection, bulletSpeed, bulletDamage)
		get_tree().current_scene.add_child(projectile)

func powerUpHit(powerUp: GameData.POWERUP_TYPE):
	if powerUp == GameData.POWERUP_TYPE.SHIELD:
		shield.enableShield()
	if powerUp == GameData.POWERUP_TYPE.HEALTH:
		SignalManager.playerHealthBonus.emit(heatlhBonus)
		SoundManager.play_power_up_sound(GameData.POWERUP_TYPE.HEALTH, sound)

func _on_area_entered(area):
	if shieldActive == false:
		if area.is_in_group("EnemyShip"):
			SignalManager.onPlayerHit.emit(GameData.COLLISION_DAMAGE)
			#print("EnemyShip ",GameData.COLLISION_DAMAGE)
			
		if area.is_in_group("Saucer"):
			SignalManager.onPlayerHit.emit(GameData.SAUCER_COLLISION_DAMAGE)
			#print("Saucer ",GameData.SAUCER_COLLISION_DAMAGE)
			
		if area.is_in_group("EnemyBullet"):
			SignalManager.onPlayerHit.emit(GameData.BULLET_DAMAGE)
			#print("EnemyBullet ", GameData.BULLET_DAMAGE)
			
		if area.is_in_group("EnemyBomb"):
			SignalManager.onPlayerHit.emit(GameData.BOMB_DAMAGE)
			#print("EnemyBomb ",GameData.BOMB_DAMAGE)
			
		if area.is_in_group("Missile"):
			SignalManager.onPlayerHit.emit(GameData.MISSILE_DAMAGE)
			#print("Missile ",GameData.MISSILE_DAMAGE)
