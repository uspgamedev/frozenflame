extends Area2D

const Hero = preload("res://objects/player/hero.gd")

export(String, FILE, "*.tscn") var target_stage_path
export(String) var target_stage_entry_point

signal teleport(path, entry_point)

func _on_body_enter(body):
  if body.get_script() == Hero:
    emit_signal("teleport", target_stage_path, target_stage_entry_point)
