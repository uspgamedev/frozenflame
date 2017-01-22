extends Node2D

const FADING_TIME = 2.0
const WATING_TIME = 5.0

onready var sfx = get_node("SFX")
onready var tween = get_node("tween")
onready var timer = get_node("timer")
onready var success = get_node("messages/success")
onready var long_text = get_node("messages/text")

func _ready():
	success.show()
	long_text.hide()
	long_text.set_opacity(0)
	sfx.play()
	start()

func start():
	while sfx.is_voice_active(0):
		yield(get_tree(), "fixed_frame")
	tween.interpolate_method(success, "set_opacity", 1, 0, FADING_TIME, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")
	success.hide()
	long_text.show()
	tween.interpolate_method(long_text, "set_opacity", 0, 1, FADING_TIME, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")
	timer.set_wait_time(WATING_TIME)
	timer.start()
	yield(timer, "timeout")
	tween.interpolate_method(long_text, "set_opacity", 1, 0, FADING_TIME, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_complete")
	change_to_credits()

func change_to_credits():
	var credits = load("res://credits/credits.tscn").instance()
	get_parent().add_child(credits)
	self.queue_free()
