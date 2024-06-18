extends Node2D

@onready var moving_group_1 = $MovingGroup1
@onready var moving_group_2 = $MovingGroup2
@onready var teleport = $teleport
@onready var spawnpoint = $spawnpoint

var pipe_combination_scene = preload("res://scenes/pipe_combination.tscn")
var pipe_scene = preload("res://scenes/pipe.tscn")
var pipe_combination

var pipe_queue = [];

const SPEED = 75;
const DIRECTION = -1;

func _ready():
	pipe_combination = pipe_combination_scene.instantiate();
	pipe_combination.position.x = spawnpoint.position.x - 64;
	var pipe = pipe_scene.instantiate();
	pipe_combination.add_child(pipe);
	pipe_queue.append(pipe_combination);
	add_child(pipe_queue.back());
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (moving_group_1.position.x <= teleport.position.x):
		moving_group_1.position.x = moving_group_2.position.x + 512
	if (moving_group_2.position.x <= teleport.position.x):
		moving_group_2.position.x = moving_group_1.position.x + 512
	
	moving_group_1.position.x += SPEED * DIRECTION * delta
	moving_group_2.position.x += SPEED * DIRECTION * delta
	
	#pipe_combination.position.x += SPEED * DIRECTION * delta;

func _on_timer_timeout():
	#TODO треба зробити чергу
	pipe_queue[0].queue_free()
	#pass
