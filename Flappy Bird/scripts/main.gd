extends Node2D

@onready var moving_group_1 = $MovingGroup1
@onready var moving_group_2 = $MovingGroup2

const SPEED = 75;
const DIRECTION = -1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in moving_group_1.get_children():
		child.position.x += SPEED * DIRECTION * delta

	for child in moving_group_2.get_children():
		child.position.x += SPEED * DIRECTION * delta

