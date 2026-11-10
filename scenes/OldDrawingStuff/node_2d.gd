extends Node2D

@onready var _lines:Node2D = $Line2D
@onready var _ctrl: = get_parent()

var _pressedright: bool = false
var _pressedleft: bool = false
var _current_line: Line2D = null
var _eraser: bool = false
var _selected_color: Color = Color.BLUE

func _input(event: InputEvent) -> void:
	_get_active_color()
	
	if event is InputEventScreenTouch:
		_pressedleft = event.pressed
		if _pressedleft:
			_current_line = Line2D.new()
			_current_line.default_color = _selected_color
			_current_line.width = 12
			_lines.add_child(_current_line)
			_current_line.add_point(event.position)
	elif event is InputEventScreenDrag and _pressedleft and _eraser:
		_current_line.add_point(event.position)

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressedright = event.pressed
			if _pressedright:
				_current_line = Line2D.new()
				_current_line.default_color = _selected_color
				_current_line.width = 2
				_lines.add_child(_current_line)
				_current_line.add_point(event.position)
	elif event is InputEventMouseMotion and _pressedright:
		_current_line.add_point(event.position)
	
func _get_active_color() -> void:
	_selected_color = _ctrl.get_color()

#func _ready() -> void:
	#pass 

#func _process(delta: float) -> void:
	#pass
