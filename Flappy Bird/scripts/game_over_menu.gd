extends Control

@onready var root = $"../../root"


func _on_restart_pressed():
	root.gameOverMenu();
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_menu_pressed():
	root.gameOverMenu();
	get_tree().change_scene_to_file("res://scenes/menu.tscn");


