extends KinematicBody2D

const Bullet = preload("res://enemies/bullet.gd")

export(int, "Fire", "Ice") var type = 0
export(float) var wave_delay = 4
export(float) var bullet_speed = 50
export(float) var distance = 300
export(int) var bullet_quantity = 120

onready var timer   = get_node("Timer")
onready var anim    = get_node("Sprite/AnimationPlayer")
onready var shine   = get_node("shiny")
onready var wavesfx = get_node("WaveSFX")
onready var destroyed = false

var dead_bullets = []

signal destroyed

func _ready():
	timer.set_wait_time(wave_delay)

func fire_wave():
	#printt("fire_wave", dead_bullets.size())
	for bcount in range(0,bullet_quantity):
		var degree = 360/bullet_quantity * bcount
		var bullet = null
		if dead_bullets.empty():
			bullet = Bullet.create(self, distance, degree, bullet_speed)
			bullet.connect("on_death",self,"on_bullet_death")
			#printt("creating bullet")
		else:
			bullet = dead_bullets[dead_bullets.size() - 1]
			bullet.reset(self, distance, degree, bullet_speed)
			dead_bullets.pop_back()
		bullet.set_pos(get_pos())
		get_parent().add_child(bullet)

func on_bullet_death(bullet):
	yield(get_tree(), "fixed_frame")
	get_parent().call_deferred("remove_child",bullet)
	dead_bullets.push_back(bullet)

func destroy():
  if not destroyed:
    destroyed = true
    timer.disconnect("timeout", self, "_on_Timer_timeout")
    timer.disconnect("timeout", wavesfx, "play")
    anim.play("dying")
    emit_signal("destroyed")
    yield(anim, "finished")
    set_layer_mask(0)
    set_collision_mask(0)
    shine.queue_free()
    anim.play("dead")

func _on_Timer_timeout():
	fire_wave()
