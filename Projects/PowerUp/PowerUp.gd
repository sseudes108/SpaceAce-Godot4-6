extends Area2D

const SPEED: float = 100

@onready var sprite = $Sprite2D
@onready var sound = $Sound

var powerUpType:  GameData.POWERUP_TYPE = GameData.POWERUP_TYPE.HEALTH

func _ready():
	SetPowerUpType(powerUpType)
	sprite.texture = GameData.POWER_UPS[powerUpType]
	SoundManager.play_powerup_deploy_sound(sound)

func _process(delta):
	position.y += delta * SPEED

func SetPowerUpType(pu: GameData.POWERUP_TYPE):
	powerUpType = pu

func OnScreenExited():
	queue_free()

func OnAreaEntered(_area):
	SignalManager.powerUpHit.emit(powerUpType)
	queue_free()
