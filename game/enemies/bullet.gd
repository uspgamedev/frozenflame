extends KinematicBody2D

const BulletScene = preload("res://enemies/bullet.tscn")
const Player = preload("res://objects/player/hero.gd")

var is_fire = false
var enemy
var time = 100
var direction = 0
var speed = 1
var step


onready var ice_view
onready var fire_view

signal hit(object)
signal on_death(bullet)

func fire():
    set_process(true)

static func create():
	var bullet = BulletScene.instance()
	return bullet

func setup(is_fire, enemy, time, direction, speed):
	self.is_fire = is_fire
	self.enemy = enemy
	self.time = time
	self.direction = deg2rad(direction)
	self.speed = speed
	
	if is_fire:
		ice_view.hide()
		fire_view.show()
	else:
		ice_view.show()
		fire_view.hide()
	set_fixed_process(true)
	
func _ready():
	ice_view = get_node("IceView")
	fire_view = get_node("FireView")

func _fixed_process(delta):
	var step = Vector2(speed * sin(direction), speed * cos(direction))
	move(step * delta)
	self.time -= delta
	if self.time <= 0:
		emit_signal("on_death", self)

func _on_CollisionArea_body_enter( body ):
	# Do not kill fire bullets when they hit the player
	if not (is_fire and (body extends Player)):
		emit_signal("on_death", self)

	if ( not is_fire ) and ( body extends Player ):
		body.kill()

func _enter_tree():
	get_node("CollisionArea").set_enable_monitoring(true)
	
func _exit_tree():
	get_node("CollisionArea").set_enable_monitoring(false)
	