
extends Node2D

const TIME_PER_SLIDE = 5.0

onready var tween = get_node("tween")
onready var timer = get_node("timer")
onready var music = get_node("music")
onready var list = get_node("list")
onready var the_end = get_node("the_end")

func _ready():
  music.play()
  music.set_volume(0)
  hide_all()
  start()

func hide_all():
  var credits = list.get_children()
  the_end.set_opacity(0)
  the_end.hide()
  for slide in credits:
    slide.set_opacity(0)
    slide.hide()

func start():
  var fading_bgm = TIME_PER_SLIDE / 2
  var fading_time = TIME_PER_SLIDE * 1 / 5
  var waiting_time = TIME_PER_SLIDE * 3 / 5

  # fade in music
  tween.interpolate_method(music, "set_volume", 0, 1, fading_bgm, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")

  # showcase each credit slide
  var credits = list.get_children()
  for slide in credits:
    print(slide.get_name())
    slide.show()
    tween.interpolate_method(slide, "set_opacity", 0, 1, fading_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
    tween.start()
    yield(tween, "tween_complete")
    timer.set_wait_time(waiting_time)
    timer.start()
    yield(timer, "timeout")
    tween.interpolate_method(slide, "set_opacity", 1, 0, fading_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
    tween.start()
    yield(tween, "tween_complete")

  # fade out music
  tween.interpolate_method(music, "set_volume", 1, 0, fading_bgm, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")

  # display the end
  the_end.show()
  tween.interpolate_method(the_end, "set_opacity", 0, 1, fading_time * 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")
  timer.set_wait_time(waiting_time)
  timer.start()
  yield(timer, "timeout")

  # activate input
  set_process_input(true)

func _input(e):
  if e.is_action_pressed("ui_accept"):
    get_tree().get_root().queue_free()
