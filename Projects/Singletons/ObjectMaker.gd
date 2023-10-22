extends Node

enum SCENE { SHOT, BOOM }

const SCENES = {
	SCENE.SHOT: preload("res://Projects/Explosion/Shot.tscn"),
	SCENE.BOOM: preload("res://Projects/Explosion/Boom.tscn")
}  

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)
	
func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_simple_scene(start_pos: Vector2, key: SCENE) -> void:
	var new_exp = SCENES[key].instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp)

func createExplosion(start_pos: Vector2, scene: SCENE) -> void:
	create_simple_scene(start_pos, scene)
