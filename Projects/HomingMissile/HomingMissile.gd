extends Area2D


const ROTATION_SPEED: float = 100
const SPEED: float = 200

var player: Player

func _ready():
	getPlayerRef() 

func _process(delta):
	turn(delta)
	move(delta)

func getPlayerRef():
	player = get_tree().get_first_node_in_group("Player")

func getAngleToPlayer() -> float:
	if is_instance_valid(player) == false:
		return 0.0
	
	return rad_to_deg((player.global_position - global_position).angle())

func getAngleToTurn(angleToPlayer: float) -> float:
	return fmod((angleToPlayer - global_rotation_degrees +180.0), 360.0) - 180.0

func turn(delta):
	var angleToPlayer = getAngleToPlayer()
	var angleToTurn = getAngleToTurn(angleToPlayer)
	
	if abs(angleToTurn) < 180.0:
		rotation_degrees += sign(angleToTurn) * delta * ROTATION_SPEED
	else:
		rotation_degrees += sign(angleToTurn) * -1 * delta * ROTATION_SPEED

func move(delta):
	position += transform.x.normalized() * SPEED * delta

func blowUp(area):
	var net_position = global_position - area.global_position
	ObjectMaker.createExplosion(net_position, ObjectMaker.SCENE.BOOM, area)
	queue_free()

func OnAreaEntered(area):
	blowUp(area)
