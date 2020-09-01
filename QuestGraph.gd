extends GraphEdit

onready var graph_node = preload("res://questStepNode.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_save()

func save():
	var save_quest = File.new()
	# get name from parent later
	save_quest.open("res://qname.qst", File.WRITE)
	var node_data = []
	for c in get_children():
		if c is GraphNode:
			node_data.append({"name": c.name,
								"offset_x": c.get_offset().x,
								"offset_y": c.get_offset().y,
								"size_x": c.get_rect().size.x,
								"size_y": c.get_rect().size.y,
								"data": c.get_data()})
	var data = {"connections": get_connection_list(), "nodes": node_data}
	save_quest.store_line(to_json(data))
	save_quest.close()
	print("saved!")

func load_save():
	var save_quest = File.new()
	if not save_quest.file_exists("res://qname.qst"):
		return
	
	for c in get_children():
		if c is GraphNode:
			c.free()
	
	# Put the nodes on the graph...
	save_quest.open("res://qname.qst", File.READ)
	var save_data = parse_json(save_quest.get_line())
	for node in save_data["nodes"]:
		var graph_node_instance = graph_node.instance()
		graph_node_instance.set_size(Vector2(float(node["size_x"]), float(node["size_y"])))
		add_child(graph_node_instance)
		graph_node_instance.name = node["name"]
		graph_node_instance.set_offset(Vector2(float(node["offset_x"]), float(node["offset_y"])))
		graph_node_instance.set_data(node["data"])
	
	# Connect them up..
	for conn in save_data["connections"]:
		connect_node(conn["from"], conn["from_port"], conn["to"], conn["to_port"])
	save_quest.close()
	print("loaded!")

func get_connections(node_name):
	var ret = {"left": [], "right": []}
	for conn in get_connection_list():
		if node_name == conn["from"]: ret["right"].append(conn["to"])
		elif node_name == conn["to"]: ret["left"].append(conn["from"])
	return ret

func disconnect_connections_of_node(node_name):
	var conn = get_connections(node_name)
	for c in conn["left"]: disconnect_node(c, 0, node_name, 0)
	for c in conn["right"]: disconnect_node(node_name, 0, c, 0)
	save()

func _on_QuestGraph_delete_nodes_request():
	for c in get_children():
		if c is GraphNode and c.is_selected():
			disconnect_connections_of_node(c.name)
			c.queue_free()


func _on_QuestGraph_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)
	save()


func _on_QuestGraph_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)
	save()


func _on_QuestGraph_connection_to_empty(from, from_slot, release_position):
	var new_node = graph_node.instance()
	new_node.set_offset(release_position-Vector2(0, new_node.rect_size.y/2))
	add_child(new_node)
	connect_node(from, from_slot, new_node.name, 0)
	save()

func _on_QuestGraph__end_node_move():
	save()
