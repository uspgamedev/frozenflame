extends KinematicBody2D

const BulletScene = preload("res://enemies/bullet.tscn")

var enemy
var distance = 100
var direction = 0
var speed = 1
var step

onready var collision = get_node("View/Body/Collision")

signal hit(object)

func fire():
    set_process(true)

static func create(enemy, distance, direction, speed):
	var bullet = BulletScene.instance()
	bullet.enemy = enemy
	bullet.distance = distance
	bullet.direction = direction
	bullet.speed = speed

	return bullet

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var step = Vector2(speed * sin(direction), speed * cos(direction))
	printt(test_move(step * delta))
	move(step * delta)
	if self.get_pos().distance_to(enemy.get_pos()) > distance:
		queue_free()

func _on_CollisionArea_body_enter( body ):
	printt("hit")
	emit_signal("hit", body)
