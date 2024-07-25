extends Area2D

@onready var root = $"../../../root"

func _on_body_entered(body):
	root.gameOverMenu()

func _ready():
	var pipe_skin = Global.readPipeSkin();
	
	changeSkinToScene(pipe_skin);

func changeSkinToScene(scene_name):
	var path_placeholder = "res://skins/%s.tscn";
	
	var scene_path = path_placeholder % scene_name;
	
	for child in get_children():
		if child.get_class() == "Sprite2D":
			remove_child(child);
	var skin_scene = load(scene_path);
	var skin = skin_scene.instantiate();
	add_child(skin);
