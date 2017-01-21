
extends Node2D

const Portal = preload("res://maps/portal.gd")

onready var maps = {}
onready var cam = Camera2D.new()
onready var input = get_node("input")
onready var map = get_node("Map")
onready var hero = map.get_node("Bodies/Hero")
onready var death_panel = get_node("HUD/DeathPanel")

var last_entry_point = "Entrance"

func _ready():
  maps["res://maps/stage01/map.tscn"] = map
  cam.make_current()
  connect_all()
  set_process(true)
  death_panel.hide()

func connect_all():
  hero.add_child(cam)
  input.connect("hold_direction", hero, "_move_to")
  input.connect("press_quit", self, "_quit")
  input.connect("press_action", hero, "_act")
  if is_connected("press_action", self, "death_panel_action"):
    input.disconnect("press_action", self, "death_panel_action")
  hero.connect("died", self, "player_died")
  for portal in map.get_node("Bodies").get_children():
    if portal.get_script() == Portal:
      portal.connect("teleport", self, "_on_teleport")

func disconnect_all():
  hero.remove_child(cam)
  input.disconnect("hold_direction", hero, "_move_to")
  input.disconnect("press_quit", self, "_quit")
  input.disconnect("press_action", hero, "_act")
  if is_connected("press_action", self, "death_panel_action"):
    input.disconnect("press_action", self, "death_panel_action")
  hero.disconnect("died", self, "_quit")
  for portal in map.get_node("Bodies").get_children():
    if portal.get_script() == Portal:
      portal.disconnect("teleport", self, "_on_teleport")

func _on_teleport(path, entry_point):
  print("teleport!")
  last_entry_point = entry_point
  disconnect_all()
  yield(get_tree(), "fixed_frame")
  remove_child(map)
  yield(get_tree(), "fixed_frame")
  if maps.has(path):
    map = maps[path]
  else:
    map = load(path).instance()
    maps[path] = map
  add_child(map)
  hero = map.get_node("Bodies/Hero")
  var entry = map.get_node("Bodies/" + last_entry_point)
  hero.set_pos(entry.get_pos())
  connect_all()

func _quit():
    get_tree().quit()

func get_hero():
    return hero

func player_died():
	printt("died")
	death_panel.popup_centered()

func death_panel_action(act):
	printt("death_panel_action", act)
	if act == 0:
		disconnect_all()
		yield(get_tree(), "fixed_frame")
		remove_child(map)
		yield(get_tree(), "fixed_frame")
		add_child(map)
		var entry = map.get_node("Bodies/" + last_entry_point)
		hero = map.get_node("Bodies/Hero")
		hero.set_pos(entry.get_pos())
		connect_all()
		if is_connected("press_action", self, "death_panel_action"):
			input.disconnect("press_action", self, "death_panel_action")
		death_panel.hide()
	else:
		_quit()

func _on_DeathPanel_about_to_show():
	input.disconnect("press_action", hero, "_act")
	input.disconnect("hold_direction", hero, "_move_to")
	input.connect("press_action", self, "death_panel_action")
