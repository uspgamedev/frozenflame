extends Node

onready var waypoints = get_node("Waypoints").get_children()

export(NodePath) var object_path
export(float) var speed = 1.0
var current_wp = 0
var foward = true
var object

func _ready():
	object = get_node(object_path)
	object.set_global_pos(waypoints[current_wp].get_global_pos())

func start():
	set_fixed_process(true)

func get_next_waypoint():
	if abs(object.get_global_pos().distance_to(waypoints[current_wp].get_global_pos())) < 5:
		#go next wp
		if foward:
			current_wp += 1
			if current_wp >= waypoints.size():
				foward = false
				current_wp -= 1
		else:
			current_wp -= 1
			if current_wp < 0:
				foward = true
				current_wp += 1
	
	return waypoints[current_wp]
	
func _fixed_process(delta):
	var target = get_next_waypoint()
	var direction = (target.get_pos() - object.get_pos()).normalized() * speed * delta
	object.move(direction)
	

func _on_Timer_timeout():
	start()
