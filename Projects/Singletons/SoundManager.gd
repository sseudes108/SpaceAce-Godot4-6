extends Node

const DOOR_OPEN_SOUND = preload("res://assets/sounds/misc/sci-fi-door.wav")
const POWER_UP_DEPLOY = preload("res://assets/sounds/powerup/power_up_deploy.wav")

const POWER_UP_SOUNDS = {
	GameData.POWERUP_TYPE.HEALTH: preload("res://assets/sounds/powerup/health_16.wav"),
	GameData.POWERUP_TYPE.SHIELD: preload("res://assets/sounds/powerup/shield_18.wav")
}

func play_power_up_sound(pu_type: GameData.POWERUP_TYPE, audio: AudioStreamPlayer2D):
	audio.stream = POWER_UP_SOUNDS[pu_type]
	audio.play()

func play_powerup_deploy_sound(audio: AudioStreamPlayer2D):
	audio.stream = POWER_UP_DEPLOY
	audio.play()
