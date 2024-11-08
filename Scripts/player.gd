extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const SHOOT_COOLDOWN = 0.2
const JUMP_COOLDOWN = 0.2

var can_shoot_empty = true
var can_shoot_full = true
var can_jump = true

# Exported variable for the bullet scene
@export var Bullet: PackedScene
@export var fullDiper: PackedScene

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if can_jump and  Input.is_joy_button_pressed(0, JOY_BUTTON_X):
		velocity.y = JUMP_VELOCITY
		can_jump = false
		await get_tree().create_timer(JUMP_COOLDOWN).timeout
		can_jump = true
		
	# Check for shooting empty dipers
	if can_shoot_empty and Input.is_joy_button_pressed(0, JOY_BUTTON_A):
		shootEmpty()
		can_shoot_empty = false
		await get_tree().create_timer(SHOOT_COOLDOWN).timeout
		can_shoot_empty = true

	# Check for shooting full dipers
	if can_shoot_full and Input.is_joy_button_pressed(0, JOY_BUTTON_B):
		shootFull()
		can_shoot_full = false
		await get_tree().create_timer(SHOOT_COOLDOWN).timeout
		can_shoot_full = true

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		
	move_and_slide()
		
func shootEmpty() -> void:
	var b = Bullet.instantiate()
	b.custom_init($AnimatedSprite2D.flip_h)
	owner.add_child(b)
	b.global_transform = $Muzzle.global_transform


func shootFull() -> void:
	var b = fullDiper.instantiate()
	owner.add_child(b)
	b.global_transform = $Muzzle.global_transform
