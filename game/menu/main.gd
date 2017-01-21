
extends Control

onready var fader = get_node("Fader")
onready var transition_to_gameplay = get_node("TransitionToGameplay")

func _ready():
  fader.fade_in()
  set_process_input(true)

func _input(ev):
  if ev.is_action_pressed("ui_accept"):
    transition_to_gameplay.go()
