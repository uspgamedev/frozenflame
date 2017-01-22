extends TileMap

const Player = preload("res://objects/player/hero.gd")

func _on_trigger1_body_enter( body ):
	if not body extends Player:
		return
	get_node("Bodies/Enemies/EnemyIce").stop_waves()
	get_node("Bodies/Enemies/EnemyIce1").stop_waves()
	
	get_node("Bodies/Enemies/EnemyIce2").start_waves()
	get_node("Bodies/Enemies/EnemyIce3").start_waves()
	get_node("Bodies/Enemies/EnemyIce4").start_waves()


func _on_trigger2_body_enter( body ):
	if not body extends Player:
		return
	get_node("Bodies/Enemies/EnemyIce2").stop_waves()
	get_node("Bodies/Enemies/EnemyIce3").stop_waves()
	get_node("Bodies/Enemies/EnemyIce4").stop_waves()
	
	get_node("Bodies/Enemies/EnemyIce5").start_waves()
	get_node("Bodies/Enemies/EnemyIce6").start_waves()
	get_node("Bodies/Enemies/EnemyIce7").start_waves()
	get_node("Bodies/Enemies/EnemyIce8").start_waves()


func _on_trigger3_body_enter( body ):
	if not body extends Player:
		return
	get_node("Bodies/Enemies/EnemyIce5").stop_waves()
	get_node("Bodies/Enemies/EnemyIce6").stop_waves()
	get_node("Bodies/Enemies/EnemyIce7").stop_waves()
	get_node("Bodies/Enemies/EnemyIce8").stop_waves()
	
	get_node("Bodies/Enemies/EnemyIce9").start_waves()
	get_node("Bodies/Enemies/EnemyIce10").start_waves()
	get_node("Bodies/Enemies/EnemyIce11").start_waves()
	get_node("Bodies/Enemies/EnemyIce12").start_waves()


func _on_trigger4_body_enter( body ):
	get_node("Bodies/Enemies/EnemyIce13").start_waves()
	get_node("Bodies/Enemies/EnemyIce14").start_waves()
	get_node("Bodies/Enemies/EnemyIce15").start_waves()


func _on_trigger5_body_enter( body ):
	get_node("Bodies/Enemies/EnemyIce9").stop_waves()
	get_node("Bodies/Enemies/EnemyIce10").stop_waves()
	get_node("Bodies/Enemies/EnemyIce11").stop_waves()
	get_node("Bodies/Enemies/EnemyIce12").stop_waves()
