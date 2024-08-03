extends Label

func changeText(_text):
	if (_text != null):
		text = "Player " + _text + " turn";

func _ready():
	GlobalState.subscribe(changeText);
	changeText(GlobalState.getStateText());
