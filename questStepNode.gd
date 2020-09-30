extends GraphNode

onready var text_edit = $TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	text_edit.set_custom_minimum_size(Vector2(-1, get_rect().size.y-30))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_questStepNode_close_request():
	get_parent().disconnect_connections_of_node(name)
	queue_free()
	get_parent().save()

func _on_questStepNode_resize_request(new_size):
	var graph = get_parent()
	if graph.has_method("is_using_snap") and graph.is_using_snap():
		var snap = graph.get_snap()
		rect_size.x = int(new_size.x/snap)*snap
		rect_size.y = int(new_size.y/snap)*snap
	else:
		rect_size = new_size
	text_edit.set_custom_minimum_size(Vector2(-1, get_rect().size.y-30)) # find a better solution
	get_parent().save()

func _on_TextEdit_focus_entered():
	get_parent().set_selected(self)

func get_data():
	return{"text": text_edit.text}

func set_data(data):
	text_edit.text = data["text"]


func _on_TextEdit_text_changed():
	get_parent().save()
