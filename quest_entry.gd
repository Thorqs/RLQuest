extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var q_name
var qd_name
var q_panel


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	q_name = get_node("quest_name")
	qd_name = get_node("quest_panel/q_step_name")
	q_panel = get_node("quest_panel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_q_step_name_text_changed():
	q_name.text = qd_name.text


func _on_EditButton_pressed():
	q_panel.visible = !q_panel.visible


func _on_CheckBox_pressed():
	queue_free()
