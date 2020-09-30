extends GraphEdit

onready var graph_node = preload("res://questStepNode.tscn")
onready var entry_node = preload("res://quest_entry.tscn")
var qName
var saveDir = "res://quests/" # make a better save dir for release

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _new_quest_selected(quest):
	#print("QG Triggered")
	# save the current quest if there is one
	if qName:
		save()
	qName = quest.text + ".qst"
	#print(qName)
	load_save()
	
	var objBox = get_node("../../ParentVBox/ObjListVBox")
	# clear children
	for child in objBox.get_children():
		child.queue_free()
	var ends = get_ends()
	for end in ends:
		var entry = entry_node.instance()
		print(entry)
		# Add an entry to the objListVbox
		objBox.add_child(entry)
		entry.assoc_node = end
		entry.get_node("HBoxContainer/quest_name").text = end.get_node("TextEdit").text
		# TODO: set up text updating beyond quest switch
			# connect end's TextEdit's on text changed to method in entry?
		# checkbox to delete node

func get_ends():
	var ends = []
	var begs = []
	for conn in get_connection_list():
		if not conn["from"] in begs:
			begs.append(conn["from"])
		if not conn["to"] in begs and not conn["to"] in ends:
			ends.append(conn["to"])
	for node in ends:
		if node in begs:
			ends.erase(node)
	var enodes = []
	for end in ends:
		enodes.append(get_node(end))
	return(enodes)

func _name_changed(title):
	#directory change name of old name to new name
	var dir = Directory.new()
	if dir.open(saveDir) == OK:
		dir.rename(qName, title.text + ".qst")
		qName = title.text + ".qst"

func save():
	var save_quest = File.new()
	if qName.is_valid_filename():
		save_quest.open(saveDir + qName, File.WRITE)
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
	else:
		print("Cannot be saved.")

func load_save():
	var save_quest = File.new()
	if not save_quest.file_exists(saveDir + qName):
		return
	
	for c in get_children():
		if c is GraphNode:
			c.free()
	
	# Put the nodes on the graph...
	save_quest.open(saveDir + qName, File.READ)
	print("Openned " + saveDir + qName)
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
