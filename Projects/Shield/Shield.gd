extends Area2D

@export var startHealth: int = 5
var health: int = startHealth

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer
@onready var sound = $Sound

@onready var shield = $"."

var player: Player

func _ready():
	getPlayerRef()
	disableShield()

func getPlayerRef():
	player = get_tree().get_first_node_in_group("Player")
	if !player:
		queue_free()

func Timeout():
	disableShield()

func disableShield():
	collisionShape.call_deferred("set", "disable", true)
	player.shieldActive = false
	timer.stop
	hide()

func enableShield():
	collisionShape.call_deferred("set", "disable", false)
	player.shieldActive = true
	health = startHealth
	show()
	timer.start()
	SoundManager.play_power_up_sound(GameData.POWERUP_TYPE.SHIELD, sound)

func Hit():
	animationPlayer.play("Hit")
	health-=1
	print(health)
	if health == 0:
		disableShield()

func AreaEntered(area):
	if player.shieldActive == true:
		Hit()
