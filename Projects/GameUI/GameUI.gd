extends Control

@onready var scoreLabel = $ColorRect/MarginContainer/HBoxContainer/ScoreLabel
@onready var healthBar = $ColorRect/MarginContainer/HBoxContainer/HealthBar

var score: int = 0

func _ready():
	SignalManager.onPlayerHit.connect(onPlayerHit)
	SignalManager.playerHealthBonus.connect(playerHealthBonus)
	SignalManager.scoreUpdate.connect(scoreUpdate)

func OnHealthBarDied():
	SignalManager.playerDied.emit()
	GameManager.loadMainScene()

func scoreUpdate(v:int):
	scoreLabel.text = "%06d" % v

func playerHealthBonus(v:int):
	healthBar.updateHealth(v)

func onPlayerHit(v:int):
	healthBar.takeDamage(v)
