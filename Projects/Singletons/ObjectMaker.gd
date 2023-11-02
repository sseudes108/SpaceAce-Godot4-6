extends Node

enum SCENE { SHOT, BOOM }

const SCENES = {
	SCENE.SHOT: preload("res://Projects/Explosion/Shot.tscn"),
	SCENE.BOOM: preload("res://Projects/Explosion/Boom.tscn")
}  

const POWER_UP_SCENE: PackedScene = preload("res://Projects/PowerUp/PowerUp.tscn")

func add_child_deferred(child_to_add, parent: Node2D) -> void:
	parent.add_child(child_to_add)

func call_add_child(child_to_add, parent: Node2D) -> void:
	call_deferred("add_child_deferred", child_to_add, parent)

func create_simple_scene(start_pos: Vector2, key: SCENE, parent: Node2D) -> void:
	var new_exp = SCENES[key].instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp,parent)

func createExplosion(start_pos: Vector2, scene: SCENE, parent: Node2D) -> void:
	create_simple_scene(start_pos, scene, parent)

func createBoom(start_pos: Vector2):
	create_simple_scene(start_pos, SCENE.BOOM, get_tree().current_scene)

func createPowerUp(start_pos: Vector2, powerUpType: GameData.POWERUP_TYPE):
	var pu = POWER_UP_SCENE.instantiate()
	pu.global_position = start_pos
	pu.SetPowerUpType(powerUpType)
	call_add_child(pu,get_tree().current_scene)
