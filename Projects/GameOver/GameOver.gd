extends Control

@onready var timer = $Timer
@onready var score = $ColorRect/VBoxContainer/Score
@onready var bestScore = $ColorRect/VBoxContainer/BestScore
@onready var waves = $ColorRect/VBoxContainer/Waves

@onready var tryAgain = $"ColorRect/Try again"


var canShoot: bool = false

func _ready():
	hide()
	tryAgain.hide()
	SignalManager.playerDied.connect(playerDied)

func _process(_delta):
	if canShoot == true:
		if Input.is_action_just_pressed("shot"):
			GameManager.loadLevelScene()
		if Input.is_key_pressed(KEY_Q):
			GameManager.loadMainScene()

func onTimeout():
	tryAgain.show()
	canShoot = true

func playerDied():
	updateScores()
	show()
	timer.start()

func updateScores():
	var scr = str(ScoreManager.getScore())
	var bstScr = str(ScoreManager.getBestScore())
	var wav = str(ScoreManager.getWavesSurvived())
	
	score.text = "Score: %s" %scr
	waves.text = "Waves Survived: %s" %wav
	bestScore.text = "Best: %s" %bstScr
