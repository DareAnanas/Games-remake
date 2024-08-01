extends Node2D

const ORIGIN = Vector2(0, 0);


func vectorLoop(point : Vector2, vector : Vector2):
	var points = [];
	
	var loopXEnded = false;
	var loopYEnded = false;
	var x = ORIGIN.x;
	var y = ORIGIN.y;
	
	while not loopXEnded or not loopYEnded:
		var modifiedX = x + point.x;
		var modifiedY = y + point.y;
		points.append([modifiedX, modifiedY]);
		if x < vector.x:
			x += 1;
		else:
			loopXEnded = true;
		if y < vector.y:
			y += 1;
		else:
			loopYEnded = true;
	
	return points;

# Called when the node enters the scene tree for the first time.
func _ready():
	var point = Vector2(0, 0);
	var vector = Vector2(2, 2);
	print(vectorLoop(point, vector));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
