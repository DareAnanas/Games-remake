extends Label

func changeText(_text):
	text = "Player " + _text + " turn";

func _ready():
	GlobalState.subscribe(changeText);
	changeText(GlobalState.getStateText());
