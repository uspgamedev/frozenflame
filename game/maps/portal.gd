extends Area2D

const Hero = preload("res://objects/player/hero.gd")

export(String, FILE, "*.tscn") var target_stage_path
export(String) var target_stage_entry_point

onready var sfx = get_node("SFX")

signal teleport(path, entry_point)

func _on_body_enter(body):
  if body.get_script() == Hero:
    sfx.play()
    emit_signal("teleport", target_stage_path, target_stage_entry_point)
