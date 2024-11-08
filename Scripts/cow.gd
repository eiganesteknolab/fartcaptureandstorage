extends Area2D

@export var Fart: PackedScene

func _on_area_entered(_area: Area2D) -> void:
	print("Cow got hit by something")
	#print(_area.name)
	#print(_area.get_path())
	#print(_area.get_groups())
	if _area.is_in_group("emptyDiper"):
		$EmptyDiper.visible = true
		$ch4Timer.paused = true
			
		print("Cow got hit by diper")
		_area.queue_free()


func _on_ch_4_timer_timeout() -> void:
	fart()


func fart() -> void:
	var b = Fart.instantiate()
	owner.add_child(b)
	b.global_transform = $FartPoint.global_transform
