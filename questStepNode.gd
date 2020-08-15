extends GraphNode

onready var text_edit = $TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	text_edit.set_custom_minimum_size(Vector2(-1, get_rect().size.y-5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_questStepNode_close_request():
	queue_free()
	



func _on_questStepNode_resize_request(new_size):
	var graph = get_parent()
	if graph.has_method("is_using_snap") and graph.is_using_snap():
		var snap = graph.get_snap()
		rect_size.x = int(new_size.x/snap)*snap
		rect_size.y = int(new_size.y/snap)*snap
	else:
		rect_size = new_size
	text_edit.set_custom_minimum_size(Vector2(-1, rect_size.y-35))
