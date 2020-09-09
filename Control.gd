extends Control

var quest_entry
var obj_list
var journal
var quest_list
var activeQuest
var qHead
#var list_dragging
#var list_box

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
#	list_box = get_node("ParentVBoX")
	obj_list = get_node("ParentVBoX/ObjListVBox")
	quest_entry = load("res://quest_entry.tscn")
	quest_list = get_node("Journal/questScroller/questNames")
	journal = get_node("Journal")
	get_node("MascotViewContainer/InteractionMenu").get_popup().connect("id_pressed", self, "_on_interact")
	var qList = quest_list.get_children()
	if len(qList) < 1:
		_on_add_button_pressed()
		qList = quest_list.get_children()
	activeQuest = qList[0]
	qHead = get_node("Journal/questHeader")
	qHead.connect("text_changed", get_node("Journal/QuestGraph"), "_name_changed", [qHead])
	activeQuest.emit_signal("pressed")

# Add a quest
func _on_add_button_pressed():
	var newTitle = Button.new()
	newTitle.text = "Quest Name"
	quest_list.add_child(newTitle)
	newTitle.connect("pressed", self, "_on_quest_selected", [newTitle])
	newTitle.connect("pressed", get_node("Journal/QuestGraph"), "_new_quest_selected", [newTitle])

# Interaction Menu Spawned
func _on_interact(id):
	if(id == 1):
		get_tree().quit()
	if(id == 0):
		journal.visible = !journal.visible

# TODO make the quest list draggable
#func _on_ParentVBoX_gui_input(event):
#	get_node("ParentVBoX/TitleHBox/objective_label").text = event.as_text()
#	if(event == InputEventMouseButton):
#		if(event.is_pressed() && event.get_button_index() == BUTTON_LEFT):
#			list_box.hide()
			#list_dragging = true
			#list_relative = quest_list.rect_position - event.position
	#	if(!event.is_pressed() && event.get_button_index() == BUTTON_LEFT):
	#		list_dragging = false
	#if(event.type == InputEventMouseMotion):
	#	if(list_dragging):
	#		list_box._set_position(list_box.get_position() + event.get_relative())

func _on_quest_selected(quest):
	activeQuest = quest
	qHead.text = quest.text
	# update name of file to be saved to
	# load quest file

func _on_questHeader_text_changed():
	# Set the currently active quest's name to contents
	activeQuest.text = qHead.text
	# change name of save file
	# update name file to be saved to

