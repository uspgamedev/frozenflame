extends StreamPlayer

export(AudioStream) var other

func change_theme():
  var temp = get_stream()
  set_stream(other)
  other = temp
