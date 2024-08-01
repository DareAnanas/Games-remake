extends Button

@export var id : int;

var _disabled = false;

func onPressed():
	if _disabled: return;
	_disabled = true;
	text = GlobalState.getStateText();
	GlobalState.sendStateToChecker(id, GlobalState.turn);
	GlobalState.opposeState();
