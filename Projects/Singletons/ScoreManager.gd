extends Node

var score: int = 0
var highScore: int = 0

const SCOREFILE: String = "user://scores.dat"

#var bestScores: Dictionary = {}

func _ready():
	LoadScores()

func incrementScore(v: int):
	score += v
	if highScore < score:
		highScore = score
	SignalManager.scoreUpdate.emit(score)
	SaveScores()

func resetScore():
	score = 0
	SignalManager.scoreUpdate.emit(score)

func LoadScores():
	if FileAccess.file_exists(SCOREFILE) == false:
		return
	var scoreFile = FileAccess.open(SCOREFILE, FileAccess.READ)
	highScore = JSON.parse_string(scoreFile.get_as_text())
	print("Best Scores:", highScore)

func SaveScores():
	var scoreFile = FileAccess.open(SCOREFILE, FileAccess.WRITE)
	scoreFile.store_string(JSON.stringify(highScore))

func getScore() -> int:
	return score

func getBestScore() -> int:
	return highScore
