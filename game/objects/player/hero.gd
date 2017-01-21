
extends "res://objects/monster.gd"

const DIR = preload("res://utility/directions.gd")
const ACT = preload("res://utility/actions.gd")

const Enemy = preload("res://enemies/enemy.gd")
const Bullet = preload("res://enemies/bullet.gd")

const DASHTIME = 0.1
const DASHCOOLDOWN = 1.0

onready var sprite = get_node("sprite")
onready var hitbox = get_node("hitbox")

export(float) var bullet_speed = 80
export(float) var distance = 30
export(int) var bullet_quantity = 80
var dead_bullets = []

func _move_to(dir):
  ._move_to(dir)
  if direction == DIR.UP:
    set_rotd(180)
    sprite.set_rotd(-180)
  elif direction == DIR.DOWN:
    set_rotd(0)
    sprite.set_rotd(0)
  elif direction == DIR.LEFT:
    set_rotd(270)
    sprite.set_rotd(-270)
  elif direction == DIR.RIGHT:
    set_rotd(90)
    sprite.set_rotd(-90)

func apply_damage(dmg):
  self.damage += dmg
  printt("health=", maxHP - damage, "name=", get_name(), "path=", get_path())
  if damage >= maxHP:
     emit_signal("died")

func _act(act):
  if act == ACT.INTERACT:
    var range_bodies = hitbox.get_overlapping_bodies()
    for body in range_bodies:
      if body extends Enemy:
        body.destroy()
  elif act == ACT.DASH and self.dashCooldown <= 0:
    self.dashTime = DASHTIME
    self.dashCooldown = DASHCOOLDOWN

func kill():
  self.emit_signal("died")
  set_process(false)
  animation.play("death")
  var death_slash = load("res://effects/death_slash.tscn").instance()
  death_slash.set_offset(Vector2(16, 0))
  add_child(death_slash)

func fire_wave():
	#printt("fire_wave", dead_bullets.size())
	for bcount in range(0,bullet_quantity):
		var degree = 360/bullet_quantity * bcount
		var bullet = null
		if dead_bullets.empty():
			bullet = Bullet.create()
			bullet.connect("on_death",self,"on_bullet_death")
			#printt("creating bullet")
		else:
			bullet = dead_bullets[dead_bullets.size() - 1]
			dead_bullets.pop_back()
		
		get_parent().add_child(bullet)
		bullet.set_pos(get_pos())
		bullet.setup(true, self, distance, degree, bullet_speed)

func on_bullet_death(bullet):
	yield(get_tree(), "fixed_frame")
	get_parent().call_deferred("remove_child",bullet)
	dead_bullets.push_back(bullet)

