extends Area2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Testing"):
		show()
		timer.start()

func Timeout():
	hide()

func ShieldLogic(process: bool):
	set_process(process)
	if process == true:
		show()
	else:
		hide()
