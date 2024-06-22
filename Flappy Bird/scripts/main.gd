extends Node2D

@onready var moving_group_1 = $MovingGroup1
@onready var moving_group_2 = $MovingGroup2
@onready var teleport = $teleport
@onready var spawnpoint = $spawnpoint
@onready var pause_menu = $PauseMenu
@onready var pipe_combination_anchor = $PipeCombinationAnchor
@onready var game_over_menu = $GameOverMenu

var pipe_combination_scene = preload("res://scenes/pipe_combination.tscn")
var pipeScene = preload("res://scenes/pipe.tscn")
var pipeDownScene = preload("res://scenes/pipe(down).tscn")
var pipeUpScene = preload("res://scenes/pipe(up).tscn")
var pipe_queue = [];
var pipeCombinations = [];

var paused = false;
var game_over = false;

const SPEED = 75;
const DIRECTION = -1;
var pipeDictionary = {
	0: pipeScene,
	1: pipeDownScene,
	3: pipeUpScene
}

func pipeCombinationsGenerator(pipeCount, gap):
	var combinations = []
	var sequence = []
	var first_combination = [];
	
	# Initialize the sequence with 2's and a trailing 1
	sequence.append(1)
	for i in range(gap):
		sequence.append(2)
		first_combination.append(2)
	sequence.append(3)
	first_combination.append(3)
	
	# Generate first combination
	for i in range(pipeCount - gap - 1):
		first_combination.append(0)
		
	combinations.append(first_combination)

	# Generate the combinations by shifting the sequence within the zeros
	for i in range(pipeCount - len(sequence) + 1):
		var combination = []
		
		# Prefix zeros
		for j in range(i):
			combination.append(0)
		
		# The sequence
		combination += sequence
		
		# Suffix zeros
		while len(combination) < pipeCount:
			combination.append(0)
		
		combinations.append(combination)
		
	var last_combination = first_combination.duplicate();
	last_combination.reverse()
	var three_index = last_combination.find(3);
	last_combination[three_index] = 1;
	combinations.append(last_combination);

	return combinations

func spawn(pipeCombination):
	var pipe_combination = pipe_combination_scene.instantiate();
	pipe_combination.position.x = spawnpoint.position.x;
	
	#generating pipe combination
	var yPosition = 0;
	for pipeNumber in pipeCombination:
		if (pipeDictionary.has(pipeNumber)):
			var pipe = pipeDictionary[pipeNumber].instantiate();
			pipe.position.y = yPosition;
			pipe_combination.add_child(pipe);
		yPosition += 32;
	
	
	pipe_queue.append(pipe_combination);
	pipe_combination_anchor.add_sibling(pipe_queue.back())
	# add_child(pipe_queue.back());

func _ready():
	pipeCombinations = pipeCombinationsGenerator(12, 3);
	spawn(pipeCombinations.pick_random());
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
	
func gameOverMenu():
	if game_over:
		game_over_menu.hide();
	else:
		game_over_menu.show();
	game_over = !game_over;
	

func controlled_process(delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
	
	if (moving_group_1.position.x <= teleport.position.x):
		moving_group_1.position.x = moving_group_2.position.x + 512
	if (moving_group_2.position.x <= teleport.position.x):
		moving_group_2.position.x = moving_group_1.position.x + 512
	
	moving_group_1.position.x += SPEED * DIRECTION * delta
	moving_group_2.position.x += SPEED * DIRECTION * delta
	
	if (!pipe_queue.is_empty() && pipe_queue.front().position.x <= 0):
		pipe_queue.pop_front().queue_free();
	
	if (!pipe_queue.is_empty()):
		pipe_queue.map(func(pipe_combination): 
			pipe_combination.position.x += SPEED * DIRECTION * delta
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!game_over):
		controlled_process(delta)
	

func _on_timer_timeout():
	if (!game_over):
		spawn(pipeCombinations.pick_random());
	#pass


func _on_button_pressed():
	if (!game_over):
		pauseMenu()
