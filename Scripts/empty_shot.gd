extends Area2D

var speed = 100
var direction = true  # 1 for positive movement, -1 for negative

func custom_init(_direction):
	print(direction)
	direction =  _direction
	print(direction)

func _ready():
	
	if direction:
		speed = speed*-1  # Set the speed based on direction
	else:
		speed = speed*1

func _physics_process(delta):
	position += transform.x * speed * delta
	position += transform.y * 80 * delta 
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
