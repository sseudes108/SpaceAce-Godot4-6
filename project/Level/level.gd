extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE) == true:
		quitLevel()

func quitLevel():
	GameManager.loadMainScene()
