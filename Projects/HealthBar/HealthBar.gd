extends TextureProgressBar

signal died

@export var lowHealth: int = 30
@export var midHealth: int = 65
@export var startHealth: int = 100

const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

func _ready():
	max_value = startHealth
	value = startHealth
	setColor()

func setColor():
	if value < lowHealth:
		tint_progress = COLOR_DANGER
	elif  value < midHealth:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD

func updateHealth(health: int):
	value += health
	if value <= 0:
		died.emit()
	setColor()

func takeDamage(damage: int):
	updateHealth(-damage)
