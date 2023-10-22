extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.loadMainScene()
	
	if Input.is_key_pressed(KEY_Q):
		ObjectMaker.createExplosion(Vector2(100,200),ObjectMaker.SCENE.SHOT)
	
	if Input.is_key_pressed(KEY_E):
		ObjectMaker.createExplosion(Vector2(400,200),ObjectMaker.SCENE.BOOM)
