extends Control


func goToMenu():
	get_tree().change_scene_to_file("res://scenes/customization.tscn")

func _on_back_pressed():
	goToMenu();

func writeDifficulty(difficulty):
	var config = ConfigFile.new();
	
	config.set_value("Game", "difficulty", difficulty);
	
	config.save("user://difficulty.cfg");

func _on_easy_pressed():
	writeDifficulty("easy");
	goToMenu();

func _on_normal_pressed():
	writeDifficulty("normal");
	goToMenu();

func _on_hard_pressed():
	writeDifficulty("hard");
	goToMenu();

func _on_insane_pressed():
	writeDifficulty("insane");
	goToMenu();
