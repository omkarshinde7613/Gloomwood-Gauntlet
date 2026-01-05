extends CharacterBody2D

@export var speed : float = 150.0
@export var jump_velocity : float = -150.0
@export var double_jumped : float = -100

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO


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
	direction = Input.get_vector("left", "right","up","down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
			
func update_facing_direction():
	if direction.x >00:
		animated_sprite.flip_h  = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
