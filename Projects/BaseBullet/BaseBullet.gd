extends Area2D

var direction: Vector2 = Vector2.UP
var speed: float = -200.00
var damage: int = 10

func _ready():
	pass

func _process(delta):
	position += direction * speed * delta

func setUpBullet(pos: Vector2, direc: Vector2, velocity: float, dmg: int):
	direction = direc
	speed = velocity
	damage = dmg
	global_position = pos

func blowUp(area: Node2D):
	#print("Hit from: Player Bullet")
	var net_position = global_position - area.global_position
	ObjectMaker.createExplosion(net_position, ObjectMaker.SCENE.SHOT, area)
	queue_free()

func onScreenExited():
	queue_free() 
