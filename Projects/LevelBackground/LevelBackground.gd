extends ParallaxBackground

@onready var parallaxLayer1 = $ParallaxLayer
@onready var parallaxLayer2 = $ParallaxLayer2
@onready var parallaxLayer3 = $ParallaxLayer3

@onready var textureRect = $TextureRect

var nbGreen1 = preload("res://CA/Green Nebula/Green_Nebula_01-1024x1024.png")
var nbGreen2 = preload("res://CA/Green Nebula/Green_Nebula_02-1024x1024.png")
var nbGreen3 = preload("res://CA/Green Nebula/Green_Nebula_03-1024x1024.png")
var nbGreen4 = preload("res://CA/Green Nebula/Green_Nebula_04-1024x1024.png")
var nbGreen5 = preload("res://CA/Green Nebula/Green_Nebula_05-1024x1024.png")
var nbGreen6 = preload("res://CA/Green Nebula/Green_Nebula_06-1024x1024.png")
var nbGreen7 = preload("res://CA/Green Nebula/Green_Nebula_07-1024x1024.png")
#var nbGreen8 = preload("res://CA/Green Nebula/Green_Nebula_08-1024x1024.png")

var nbBlue1 = preload("res://CA/Blue Nebula/Blue_Nebula_01-1024x1024.png")
var nbBlue2 = preload("res://CA/Blue Nebula/Blue_Nebula_02-1024x1024.png")
var nbBlue3 = preload("res://CA/Blue Nebula/Blue_Nebula_03-1024x1024.png")
var nbBlue4 = preload("res://CA/Blue Nebula/Blue_Nebula_04-1024x1024.png")
var nbBlue5 = preload("res://CA/Blue Nebula/Blue_Nebula_05-1024x1024.png")
var nbBlue6 = preload("res://CA/Blue Nebula/Blue_Nebula_06-1024x1024.png")
var nbBlue8 = preload("res://CA/Blue Nebula/Blue_Nebula_08-1024x1024.png")

var nbPurple1 = preload("res://CA/Purple Nebula/Purple_Nebula_01-1024x1024.png")
var nbPurple2 = preload("res://CA/Purple Nebula/Purple_Nebula_02-1024x1024.png")
var nbPurple3 = preload("res://CA/Purple Nebula/Purple_Nebula_03-1024x1024.png")
var nbPurple4 = preload("res://CA/Purple Nebula/Purple_Nebula_04-1024x1024.png")
var nbPurple5 = preload("res://CA/Purple Nebula/Purple_Nebula_05-1024x1024.png")
var nbPurple6 = preload("res://CA/Purple Nebula/Purple_Nebula_06-1024x1024.png")
var nbPurple7 = preload("res://CA/Purple Nebula/Purple_Nebula_07-1024x1024.png")
#var nbPurple8 = preload("res://CA/Purple Nebula/Purple_Nebula_08-1024x1024.png")

var nebulaBg = [
	nbPurple1,
	nbPurple2,
	nbPurple3,
	nbPurple4,
	nbPurple5,
	nbPurple6,
	nbPurple7,
	#nbPurple8,
	nbGreen1,
	nbGreen2,
	nbGreen3,
	nbGreen4,
	nbGreen5,
	nbGreen6,
	nbGreen7,
#	nbGreen8,
	nbBlue1,
	nbBlue2,
	nbBlue3,
	nbBlue4,
	nbBlue5,
	nbBlue6,
	nbBlue8,
]

const SPEED: float = 216.0

func _ready():
	textureRect.texture = nebulaBg.pick_random()

func _process(delta):
	parallaxLayer1.motion_offset.y += SPEED * delta * 0.2
	parallaxLayer2.motion_offset.y += SPEED * delta * 0.3
	parallaxLayer3.motion_offset.y += SPEED * delta * 0.4

func setProcess(running: bool):
	set_process(running)
