
extends Node2D

onready var input = get_node("input")

var _hero

func _ready():
    self._hero = get_node("map/bodies/hero")
    _start_camera()
    input.connect("hold_direction", self._hero, "_move_to")
    input.connect("press_quit", self, "_quit")
    input.connect("press_action", self._hero, "_act")
    self._hero.connect("died", self, "_quit")
    set_process(true)

func _start_camera():
    var cam = Camera2D.new()
    self._hero.add_child(cam)
    cam.make_current()

func _quit():
    get_tree().quit()

func get_hero():
    return self._hero
