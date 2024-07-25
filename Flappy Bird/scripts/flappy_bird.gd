extends CharacterBody2D

@onready var root = $".."
@onready var timer = $Timer

const SPEED = 300.0
#default jump velocity is -400
var jumpVelocity = -300.0

var boostVelocity = -400;
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# default gravity from project settings is 980

var gravity = 800;

var holdEnabled = false;
var canHoldJump = false;

func changeSkinToScene(scene_name):
	var path_placeholder = "res://skins/%s.tscn";
	
	var scene_path = path_placeholder % scene_name;
	
	for child in get_children():
		if child.get_class() == "Sprite2D":
			remove_child(child);
	var skin_scene = load(scene_path);
	var skin = skin_scene.instantiate();
	add_child(skin);

func boost():
	velocity.y = boostVelocity;

func controlled_physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jumpVelocity;
		if holdEnabled:
			timer.start();
	
	if holdEnabled:
		if canHoldJump && Input.is_action_pressed("ui_accept"):
			velocity.y = jumpVelocity;
			
		if (Input.is_action_just_released("ui_accept")):
			canHoldJump = false;
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _physics_process(delta):
	if (!root.game_over):
		controlled_physics_process(delta)

func _on_timer_timeout():
	canHoldJump = true;
	timer.stop();
		
