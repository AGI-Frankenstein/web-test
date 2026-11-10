extends Control

@onready var node = $Node2D
@onready var ClrPickerBttn: ColorPickerButton = $ColorPickerButton
var color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = Color.BLACK
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var size: Vector2 = get_global_rect().size
	var offset: Vector2 = get_global_rect().position
	var img: Image = get_parent().get_texture().get_image()
	color = ClrPickerBttn.color

func _find_canvas_layer(node: Node) -> Node:
	var current = node
	while current != null:
		if current is CanvasLayer:
			return current
		current = current.get_parent()
	return null

func get_color() -> Color:
	return color
	
