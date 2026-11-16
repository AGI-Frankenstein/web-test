extends Control

@onready var node = $SubViewportContainer/SubViewport/Node2D
@onready var ClrPickerBttn: ColorPickerButton = $ColorPickerButton
@onready var svp = $SubViewportContainer/SubViewport
@onready var bttns: Array[Button]
@onready var btn1 = $Color1Button
@onready var btn2: Button = $Color2Button
@onready var btn3: Button = $Color3Button
@onready var btnEraser: Button = $EraserToggle
@onready var btnUndo: Button = $UndoButton

var color: Color
var roundcolor: Array[Color]

func _ready() -> void:
	color = Color.BLACK # Setting default color
	
	roundcolor = randomize_round_colors(3) # randomizes colors for the round and appends white background for eraser tool
	roundcolor.append(Color.WHITE)
	roundcolor.append(Color.WHITE)
	
	bttns.append(btn1) # Adds all buttons to array
	bttns.append(btn2)
	bttns.append(btn3)
	bttns.append(btnEraser)
	bttns.append(btnUndo)
	_resize_to_screen() # Resizes for the device screen size, adjust button positions and also changes button backgrounds
	pass 

func _process(_delta: float) -> void:
	var sz = get_viewport().get_visible_rect().size
	if (sz[0] > sz[1]):
		_resize_to_screen()
	pass

func randomize_round_colors(size: int) -> Array[Color]:
	# TODO: randomize and return the selected rounds colors
	return [Color.BLACK, Color.BLUE, Color.RED]

func submit_image() -> void:
	# Function that passes the img to the server
	# TODO: add exporting the set image for processing, will need to filter white to transparent 
	# If we are displaying bones for drawing, should we remove them or keep them in the final monster? 
	# If remove, add full transparency to the bone before grabbing the img 
	var img: Image = svp.get_texture().get_image()
	var pkd: PackedByteArray = img.get_data() # This image "Should" be what is on the drawing space

	var tex: Image = Image.create_from_data(10, 10, true, Image.Format.FORMAT_ASTC_4x4, pkd)
	print(type_string(typeof(tex)))
	print(type_string(typeof(img)))
	print(img)
	print(tex)
	return

func _resize_to_screen() -> void:
	var sz = get_viewport().get_visible_rect().size
	var buttonsizes = sz[1]*0.15
	# here
	sz[1] = sz[1]*0.8
	svp.size = sz
	for button in bttns:
		button.size[0] = buttonsizes
		button.size[1] = buttonsizes
	for i in range(bttns.size()):
		bttns[i].position[0] = i * buttonsizes + buttonsizes/6 * (i + 1)
		bttns[i].position[1] = sz[1] + buttonsizes/6
		_change_button_background(roundcolor[i], bttns[i])
	
func _change_button_background(col: Color, btn: Button) -> void:
	var style = btn.get_theme_stylebox("normal").duplicate()
	style.bg_color = col
	btn.add_theme_stylebox_override("normal", style)

func _find_canvas_layer(cur: Node) -> Node:
	var current = cur
	while current != null:
		if current is CanvasLayer:
			return current
		current = current.get_parent()
	return null

func get_color() -> Color:
	return color

### Signals ###

func _on_color_1_button_pressed() -> void:
	color = roundcolor[0]
	submit_image()

func _on_color_2_button_pressed() -> void:
	color = roundcolor[1]

func _on_color_3_button_pressed() -> void:
	color = roundcolor[2]

func _on_eraser_toggle_pressed() -> void:
	color = roundcolor[3]