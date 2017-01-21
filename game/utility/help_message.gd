extends Node2D

const Player = preload("res://objects/player/hero.gd")

export(String) var message = "Press <%s> to %s"
export(String) var action = "game_dash"
export(String) var action_text = "Dash"

class INPUT_TYPE:
	const KEYB = "KEYBOARD"
	const PS = "PS4 CONTROLLER"
	const XBOX = "XINPUT GAMEPAD"

var keyb_keys = {
	"game_dash":"F",
	"game_interact":"D",
	"game_panic":"Space",
}

var ps_keys = {
	"game_dash":"Square",
	"game_interact":"X",
	"game_panic":"Left Trigger",
}

var xinput_keys = {
	"game_dash":"X",
	"game_interact":"A",
	"game_panic":"Left Trigger",
}

onready var label = get_node("Label")
var current_gamepad = INPUT_TYPE.KEYB
var result_message

func _ready():
	for g in Input.get_connected_joysticks():
		printt(g, Input.get_joy_guid(g), Input.get_joy_name(g))
		#printt(g, Input.get_joy_guid(g))

	if Input.get_connected_joysticks().empty():
		current_gamepad = INPUT_TYPE.KEYB
	else:
		var gpad = Input.get_joy_name(Input.get_connected_joysticks()[0]).to_upper()
		if gpad.similarity(INPUT_TYPE.PS) > .7:
			current_gamepad = INPUT_TYPE.PS
		elif gpad.similarity(INPUT_TYPE.XBOX) > .7:
			current_gamepad = INPUT_TYPE.XBOX
		else:
			current_gamepad = INPUT_TYPE.KEYB

	printt(current_gamepad)

	if current_gamepad == INPUT_TYPE.PS:
		result_message = message % [ps_keys[action], action_text]
	elif current_gamepad == INPUT_TYPE.XBOX:
		result_message = message % [xinput_keys[action], action_text]
	else:
		result_message = message % [keyb_keys[action], action_text]

	label.set_text(result_message)