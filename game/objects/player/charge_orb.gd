extends Sprite

onready var time = 0

var center

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
  time += delta
  time = fmod(time, 2.0 * PI)
  set_pos(center.get_pos() + 16 * Vector2(cos(time*5), sin(time*5)))
