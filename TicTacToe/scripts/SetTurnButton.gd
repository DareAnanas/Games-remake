extends Button


@export var turnState : GlobalState.turnStates;

func onPressed():
	GlobalState.changeState(turnState);
	get_tree().change_scene_to_file("res://scenes/Game.tscn");
