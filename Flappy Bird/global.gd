extends Node

func readDifficulty():
	var config = ConfigFile.new()
	
	var err = config.load("user://difficulty.cfg")
	
	if err != OK:
		return
		
	return config.get_value("Game", "difficulty");

func readSkin():
	var config = ConfigFile.new();
	
	var err = config.load("user://skins.cfg")
	
	if err != OK:
		return
		
	return config.get_value("Customization", "skin");

func readPipeSkin():
	var config = ConfigFile.new();
	
	var err = config.load("user://pipe_skins.cfg")
	
	if err != OK:
		return
		
	return config.get_value("Customization", "pipe_skin");
