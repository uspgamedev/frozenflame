extends Control

onready var fader = get_node("Fader")

func _ready():
	fader.fade_in()
