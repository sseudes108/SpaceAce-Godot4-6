extends Node

enum ENEMY_TYPE { ZIPPER, BIO, BOMBER }
enum POWERUP_TYPE { HEALTH, SHIELD }

const BULLET_DAMAGE: int = 10
const BOMB_DAMAGE: int = 20
const MISSILE_DAMAGE: int = 30
const COLLISION_DAMAGE: int = 50
const SAUCER_COLLISION_DAMAGE: int = 70

const POWER_UPS = {
	POWERUP_TYPE.HEALTH: preload("res://assets/misc/powerupGreen_bolt.png"),
	POWERUP_TYPE.SHIELD: preload("res://assets/misc/shield_gold.png")
}
