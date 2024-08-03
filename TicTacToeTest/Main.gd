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

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 2:
		print(i);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
