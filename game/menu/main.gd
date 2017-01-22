
extends Control

onready var fader = get_node("Fader")
onready var transition_to_gameplay = get_node("TransitionToGameplay")
onready var sfx = get_node("List/PlayOption/cursor/SFX")

func _ready():
  fader.fade_in()
  set_process_input(true)

func _input(ev):
  if ev.is_action_pressed("ui_accept"):
    sfx.play()
    fader.fade_out()
    yield(fader, "done_fade_out")
    transition_to_gameplay.go()
