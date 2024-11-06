extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Exported variable for the bullet scene
@export var Bullet: PackedScene

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
			
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		
		# Check for shooting input
	if Input.is_action_just_pressed("ui_up"):
		shoot()
		
func shoot() -> void:
	var b = Bullet.instantiate()
	b.custom_init($AnimatedSprite2D.flip_h)
	owner.add_child(b)
	b.global_transform = $Muzzle.global_transform
