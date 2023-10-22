extends AnimatedSprite2D

@onready var sound = $Sound
@onready var boom = $"."

func _ready():
	SoundManager.play_explosion_random(sound) 

func onAnimationEnd():
	boom.hide()

func onSoundEnd():
	queue_free()
