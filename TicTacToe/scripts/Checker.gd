extends Node2D

const ROW_SIZE = 3;
const COLUMN_SIZE = 3;
const ORIGIN = Vector2(0, 0);

var stateMatrix = [];

func vectorLoop(point : Vector2, vector : Vector2):
	var points = [];
	
	var loopXEnded = false;
	var loopYEnded = false;
	var x = ORIGIN.x;
	var y = ORIGIN.y;
	
	while not loopXEnded or not loopYEnded:
		var modifiedX = x + point.x;
		var modifiedY = y + point.y;
		points.append(Vector2(modifiedX, modifiedY));
		if vector.x > 0 and x < vector.x:
			x += 1;
		elif vector.x < 0 and x > vector.x:
			x -= 1;
		else:
			loopXEnded = true;
		if vector.y > 0 and y < vector.y:
			y += 1;
		elif vector.y < 0 and y > vector.y:
			y -= 1;
		else:
			loopYEnded = true;
	
	return points;
	
func checkIfAllSame(points):
	var firstPoint = points[0];
	var firstState = stateMatrix[firstPoint.x][firstPoint.y];
	if (firstState == GlobalState.turnStates.NO_ACTION or 
		firstState == GlobalState.turnStates.FILL_EMPTY):
		return false;
	var allSame = true;
	for point in points:
		var pointState = stateMatrix[point.x][point.y];
		if pointState != firstState:
			allSame = false;
			break;
	return allSame;

func checkWinConditions():
	const ORIGIN_POINTS = [Vector2(0, 0), Vector2(0, 2)];
	const RIGHT_VECTORS = [Vector2(0, 2), Vector2(2, 0)];
	const DIAGONAL_VECTORS = [Vector2(2, 2), Vector2(2, -2)]
	
	for i in range(len(RIGHT_VECTORS)):
		var startingVector = RIGHT_VECTORS[i];
		var checkingVector = RIGHT_VECTORS[len(RIGHT_VECTORS) - i - 1];
		var startingPoints = vectorLoop(ORIGIN_POINTS[0], startingVector);
		for startingPoint in startingPoints:
			var checkingPoints = vectorLoop(startingPoint, checkingVector);
			if (checkIfAllSame(checkingPoints)):
				return true;
	
	for i in range(len(DIAGONAL_VECTORS)):
		var startingPoint = ORIGIN_POINTS[i];
		var checkingVector = DIAGONAL_VECTORS[i];
		var checkingPoints = vectorLoop(startingPoint, checkingVector);
		if (checkIfAllSame(checkingPoints)):
			return true;
	
	return false;
	

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
	if checkWinConditions():
		GlobalState.won();

# Called when the node enters the scene tree for the first time.
func _ready():
	stateMatrix = generateStateMatrix(ROW_SIZE, COLUMN_SIZE);
	GlobalState.registerChecker(self);

