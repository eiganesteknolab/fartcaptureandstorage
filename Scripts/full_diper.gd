extends RigidBody2D

@export var Fart: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KillTimer.paused = true
	apply_impulse(Vector2(randf_range(25, 50), -50))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggleKill():
	$toch4Timer.paused = true
	$KillTimer.paused = false

func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_toch_4_timer_timeout() -> void:
	var b = Fart.instantiate()
	b.position = $Marker2D.global_position
	b.rotation = 0
	get_parent().add_child(b)
	queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Body ", body.get_groups(), "Path ", body.get_path())
	#if body.is_in_group("fullDiper"):
		#print("diper ", body.name, " safe")
		#body.toggleAffFullDiper()
