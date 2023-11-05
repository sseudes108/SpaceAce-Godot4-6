extends AnimatedSprite2D

@onready var sound = $Sound

var exp1 = preload("res://Assets/sounds/explosions/sfx_exp_medium1.wav")
var exp2 = preload("res://Assets/sounds/explosions/sfx_exp_medium2.wav")
var exp3 = preload("res://Assets/sounds/explosions/sfx_exp_medium3.wav") 
var exp4 = preload("res://Assets/sounds/explosions/sfx_exp_medium4.wav")
var exp5 = preload("res://Assets/sounds/explosions/sfx_exp_medium5.wav") 
var exp6 = preload("res://Assets/sounds/explosions/sfx_exp_medium6.wav") 
var exp7 = preload("res://Assets/sounds/explosions/sfx_exp_medium7.wav") 
var exp8 = preload("res://Assets/sounds/explosions/sfx_exp_medium8.wav") 
var exp9 = preload("res://Assets/sounds/explosions/sfx_exp_medium9.wav") 
var exp10 = preload("res://Assets/sounds/explosions/sfx_exp_medium10.wav") 
var exp11 = preload("res://Assets/sounds/explosions/sfx_exp_medium11.wav") 
var exp12 = preload("res://Assets/sounds/explosions/sfx_exp_medium12.wav") 
var exp13 = preload("res://Assets/sounds/explosions/sfx_exp_medium13.wav")

var explosionSounds = [
	exp1,
	exp2,
	exp3,
	exp4,
	exp5,
	exp6,
	exp7,
	exp8,
	exp9,
	exp10,
	exp11,
	exp12,
	exp13
]

func _ready():
	var soundToPlay = explosionSounds.pick_random()
	print(soundToPlay)
	sound.stream = soundToPlay
	sound.play()

func onAnimationEnd():
	queue_free()
