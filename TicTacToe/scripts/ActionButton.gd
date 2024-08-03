extends Button

@export var id : int;

var _disabled = false;

func onPressed():
	if _disabled: return;
	_disabled = true;
	var stateText = GlobalState.getStateText();
	if stateText != null:
		text = stateText;
	GlobalState.sendStateToChecker(id, GlobalState.turn);
	GlobalState.opposeState();
