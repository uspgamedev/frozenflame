extends CanvasLayer

export(float) var fade_in_time = 1.0
export(float) var fade_out_time = 1.0

onready var screen = get_node("Screen")
onready var tween = get_node("Tween")

signal done_fade_in
signal done_fade_out

func _ready():
  screen.show()

func fade_in():
  tween.interpolate_method(screen, "set_color", Color(0,0,0,1), Color(0,0,0,0), fade_in_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")
  emit_signal("done_fade_in")

func fade_out():
  tween.interpolate_method(screen, "set_color", Color(0,0,0,0), Color(0,0,0,1), fade_out_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")
  emit_signal("done_fade_out")
