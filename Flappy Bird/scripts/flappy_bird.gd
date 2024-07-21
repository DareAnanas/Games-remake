extends CharacterBody2D

@onready var root = $".."

const SPEED = 300.0
#default jump velocity is -400
var jumpVelocity = -300.0

var boostVelocity = -450;
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# default gravity from project settings is 980

var gravity = 800;

func boost():
	velocity.y = boostVelocity;

func controlled_physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jumpVelocity
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
