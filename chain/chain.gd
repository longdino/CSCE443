extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const LOOP = preload("res://chain/loop.tscn")
const LINK = preload("res://chain/link.tscn")
const ANCH = preload("res://chain/anchor.tscn")

export (int) var loops = 8
export (int) var dist = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = $anchor
	for i in range (loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
		
func addLoop(parent):
	var loop = LOOP.instance()
	loop.position = parent.position
	loop.position.y += dist
	add_child(loop)
	return loop
	
func addLink(parent, child):
	var pin = LINK.instance()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)

func addEndAnchor(parent):
	var anch = ANCH.instance()
	anch.position = parent.position
	anch.position.y += dist
	add_child(anch)
	addLink(parent, anch)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
