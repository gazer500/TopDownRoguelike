extends TextDisplay
class_name Sign

@export var text := "";

func _ready():
	if label != null:
		label.text = text
	super._ready()
