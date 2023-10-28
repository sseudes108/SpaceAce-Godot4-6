extends PathFollow2D

@export var bomber: bool = false
@export var bio: bool = false
@export var zipper: bool = false

@export var shoots: bool = false
@export var aimsAtPlayer: bool = false

@onready var animatedSprite = $AnimatedSprite2D
@onready var laserTimer = $LaserTimer
@onready var booms = $Booms

var player: Player

var enemyName: String
var speed: float
var canShot: bool = true
var dead: bool = false

@export var bulletScene: PackedScene
@export var bulletSpeed: float = 200
@export var bulletDamage: int = 10
@onready var firePoint = $FirePoint
var bulletDirection : = Vector2.DOWN
@export var bulletWaitTime: float = 3.0
@export var bulletWaitTimeVar: float = 0.05

@onready var healthBar = $HealthBar

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

func makeDieExplosions():
	for b in booms.get_children():
		ObjectMaker.createBoom(b.global_position)

func die():
	if dead == true:
		return
	dead = true
	
	set_process(false)
	makeDieExplosions()
	queue_free()

func screenEntered():
	if shoots == true:
		startLaserTimer()

func screenExited():
	set_process(false)
	queue_free()

func onCollisionAreaEntered(area):
	print("Hit - From enemy Base")
	healthBar.takeDamage(20)

func startLaserTimer():
	Utils.SetAndStartTimer(laserTimer,bulletWaitTime,bulletWaitTimeVar)

func updateShotDirection():
	if (aimsAtPlayer == false or
			is_instance_valid(player) == false):
		return
		
	bulletDirection = global_position.direction_to(
		player.global_position
		)

func shot():
	var shot = bulletScene.instantiate()
	updateShotDirection()
	shot.setUpBullet(firePoint.global_position, bulletDirection, bulletSpeed, bulletDamage)
	get_tree().root.add_child(shot)
	startLaserTimer()

func onDied():
	die()
