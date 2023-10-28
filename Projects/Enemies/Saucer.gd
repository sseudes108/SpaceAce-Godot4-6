extends PathFollow2D

const SPEED: float = 0.05

var dead: bool
@onready var booms = $Booms
@onready var healthBar = $HealthBar

func _ready():
	progress_ratio = 0.0

func _process(delta):
	progress_ratio += SPEED * delta

func makeDieExplosions():
	for b in booms.get_children():
		ObjectMaker.createBoom(b.global_position)

func die():
	if dead == true:
		return
	dead = true
	
	set_process(false)
	makeDieExplosions()
	queue_free()

func onCollisionAreaEntered(area):
	print("Hit - From enemy Base")
	healthBar.takeDamage(20)
