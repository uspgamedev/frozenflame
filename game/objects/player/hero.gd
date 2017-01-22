
extends "res://objects/monster.gd"

const DIR = preload("res://utility/directions.gd")
const ACT = preload("res://utility/actions.gd")

const Enemy = preload("res://enemies/enemy.gd")
const Bullet = preload("res://enemies/bullet.gd")

const DASHTIME = 0.1
const DASHCOOLDOWN = 1.0

var dead = false

onready var sprite    = get_node("sprite")
onready var hitbox    = get_node("hitbox")
onready var collision = get_node("collision")
onready var death_sfx = get_node("DeathSFX")
onready var dash_sfx  = get_node("DashSFX")

export(float) var bullet_speed = 200
export(float) var bullet_time = 0.3
export(int) var bullet_quantity = 36

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
    dash_sfx.play()
  elif act == ACT.PANIC:
    self.fire_wave()

func kill():
  if not dead:
    dead = true
    death_sfx.play()
    self.emit_signal("died")
    set_process(false)
    animation.play("death")
    var death_slash = load("res://effects/death_slash.tscn").instance()
    death_slash.set_offset(Vector2(0, 0))
    add_child(death_slash)

func fire_wave():
  for bcount in range(0,bullet_quantity):
    var degree = ( 360.0 / bullet_quantity ) * bcount
    var bullet = null
    if dead_bullets.empty():
      bullet = Bullet.create()
      bullet.connect("on_death",self,"on_bullet_death")
    else:
      bullet = dead_bullets[dead_bullets.size() - 1]
      dead_bullets.pop_back()

    get_parent().add_child(bullet)

    var area = bullet.get_node("CollisionArea")
    area.set_layer_mask_bit(0, true)
    area.set_layer_mask_bit(1, false)
    area.set_collision_mask_bit(0, false)
    area.set_collision_mask_bit(1, true)

    bullet.set_pos(get_pos())
    bullet.setup(true, self, bullet_time, degree, bullet_speed)

func on_bullet_death(bullet):
  get_parent().call_deferred("remove_child",bullet)
  dead_bullets.push_back(bullet)
