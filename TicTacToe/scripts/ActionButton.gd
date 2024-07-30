extends Button

@export var id : int;

func onPressed():
	text = GlobalState.getStateText();
	GlobalState.opposeState();
