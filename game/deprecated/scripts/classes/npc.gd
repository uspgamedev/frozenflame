
extends "res://stage_intro/scripts/classes/body.gd"

const HERO = preload("res://stage_intro/scripts/classes/hero.gd")

export(Script) var behaviourScript
export(Script) var eventScript

var EVENT
var BEHAVIOUR

func _ready():
    var interactionarea = get_node("interaction_area")
    self.set_body_type("npc")
    EVENT = eventScript.new(self)
    BEHAVIOUR = behaviourScript.new(self, true)
    set_process(true)

func _process(delta):
    BEHAVIOUR.update(delta)

func connect_hero():
    var input = get_node("/root/input")
    input.connect("press_action", self, "_on_press_action")

func disconnect_hero():
    var input = get_node("/root/input")
    input.disconnect("press_action", self, "_on_press_action")

func _on_press_action(act):
    if act == 0:
        EVENT.run(act)

func _on_interaction_area_body_enter( body ):
    var is_hero = body extends HERO
    if is_hero:
        print("connect hero!")
        connect_hero()

func _on_interaction_area_body_exit( body ):
    var is_hero = body extends HERO
    if is_hero:
        print("disconnect hero!")
        disconnect_hero()
