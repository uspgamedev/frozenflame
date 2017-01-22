extends Node2D

onready var sfx = get_node("SFX")

func _ready():
	sfx.play()
