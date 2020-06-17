extends Control


var quest_entry
var quest_list

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	quest_list = get_node("ParentVBoX/QuestListVBox")
	quest_entry = load("res://quest_entry.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_add_button_pressed():
	quest_list.add_child(quest_entry.instance())

