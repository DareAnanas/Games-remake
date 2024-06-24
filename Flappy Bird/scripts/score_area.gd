extends Area2D

@onready var root = $"../../../root"

var pipe_combination;

func _on_body_entered(body):
	if (!pipe_combination.scoreAreaEntered):
		pipe_combination.scoreAreaEntered = true;
		root.score += 1;
