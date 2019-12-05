extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_node("Player")
	# Tutorial 1
	if (has_node("jump1")):
		if((player.position.x < 200) && (player.position.y > 160)):
			get_node("jump1").visible = true;
			get_node("jump2").visible = false;
		elif((player.position.x > 200) && (player.position.y > 160)):
			get_node("jump1").visible = false;
			get_node("jump2").visible = true;
		else:
			get_node("jump1").visible = false;
			get_node("jump2").visible = false;
	# Tutorial 2
	if (has_node("wall1")):
		if((player.position.x > 400) && (player.position.y > 180)):
			get_node("wall1").visible = true;
			get_node("wall2").visible = false;
		elif((player.position.x > 100) && (player.position.x < 250) && (player.position.y > 100)):
			get_node("wall1").visible = false;
			get_node("wall2").visible = true;
		else:
			get_node("wall1").visible = false;
			get_node("wall2").visible = false;
	# Tutorial 3
	if (has_node("dash1")):
		if((player.position.x < 200) && (player.position.y > 200)):
			get_node("dash1").visible = true;
			get_node("dash2").visible = false;
		elif((player.position.x < 400) && (player.position.y < 180)):
			get_node("dash1").visible = false;
			get_node("dash2").visible = true;
		else:
			get_node("dash1").visible = false;
			get_node("dash2").visible = false;
	# Tutorial 4
	if (has_node("hazard1")):
		if((player.position.x < 500) && (player.position.y < 180)):
			get_node("hazard1").visible = true;
			get_node("hazard2").visible = false;
			get_node("hazard3").visible = false;
			get_node("hazard4").visible = false;
		elif((player.position.x > 500) && (player.position.y < 180)):
			get_node("hazard1").visible = false;
			get_node("hazard2").visible = true;
			get_node("hazard3").visible = false;
			get_node("hazard4").visible = false;
		elif((player.position.x > 300) && (player.position.y > 180)):
			get_node("hazard1").visible = false;
			get_node("hazard2").visible = false;
			get_node("hazard3").visible = true;
			get_node("hazard4").visible = false;
		elif((player.position.x < 300) && (player.position.y > 180)):
			get_node("hazard1").visible = false;
			get_node("hazard2").visible = false;
			get_node("hazard3").visible = false;
			get_node("hazard4").visible = true;
		else:
			get_node("hazard1").visible = false;
			get_node("hazard2").visible = false;
			get_node("hazard3").visible = false;
			get_node("hazard4").visible = false;
	# Tutorial 5
	if (has_node("ai1")):
		if((player.position.x > 200) && (player.position.y < 180)):
			get_node("ai1").visible = true;
			get_node("ai2").visible = false;
			get_node("ai3").visible = false;
		elif((player.position.x < 300) && (player.position.y > 180)):
			get_node("ai1").visible = false;
			get_node("ai2").visible = true;
			get_node("ai3").visible = false;
		elif((player.position.x > 300) && (player.position.y > 180)):
			get_node("ai1").visible = false;
			get_node("ai2").visible = false;
			get_node("ai3").visible = true;
		else:
			get_node("ai1").visible = false;
			get_node("ai2").visible = false;
			get_node("ai3").visible = false;
