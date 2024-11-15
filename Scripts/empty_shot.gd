extends Area2D

var speed = 100
var direction = true  # 1 for positive movement, -1 for negative

func custom_init(_direction):
	direction =  _direction

func _ready():
	
	if direction:
		speed = speed*-1  # Set the speed based on direction
	else:
		speed = speed*1

func _physics_process(delta):
	position += transform.x * speed * delta
	position += transform.y * 80 * delta 
	
func _on_body_entered(_body: Node2D) -> void:
	queue_free()
