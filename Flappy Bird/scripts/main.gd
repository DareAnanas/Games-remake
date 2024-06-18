extends Node2D

@onready var moving_group_1 = $MovingGroup1
@onready var moving_group_2 = $MovingGroup2
@onready var teleport = $teleport
@onready var spawnpoint = $spawnpoint

var pipe_combination_scene = preload("res://scenes/pipe_combination.tscn")
var pipe_scene = preload("res://scenes/pipe.tscn")

var pipe_queue = [];

const SPEED = 75;
const DIRECTION = -1;

func _ready():
	var pipe_combination = pipe_combination_scene.instantiate();
	pipe_combination.position.x = spawnpoint.position.x;
	pipe_combination.position.y = 128;
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
	
	if (!pipe_queue.is_empty() && pipe_queue.front().position.x <= 0):
		pipe_queue.pop_front().queue_free();
	
	if (!pipe_queue.is_empty()):
		pipe_queue.map(func(pipe_combination): pipe_combination.position.x += SPEED * DIRECTION * delta)

func _on_timer_timeout():
	#TODO треба зробити чергу
	var pipe_combination = pipe_combination_scene.instantiate();
	pipe_combination.position.x = spawnpoint.position.x;
	pipe_combination.position.y = 128;
	var pipe = pipe_scene.instantiate();
	pipe_combination.add_child(pipe);
	pipe_queue.append(pipe_combination);
	add_child(pipe_queue.back());
	#pass
