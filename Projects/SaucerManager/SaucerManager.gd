extends Node2D

var saucerScene: PackedScene = preload("res://Projects/Enemies/saucer.tscn")

var sprites = [sprite1,sprite2]
var sprite1 = preload("res://Assets/ships/saucer_2.png")
var sprite2 = preload("res://Assets/ships/saucer_1.png")

const WAIT_TIME: float = 8.0
const WAIT_VAR: float = 1.0

@onready var timer = $Timer
@onready var paths = $Paths.get_children()

func _ready():
	SpawnSaucer() 

func OnTimeout():
	SpawnSaucer()

func SpawnSaucer():
	var p = paths.pick_random()
	var saucer = saucerScene.instantiate()
	p.add_child(saucer)
	saucer.sprite.texture = sprites.pick_random()
	Utils.SetAndStartTimer(timer,WAIT_TIME,WAIT_VAR)
