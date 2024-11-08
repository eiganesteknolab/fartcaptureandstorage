extends Area2D

var speed = 25 + randf_range(0, 25)

func _physics_process(delta):
	position += transform.y * speed * -1 * delta
	
