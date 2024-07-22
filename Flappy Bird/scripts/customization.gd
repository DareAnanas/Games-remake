extends Control


@onready var difficulty_label = $MarginContainer/VBoxContainer/DifficultyLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	var difficulty = Global.readDifficulty();
	
	difficulty_label.text = "Difficulty: " + difficulty


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_change_difficulty_pressed():
	get_tree().change_scene_to_file("res://scenes/difficulty_change_menu.tscn")

func _on_skins_button_pressed():
	get_tree().change_scene_to_file("res://scenes/skins.tscn");

func goToMenu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_back_pressed():
	goToMenu();


