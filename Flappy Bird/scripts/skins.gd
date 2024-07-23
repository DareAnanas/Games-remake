extends Control

@onready var option_button = $MarginContainer/VBoxContainer/OptionButton

var skins_id = {
	0: "flappy_bird_skin",
	1: "reimu_fumo_skin"
}

func _ready():
	var skin = Global.readSkin();
	
	for id in skins_id:
		var skin_name = skins_id[id];
		if skin_name == skin:
			option_button.selected = id;
	
func writeSkin(skin_scene_name):
	var config = ConfigFile.new();
	
	config.set_value("Customization", "skin", skin_scene_name);
	
	config.save("user://skins.cfg");

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/customization.tscn");


func _on_option_button_item_selected(index):
	print(index);
	writeSkin(skins_id[index]);
