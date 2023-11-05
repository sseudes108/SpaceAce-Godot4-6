extends Node2D
@onready var sound = $Sound

var m1 = preload("res://CA/Musics/Billy's Sacrifice.mp3")
var m2 = preload("res://CA/Musics/Checking Manifest.mp3")
var m3 = preload("res://CA/Musics/Crash Landing.mp3")
var m4 = preload("res://CA/Musics/DOS-88 - Automatav2.mp3")
var m5 = preload("res://CA/Musics/DOS-88 - City Stomper.mp3")
var m6 = preload("res://CA/Musics/DOS-88 - Far away.mp3")
var m7 = preload("res://CA/Musics/Parabola.mp3")
var m8 = preload("res://CA/Musics/Race to Mars.mp3")
var m9 = preload("res://CA/Musics/Smooth Sailing.mp3")

var musics = [
	m1,m2,m3,m4,m5,m6,m6,m7,m8,m9
]

func _ready():
	var musicToplay = musics.pick_random()
	sound.stream = musicToplay
	sound.play()
	SignalManager.playerDied.connect(playerDied)

func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.loadMainScene()

func playerDied():
	sound.stop()
	for node in get_children():
		if is_instance_valid(node) and node.is_class("Node2D"):
			ObjectMaker.createExplosion(node.global_position,ObjectMaker.SCENE.BOOM, self)
			node.queue_free()

func _on_sound_finished():
	var musicToplay = musics.pick_random()
	sound.stream = musicToplay
	sound.play()
