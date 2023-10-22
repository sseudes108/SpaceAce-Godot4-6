extends Node

const MAINSCENE: PackedScene = preload("res://Projects/Main/Main.tscn")
const LEVELSCENE: PackedScene = preload("res://Projects/Level/Level.tscn")

func _ready():
	pass

func _process(delta):
	pass
	
func loadLevelScene():
	get_tree().change_scene_to_packed(LEVELSCENE)

func loadMainScene():
	get_tree().change_scene_to_packed(MAINSCENE)
