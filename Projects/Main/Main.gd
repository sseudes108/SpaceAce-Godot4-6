extends Node2D

func play():
	GameManager.loadLevelScene()

func quit():
	get_tree().quit()
