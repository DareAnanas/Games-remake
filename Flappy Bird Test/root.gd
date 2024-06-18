extends Node2D


func pipeCombinationGenerator(pipeCount, gap):
	var combinations = []
	var sequence = []
	
	# Initialize the sequence with 2's and a trailing 1
	sequence.append(1)
	for i in range(gap):
		sequence.append(2)
	sequence.append(1)
	
	# Generate first combination

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

	return combinations

# Called when the node enters the scene tree for the first time.
func _ready():
	var result = pipeCombinationGenerator(12, 3)
	for combination in result:
		print(str(combination))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
