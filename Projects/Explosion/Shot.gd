extends AnimatedSprite2D

@onready var sound = $Sound

func _ready():
	SoundManager.play_explosion_random(sound) 

func onAnimationEnd():
	queue_free()
