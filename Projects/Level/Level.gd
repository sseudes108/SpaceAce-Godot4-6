extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.loadMainScene()
		
	if Input.is_action_just_pressed("Testing"):
		ObjectMaker.createPowerUp(Vector2(200,200),GameData.POWERUP_TYPE.SHIELD)
