extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const SHOOT_COOLDOWN = 0.2
const JUMP_COOLDOWN = 0.2

var can_shoot_empty = true
var can_shoot_full = true
var can_jump = true

var emptyDiperAmmo = 0
var fullDiperAmmo = 0

var ch4level = 0

var score = 0

signal ch4levelsValue

# Exported variable for the bullet scene
@export var Bullet: PackedScene
@export var fullDiper: PackedScene

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if can_jump and  Input.is_joy_button_pressed(0, JOY_BUTTON_A):
		velocity.y = JUMP_VELOCITY
		can_jump = false
		await get_tree().create_timer(JUMP_COOLDOWN).timeout
		can_jump = true
		
	# Check for shooting empty dipers
	if can_shoot_empty and Input.is_joy_button_pressed(0, JOY_BUTTON_X) and emptyDiperAmmo > 0:
		shootEmpty()
		can_shoot_empty = false
		await get_tree().create_timer(SHOOT_COOLDOWN).timeout
		can_shoot_empty = true
		emptyDiperAmmo = emptyDiperAmmo - 1

	# Check for shooting full dipers
	if can_shoot_full and Input.is_joy_button_pressed(0, JOY_BUTTON_B) and fullDiperAmmo > 0:
		shootFull()
		can_shoot_full = false
		await get_tree().create_timer(SHOOT_COOLDOWN).timeout
		can_shoot_full = true
		fullDiperAmmo = fullDiperAmmo - 1

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
		
	if emptyDiperAmmo == 0:
		$EmptyDyper1.visible = false
		$EmptyDyper2.visible = false
		$EmptyDyper3.visible = false
	elif emptyDiperAmmo == 1:
		$EmptyDyper1.visible = true
		$EmptyDyper2.visible = false
		$EmptyDyper3.visible = false
	elif emptyDiperAmmo == 2:
		$EmptyDyper1.visible = true
		$EmptyDyper2.visible = true
		$EmptyDyper3.visible = false
	elif emptyDiperAmmo == 3:
		$EmptyDyper1.visible = true
		$EmptyDyper2.visible = true
		$EmptyDyper3.visible = true
		
	if fullDiperAmmo == 0:
		$FullDyper1.visible = false
		$FullDyper2.visible = false
		$FullDyper3.visible = false
	elif fullDiperAmmo == 1:
		$FullDyper1.visible = true
		$FullDyper2.visible = false
		$FullDyper3.visible = false
	elif fullDiperAmmo == 2:
		$FullDyper1.visible = true
		$FullDyper2.visible = true
		$FullDyper3.visible = false
	elif fullDiperAmmo == 3:
		$FullDyper1.visible = true
		$FullDyper2.visible = true
		$FullDyper3.visible = true
		
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


func _on_empty_diper_1_body_entered(body: Node2D) -> void:
	if emptyDiperAmmo < 3:
		emptyDiperAmmo = emptyDiperAmmo + 1


func _on_empty_diper_0_body_entered(body: Node2D) -> void:
	if emptyDiperAmmo < 3:
		emptyDiperAmmo = emptyDiperAmmo + 1


func _on_empty_diper_2_body_entered(body: Node2D) -> void:
	if emptyDiperAmmo < 3:
		emptyDiperAmmo = emptyDiperAmmo + 1


func _on_well_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("fullDiper"):
		#print("diper ", body.name, " safe")
		score = score + 1
		body.toggleKill()


func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("Body ", body.get_groups(), "Path ", body.get_path())
	if body.is_in_group("fullDiper"):
		body.queue_free()
		fullDiperAmmo = fullDiperAmmo + 1



func _on_roof_area_entered(area: Area2D) -> void:
	print("Body ", area.get_groups(), "Path ", area.get_path())
	if area.is_in_group("fart"):
		area.queue_free()
		ch4level = ch4level + 1
		emit_signal("ch4levelsValue")
