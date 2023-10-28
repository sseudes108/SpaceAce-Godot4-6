extends Node2D

const ENEMY_FRAMES = {
	GameData.ENEMY_TYPE.ZIPPER: ["zipper1","zipper2","zipper3"],
	GameData.ENEMY_TYPE.BIO: ["biomech1","biomech2","biomech3"],
	GameData.ENEMY_TYPE.BOMBER: ["bomber1","bomber2","bomber3"]
}

const ENEMY_SCENES = {
	GameData.ENEMY_TYPE.ZIPPER: preload("res://Projects/Enemies/EnemyZipper.tscn"),
	GameData.ENEMY_TYPE.BIO: preload("res://Projects/Enemies/EnemyBiomech.tscn"),
	GameData.ENEMY_TYPE.BOMBER: preload("res://Projects/Enemies/EnemyBomber.tscn")
}

@onready var paths = $Paths
var pathList: Array = []

func _ready():
	pathList = paths.get_children()
	spawnWave() 

func crateEnemy(speed: float, enemyName: String, enemyType: GameData.ENEMY_TYPE):
	var newEnemy = ENEMY_SCENES[enemyType].instantiate()
	newEnemy.setUpEnemy(speed, enemyName)
	return newEnemy

func spawnWave():
	var path = pathList.pick_random()
	var enemyType = GameData.ENEMY_TYPE.values().pick_random()
	var animation = ENEMY_FRAMES[enemyType].pick_random()
	
	for num in range(4):
		path.add_child(crateEnemy(0.2, ENEMY_FRAMES[enemyType].pick_random(), enemyType))
		await get_tree().create_timer(1).timeout
