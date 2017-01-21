
extends Node

const GamePlay = preload("res://stage_intro/resources/states/gameplay.tscn")

var current_state

func _ready():
    current_state = GamePlay.instance()
    get_node("gameplay").replace_by(current_state)
