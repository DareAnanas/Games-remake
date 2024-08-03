extends Label

func changeText(_text):
	if (_text != null):
		text = "Player " + _text + " turn";

func won(_text):
	if (_text != null):
		text = "Player " + _text + " won!";

func _ready():
	GlobalState.subscribe(self);
	changeText(GlobalState.getStateText());
