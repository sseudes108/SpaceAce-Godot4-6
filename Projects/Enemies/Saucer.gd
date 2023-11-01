extends PathFollow2D

@onready var stateMachine = $AnimationTree["parameters/playback"]

@onready var sprite = $Area2D/Sprite2D

var missile: PackedScene = preload("res://Projects/HomingMissile/HomingMissile.tscn")

const SPEED: float = 0.05
const SHOOT_PROGRESS: float = 0.02
const FIRE_OFFSETS = [0.25, 0.5, 0.75]

var shooting: bool =  false
var shootsFired: int = 0

var dead: bool
@onready var booms = $Booms
@onready var healthBar = $HealthBar

func _ready():
	progress_ratio = 0.0

func _process(delta):
	if shooting == false:
		progress_ratio += SPEED * delta
		TryShoot()
	queueFreeCheck()

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

func onCollisionAreaEntered(area):
	healthBar.takeDamage(20)

func TryShoot():
	if abs(progress_ratio - FIRE_OFFSETS[shootsFired]) < SHOOT_PROGRESS:
		stateMachine.travel("Shoot")
		ShotsCount()

func ShotsCount():
	shootsFired += 1
	if shootsFired >= len(FIRE_OFFSETS):
		shootsFired = 0

func isShooting(v: bool):
	shooting = v

func queueFreeCheck():
	if progress_ratio > 0.99:
		queue_free()

func shot():
	var miss = missile.instantiate()
	get_tree().root.add_child(miss)
	miss.global_position = global_position
