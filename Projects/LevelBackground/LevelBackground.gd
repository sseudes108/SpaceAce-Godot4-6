extends ParallaxBackground

@onready var parallaxLayer1 = $ParallaxLayer
@onready var parallaxLayer2 = $ParallaxLayer2
@onready var parallaxLayer3 = $ParallaxLayer3

const SPEED: float = 216.0

func _process(delta):
	parallaxLayer1.motion_offset.y += SPEED * delta * 0.2
	parallaxLayer2.motion_offset.y += SPEED * delta * 0.3
	parallaxLayer3.motion_offset.y += SPEED * delta * 0.4

func setProcess(running: bool):
	set_process(running)
