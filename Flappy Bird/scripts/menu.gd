extends Control

@onready var difficulty_label = $MarginContainer/VBoxContainer/DifficultyLabel

func _ready():
	var difficulty = Global.readDifficulty();
	
	difficulty_label.text = "Difficulty: " + difficulty

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	

func _on_change_difficulty_pressed():
	get_tree().change_scene_to_file("res://scenes/difficulty_change_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


