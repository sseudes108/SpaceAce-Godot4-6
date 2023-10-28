extends Area2D

const SPEED: float = 100

@onready var sprite = $Sprite2D
@onready var sound = $Sound

var powerUpType:  GameData.POWERUP_TYPE = GameData.POWERUP_TYPE.SHIELD

func _ready():
	SetPowerUpType(GameData.POWERUP_TYPE.HEALTH)
	SoundManager.play_powerup_deploy_sound(sound)

func _process(delta):
	position.y += delta * SPEED

func SetPowerUpType(pu: GameData.POWERUP_TYPE):
	powerUpType = pu
	sprite.texture = GameData.POWER_UPS[powerUpType]

func OnScreenExited():
	queue_free()

func OnAreaEntered(area):
	SignalManager.powerUpHit.emit(powerUpType)
	queue_free()
