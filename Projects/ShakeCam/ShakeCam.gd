extends Camera2D

const SHAKE_AMOUNT: Vector2 = Vector2(-0.9,0.9)
@onready var timer = $Timer
var shakeOffset: Vector2 = Vector2.ZERO

func _ready():
	shakeOffset = offset
	SignalManager.onPlayerHit.connect(onPlayerHit)
	set_process(false)

func _process(_delta):
	offset = Vector2(
		shakeOffset.x + getRandomShakeAmount(),
		shakeOffset.y + getRandomShakeAmount()
	)

func getRandomShakeAmount() -> float:
	return randf_range(SHAKE_AMOUNT.x,SHAKE_AMOUNT.y)

func onPlayerHit(_v: int):
	set_process(true)
	timer.start()

func _on_timer_timeout():
	set_process(false)
	offset = shakeOffset
