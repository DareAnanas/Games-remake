extends Control

@onready var option_button = $MarginContainer/VBoxContainer/OptionButton
@onready var option_button_2 = $MarginContainer/VBoxContainer/OptionButton2

var skins_id = {
	0: "flappy_bird_skin",
	1: "reimu_fumo_skin"
}

var pipe_skins_id = {
	0: "pipe_skin",
	1: "hakurei_shrine(basement)_skin"
}

func _ready():
	var skin = Global.readSkin();
	
	for id in skins_id:
		var skin_name = skins_id[id];
		if skin_name == skin:
			option_button.selected = id;
	
	var pipeSkin = Global.readPipeSkin();
	
	for id in pipe_skins_id:
		var skin_name = pipe_skins_id[id];
		if skin_name == pipeSkin:
			option_button_2.selected = id;
	
func writeSkin(skin_scene_name):
	var config = ConfigFile.new();
	
	config.set_value("Customization", "skin", skin_scene_name);
	
	config.save("user://skins.cfg");
	
func writePipeSkin(skin_scene_name):
	var config = ConfigFile.new();
	
	config.set_value("Customization", "pipe_skin", skin_scene_name);
	
	config.save("user://pipe_skins.cfg");

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/customization.tscn");


func _on_option_button_item_selected(index):
	writeSkin(skins_id[index]);


func _on_option_button_2_item_selected(index):
	writePipeSkin(pipe_skins_id[index]);
