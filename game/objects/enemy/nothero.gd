
extends "res://objects/monster.gd"

export(Script) var behaviourScript

var BEHAVIOUR

func _ready():
    self.animation.queue("idle")
    BEHAVIOUR = behaviourScript.new(self, true)
    set_process(true)
    self.connect("died", self, "die")

func die():
  queue_free()

func _process(delta):
    BEHAVIOUR.update(delta)
