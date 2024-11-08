extends Area2D


func _ready() -> void:
	$viewTimer.paused = true

func _on_body_entered(_body: Node2D) -> void:
	#print("Empty diaper +1")
	$viewTimer.paused = false
	$CollisionShape2D.disabled = true 
	$AnimatedSprite2D.visible = false

func _on_view_timer_timeout() -> void:
	$viewTimer.paused = true
	$CollisionShape2D.disabled = false 
	$AnimatedSprite2D.visible = true
