extends Node

const MAINSCENE: PackedScene = preload("res://project/Main/Main.tscn")
const LEVELSCENE:PackedScene = preload("res://project/Level/level.tscn")

func loadLevelScene():
	get_tree().change_scene_to_packed(LEVELSCENE)

func loadMainScene():
	get_tree().change_scene_to_packed(MAINSCENE)
