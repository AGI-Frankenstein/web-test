extends CanvasLayer

@export var _tutorialtext: String = "Pick up the eraser and make the whiteboard squeaky clean"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_tutorial_text():
	return _tutorialtext
