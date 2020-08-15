extends Control

var quest_entry
var quest_list
var journal
#var list_dragging
#var list_box

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
#	list_box = get_node("ParentVBoX")
	quest_list = get_node("ParentVBoX/QuestListVBox")
	quest_entry = load("res://quest_entry.tscn")
	journal = get_node("Journal")
	get_node("MascotViewContainer/InteractionMenu").get_popup().connect("id_pressed", self, "_on_interact")

# Add a quest
func _on_add_button_pressed():
	quest_list.add_child(quest_entry.instance())

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

