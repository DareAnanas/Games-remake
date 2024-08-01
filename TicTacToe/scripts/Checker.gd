extends Node2D

const ROW_SIZE = 3;
const COLUMN_SIZE = 3;

var stateMatrix = [];

func generateStateMatrix(rowSize, columnSize):
	var _stateMatrix = [];
	for i in range(columnSize):
		var row = [];
		for j in rowSize:
			row.append(GlobalState.turnStates.NO_ACTION);
		_stateMatrix.append(row);
	return _stateMatrix;

func oneDimToTwoDim(id, rowSize):
	var row_index = id / rowSize;
	var column_index = id % rowSize;
	return [row_index, column_index];

func setState(id, state):
	var twoDimIndex = oneDimToTwoDim(id, ROW_SIZE);
	stateMatrix[twoDimIndex[0]][twoDimIndex[1]] = state;
	print(stateMatrix);

# Called when the node enters the scene tree for the first time.
func _ready():
	stateMatrix = generateStateMatrix(ROW_SIZE, COLUMN_SIZE);
	GlobalState.registerChecker(self);

