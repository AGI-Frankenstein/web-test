extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button_pressed:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.can_move = true
		TaskManager.complete_task_by_type("whiteboard")
		await get_tree().create_timer(1).timeout
		Input.set_custom_mouse_cursor(load("res://assets/icons/cursor.png"))
		
		# TODO fix better lmao
		$"../../../../..".queue_free()
	pass
