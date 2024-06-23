extends Area2D

@onready var root = $"../../../root"


func _on_body_entered(body):
	root.score += 1;
