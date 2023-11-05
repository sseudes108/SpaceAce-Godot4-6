extends PathFollow2D

@export var bomber: bool = false
@export var bio: bool = false
@export var zipper: bool = false

@export var shoots: bool = false
@export var aimsAtPlayer: bool = false

@onready var animatedSprite = $AnimatedSprite2D
@onready var laserTimer = $LaserTimer
@onready var booms = $Booms
@onready var sound = $Sound

var player: Player

var enemyName: String
var speed: float
var canShot: bool = true
var dead: bool = false

@export var bulletScene: PackedScene
@export var bulletSpeed: float = 200
@export var bulletDamage: int = 10

@export var killPoints: int = 20
@export var damageFromPlayer: int = 20

@onready var firePoint = $FirePoint
var bulletDirection : = Vector2.DOWN
@export var bulletWaitTime: float = 3.0
@export var bulletWaitTimeVar: float = 0.05

@onready var healthBar = $HealthBar

@export var powerUpChance: float = 0.7


var lsr1 = preload("res://Assets/sounds/lasers/sfx_wpn_laser1.wav")
var lsr2 = preload("res://Assets/sounds/lasers/sfx_wpn_laser2.wav")
var lsr3 = preload("res://Assets/sounds/lasers/sfx_wpn_laser3.wav")
var lsr4 = preload("res://Assets/sounds/lasers/sfx_wpn_laser4.wav")
var lsr5 = preload("res://Assets/sounds/lasers/sfx_wpn_laser5.wav")
var lsr6 = preload("res://Assets/sounds/lasers/sfx_wpn_laser6.wav")
var lsr7 = preload("res://Assets/sounds/lasers/sfx_wpn_laser7.wav")
var lsr8 = preload("res://Assets/sounds/lasers/sfx_wpn_laser8.wav")
var lsr9 = preload("res://Assets/sounds/lasers/sfx_wpn_laser9.wav")
var lsr10 = preload("res://Assets/sounds/lasers/sfx_wpn_laser10.wav")
var lsr11 = preload("res://Assets/sounds/lasers/sfx_wpn_laser11.wav")
var lsr12 = preload("res://Assets/sounds/lasers/sfx_wpn_laser12.wav")

var laserSounds = [
	lsr1,
	lsr2,
	lsr3,
	lsr4,
	lsr5,
	lsr6,
	lsr7,
	lsr8,
	lsr9,
	lsr10,
	lsr11,
	lsr12
]

func _ready():
	if bomber == true:
		enemyName = "bomber1"
	if bio == true:
		enemyName = "biomech1"
	if zipper == true:
		enemyName = "zipper1"
	
	setUpEnemy(speed, enemyName)
	getPlayerRef()

func _process(delta):
	progressRatio(delta)

func setUpEnemy(velocity: float, animationName: String):
	speed = velocity
	enemyName = animationName

func getPlayerRef():
	player = get_tree().get_first_node_in_group("Player")
	if !player:
		queue_free()
	
	animatedSprite.animation = enemyName
	animatedSprite.play()

#Fallowed Path Ratio
func progressRatio(delta):
	progress_ratio += speed * delta
	if progress_ratio > 0.99:
		queue_free()

func createPowerUp():
	if randf() < powerUpChance:
		ObjectMaker.createRandomPowerUp(global_position)

func makeDieExplosions():
	for b in booms.get_children():
		ObjectMaker.createBoom(b.global_position)

func die():
	if dead == true:
		return
	dead = true
	
	createPowerUp()
	set_process(false)
	makeDieExplosions()
	queue_free()

func screenEntered():
	if shoots == true:
		startLaserTimer()

func screenExited():
	set_process(false)
	queue_free()

func onCollisionAreaEntered(_area):
	healthBar.takeDamage(damageFromPlayer)

func startLaserTimer():
	Utils.SetAndStartTimer(laserTimer,bulletWaitTime,bulletWaitTimeVar)

func updateShotDirection():
	if (aimsAtPlayer == false or
			is_instance_valid(player) == false):
		return
	bulletDirection = global_position.direction_to(
		player.global_position
		)

func laserSound():
	var soundToPlay = laserSounds.pick_random()
	sound.stream = soundToPlay
	sound.play()

func shot():
	laserSound()
	var projectile = bulletScene.instantiate()
	updateShotDirection()
	projectile.setUpBullet(firePoint.global_position, bulletDirection, bulletSpeed, bulletDamage)
	get_tree().current_scene.add_child(projectile)
	startLaserTimer()

func onDied():
	ScoreManager.incrementScore(killPoints)
	die()
