extends Node2D
@onready var sound = $Sound

func _ready():
	pass
	SignalManager.playerDied.connect(playerDied)

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.loadMainScene()

func playerDied():
	sound.stop()
	for node in get_children():
		if is_instance_valid(node) and node.is_class("Node2D"):
			ObjectMaker.createExplosion(node.global_position,ObjectMaker.SCENE.BOOM, self)
			node.queue_free()
