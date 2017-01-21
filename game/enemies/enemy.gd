extends KinematicBody2D

const Bullet = preload("res://enemies/bullet.gd")

export(int, "Fire", "Ice") var type = 0
export(int) var wave_quantity = 1
export(float) var wave_delay = 1
export(float) var bullet_speed = 1
export(float) var distance = 100
export(int) var bullet_quantity = 720

onready var bullets = get_node("Bullets")

func _ready():
	pass

func fire_wave():
	print("fire_wave")
	for wave in range(0, wave_quantity):
		printt("wave", wave)
		for bcount in range(0,bullet_quantity):
			var degree = 360/bullet_quantity * bcount
			var bullet = Bullet.create(self, distance, degree, bullet_speed)
			bullet.set_pos(get_pos())
			get_parent().add_child(bullet)
			printt("shoot")


func _on_Timer_timeout():
	fire_wave()
