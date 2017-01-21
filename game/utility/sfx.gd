extends SamplePlayer2D

export(Sample) var sample

func _ready():
	get_sample_library().add_sample("main", sample)

func play():
  .play("main")
