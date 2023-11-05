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

const ENEMY_DATA = {
	GameData.ENEMY_TYPE.ZIPPER: { "speed": 0.10, "gap": 0.6, "min": 6, "max": 10},
	GameData.ENEMY_TYPE.BIO:  { "speed": 0.08, "gap": 0.7, "min": 6, "max": 8},
	GameData.ENEMY_TYPE.BOMBER: { "speed": 0.07, "gap": 1.0, "min": 2, "max": 4},
}

@onready var paths = $Paths
@onready var spawnTimer = $SpawnTimer

var pathList: Array = []
var speedFactor: float = 1.0
var waveCount: int = 0
var lastPathIndex: int = -1
var waveGap: float = 6.0

func _ready():
	pathList = paths.get_children()
	print(len(pathList))
	spawnWave() 

func createEnemy(speed: float, enemyName: String, enemyType: GameData.ENEMY_TYPE):
	var newEnemy = ENEMY_SCENES[enemyType].instantiate()
	newEnemy.setUpEnemy(speed, enemyName)
	return newEnemy

func updateSpeeds() -> void:
	if waveCount % len(pathList) == 0 and waveCount != 0:
		speedFactor *= 1.05
		waveGap *= 0.97
#		print("update_speeds(): _wave_count:%s _speed_factor:%s _wave_gap:%s" % [
#			waveCount, speedFactor, waveGap])

func startSpawnTimer() -> void:
	spawnTimer.wait_time = waveGap
	spawnTimer.start()

func get_random_path_index() -> int:
	var index = randi_range(0, len(pathList)-1)
	while index == lastPathIndex:
		index = randi_range(0, len(pathList)-1)
	lastPathIndex = index
	return index

func spawnWave() -> void:
	var path = pathList[get_random_path_index()]
	var en_type = GameData.ENEMY_TYPE.values().pick_random()
	var anim = ENEMY_FRAMES[en_type].pick_random()
	var spawn_data = ENEMY_DATA[en_type]
	
	#print("\nspawn_wave()\n_last_path_index:", lastPathIndex)
	#print("spawn_data:", spawn_data)
	
	for num in range(randi_range(spawn_data.min, spawn_data.max)):
		path.add_child(createEnemy(spawn_data.speed * speedFactor, anim, en_type))
		await get_tree().create_timer(spawn_data.gap + 0.3).timeout
	
	#print("wave() spawned, waiting:", waveGap)
	waveCount += 1
	ScoreManager.waveSurvived(1)
	await get_tree().create_timer(waveGap).timeout
	updateSpeeds()
	startSpawnTimer()

func spawnTimerTimeout():
	spawnWave()
