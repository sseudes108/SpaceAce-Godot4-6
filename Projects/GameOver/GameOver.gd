extends Control

@onready var timer = $Timer
@onready var score = $ColorRect/VBoxContainer/Score
@onready var bestScore = $ColorRect/VBoxContainer/BestScore

var canShoot: bool = false

func _ready():
	hide()
	SignalManager.playerDied.connect(playerDied)

func _process(delta):
	if canShoot == true:
		if Input.is_action_just_pressed("shot"):
			GameManager.loadLevelScene()
		if Input.is_key_pressed(KEY_Q):
			GameManager.loadMainScene()

func onTimeout():
	canShoot = true

func playerDied():
	updateScores()
	show()
	timer.start()

func updateScores():
	var scr = str(ScoreManager.getScore())
	var bstScr = str(ScoreManager.getBestScore())
	score.text = "Score: %s" %scr
	bestScore.text = "Best: %s" %bstScr
