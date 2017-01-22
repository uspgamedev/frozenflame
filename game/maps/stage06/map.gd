extends TileMap

onready var enemy1 = get_node("Bodies/EnemyIce1")
onready var enemy2 = get_node("Bodies/EnemyIce2")
onready var enemy3 = get_node("Bodies/EnemyIce3")
onready var enemy4 = get_node("Bodies/EnemyIce4")

func _ready():
	enemy1.connect("destroyed", self, "check_statues")
	enemy2.connect("destroyed", self, "check_statues")
	enemy3.connect("destroyed", self, "check_statues")
	enemy4.connect("destroyed", self, "check_statues")


func check_statues():
	if enemy1.destroyed and enemy2.destroyed and enemy3.destroyed and enemy4.destroyed:
		get_node("Paths/PathFollowFP1").start()
		get_node("Paths/PathFollowFP3").start()