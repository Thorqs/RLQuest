extends GraphEdit

onready var graph_node = preload("res://questStepNode.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_connections(node_name):
	var ret = {"left": [], "right": []}
	for conn in get_connection_list():
		if node_name == conn["from:"]: ret["right"].append(conn["to"])
		elif node_name == conn["to:"]: ret["right"].append(conn["from"])

func _on_QuestGraph_delete_nodes_request():
	for c in get_children():
		if c is GraphNode and c.is_selected():
			c.queue_free()


func _on_QuestGraph_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)


func _on_QuestGraph_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)


func _on_QuestGraph_connection_to_empty(from, from_slot, release_position):
	var new_node = graph_node.instance()
	new_node.set_offset(release_position-Vector2(0, new_node.rect_size.y/2))
	add_child(new_node)
	connect_node(from, from_slot, new_node.name, 0)
