extends KinematicBody2D

const BulletScene = preload("res://enemies/bullet.tscn")

var enemy
var distance = 100
var direction = 0
var speed = 1
var step

signal hit(object)
signal on_death(bullet)

func fire():
    set_process(true)

static func create(enemy, distance, direction, speed):
	var bullet = BulletScene.instance()
	bullet.enemy = enemy
	bullet.distance = distance
	bullet.direction = direction
	bullet.speed = speed

	return bullet

func reset(enemy, distance, direction, speed):
	self.enemy = enemy
	self.distance = distance
	self.direction = direction
	self.speed = speed

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var step = Vector2(speed * sin(direction), speed * cos(direction))
	move(step * delta)
	if self.get_pos().distance_to(enemy.get_pos()) > distance:
		emit_signal("on_death", self)

func _on_CollisionArea_body_enter( body ):
	printt("hit")
	emit_signal("hit", body)
	queue_free()
