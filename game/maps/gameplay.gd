
extends Node2D

onready var input = get_node("input")
onready var hero = get_node("Map/Bodies/Hero")

func _ready():
    _start_camera()
    input.connect("hold_direction", hero, "_move_to")
    input.connect("press_quit", self, "_quit")
    input.connect("press_action", hero, "_act")
    hero.connect("died", self, "_quit")
    set_process(true)

func _start_camera():
    var cam = Camera2D.new()
    hero.add_child(cam)
    cam.make_current()

func _quit():
    get_tree().quit()

func get_hero():
    return hero
