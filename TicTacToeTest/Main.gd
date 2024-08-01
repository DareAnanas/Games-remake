extends Node2D

const ORIGIN = Vector2(0, 0);

func vectorLoop(point : Vector2, vector : Vector2):
	var points = [];
	for x in range(vector.x + 1):
		for y in range(vector.y + 1):
			var modifiedX = x + point.x;
			var modifiedY = y + point.y;
			points.append([modifiedX, modifiedY]);
	return points;

# Called when the node enters the scene tree for the first time.
func _ready():
	var point = Vector2(0, 0);
	var vector = Vector2(2, 2);
	print(vectorLoop(point, vector));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
