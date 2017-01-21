
extends Node2D

const Portal = preload("res://maps/portal.gd")

onready var cam = Camera2D.new()
onready var input = get_node("input")
onready var map = get_node("Map")
onready var hero = map.get_node("Bodies/Hero")
onready var fader = get_node("Fader")
onready var death_panel = get_node("HUD/DeathPanel")
onready var music_player = get_node("MusicPlayer")

onready var fail_sfx = death_panel.get_node("SFX")

var map_scene =  preload("res://maps/stage01/map.tscn")
var last_entry_point = "Entrance"

func _ready():
  cam.make_current()
  connect_all()
  set_process(true)
  death_panel.hide()
  fader.fade_in()

func connect_all():
  music_player.play()
  if not hero.is_a_parent_of(cam):
    hero.add_child(cam)
  input.connect("hold_direction", hero, "_move_to")
  input.connect("press_quit", self, "_quit")
  input.connect("press_action", hero, "_act")
  hero.connect("died", self, "player_died")
  for portal in map.get_node("Bodies").get_children():
    if portal.get_script() == Portal:
      portal.connect("teleport", self, "_on_teleport")

func disconnect_all(detach_camera):
  if detach_camera:
    hero.remove_child(cam)
  input.disconnect("hold_direction", hero, "_move_to")
  input.disconnect("press_quit", self, "_quit")
  input.disconnect("press_action", hero, "_act")
  hero.disconnect("died", self, "_quit")
  for portal in map.get_node("Bodies").get_children():
    if portal.get_script() == Portal:
      portal.disconnect("teleport", self, "_on_teleport")

func _on_teleport(path, entry_point):
  fader.fade_out()
  yield(fader, "done_fade_out")
  last_entry_point = entry_point
  disconnect_all(true)
  yield(get_tree(), "fixed_frame")
  remove_child(map)
  yield(get_tree(), "fixed_frame")
  map_scene = load(path)
  map = map_scene.instance()
  add_child(map)
  hero = map.get_node("Bodies/Hero")
  var entry = map.get_node("Bodies/" + last_entry_point)
  hero.set_pos(entry.get_pos())
  connect_all()
  fader.fade_in()

func _quit():
    get_tree().quit()

func get_hero():
    return hero

func player_died():
  printt("died")
  disconnect_all(false)
  input.connect("press_action", self, "death_panel_action")
  yield(hero.get_node("sprite/animation"), "finished")
  death_panel.show()
  music_player.stop()
  fail_sfx.play()

func death_panel_action(act):
  if act == 0:
    hero.remove_child(cam)
    remove_child(map)
    yield(get_tree(), "fixed_frame")
    map = map_scene.instance()
    add_child(map)
    var bodies = map.get_node("Bodies")
    var entry = bodies.get_node(last_entry_point)
    hero = bodies.get_node("Hero")
    hero.set_pos(entry.get_pos())
    death_panel.hide()
    input.disconnect("press_action", self, "death_panel_action")
    connect_all()
