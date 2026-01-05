extends CharacterBody2D

@export var speed : float = 150.0
@export var jump_velocity : float = -150.0
@export var double_jumped : float = -100


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		has_double_jumped = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") :
		if is_on_floor():
			#normal jump
			velocity.y = jump_velocity
			has_double_jumped = false
		elif not has_double_jumped:
			#double jump in air
			velocity.y = jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
