extends Node2D

# built from the example code in the godot documentation: https://docs.godotengine.org/en/stable/tutorials/networking/websocket.html

# `wss://` is used for secure connections,
# while `ws://` is used for plain text (insecure) connections.
@export var websocket_url = "localhost:7777"

var socket = WebSocketPeer.new()

func _ready():
	join_server()

func join_server():
	socket.set_outbound_buffer_size(5790208)
	var err = socket.connect_to_url(websocket_url)
	if err == OK:
		print("Connecting to %s..." % websocket_url)
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout
		
		set_process(true)
	else:
		push_error("Unable to connect.")
		set_process(false)

func send_image(bytes, width, height):
	#var compressed = bytes.compress()
	socket.send_text(str(width) + ":" + str(height))
	socket.send(bytes)

func _process(_delta):

	# update data transfers and socket state
	socket.poll()

	var state = socket.get_ready_state()

	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packet = socket.get_packet()
			if socket.was_string_packet():
				var packet_text = packet.get_string_from_utf8()
				print("< Got text data from server: %s" % packet_text)
			else:
				print("< Got binary data from server: %d bytes" % packet.size())

	# socket is closing, keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# socket has fully closed
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be `-1` if the disconnection was not properly notified by the remote peer.
		var code = socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false)
