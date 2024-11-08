extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KillTimer.paused = true
	apply_impulse(Vector2(randf_range(25, 50), -50))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggleKill():
	$KillTimer.paused = false

func _on_kill_timer_timeout() -> void:
	queue_free()
