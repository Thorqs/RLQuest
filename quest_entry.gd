extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var assoc_node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CheckBox_pressed():
	assoc_node.selected = true
	assoc_node.emit_signal("close_request")
	queue_free()
