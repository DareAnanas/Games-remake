extends Node

# Turn variable have these states
# 0 - no action
# 1 - fill empty
# 2 - fill X
# 3 - fill O

enum turnStates {NO_ACTION, FILL_EMPTY, FILL_X, FILL_O};

var turn = 0;

var sockets = [];

var checker;

func registerChecker(_checker):
	checker = _checker;
	
func sendStateToChecker(id, state):
	checker.setState(id, state);
	
func subscribe(label):
	sockets.append(label);
	
func sendStateTextToSubscribers():
	for label in sockets:
		label.changeText(getStateText());

func won():
	for label in sockets:
		label.won(getStateText());
	changeState(GlobalState.turnStates.NO_ACTION);

func changeState(state):
	if !turnStates.values().has(state):
		print("Error. There's no such state.");
		return;
	turn = state;

func opposeState():
	if turn == turnStates.FILL_X:
		turn = turnStates.FILL_O;
	elif turn == turnStates.FILL_O:
		turn = turnStates.FILL_X;
	sendStateTextToSubscribers();

func getStateText():
	match turn:
		turnStates.NO_ACTION:
			return;
		turnStates.FILL_EMPTY:
			return "";
		turnStates.FILL_X:
			return "X";
		turnStates.FILL_O:
			return "O";
