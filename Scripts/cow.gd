extends Area2D

#state 0 - Cow without Diper
#state 1 - Cow With Empty Diper
var state = 0

func _on_area_entered(_area: Area2D) -> void:
	print("Cow got hit by something")
	#print(_area.name)
	#print(_area.get_path())
	#print(_area.get_groups())
	if _area.is_in_group("emptyDiper"):
		$EmptyDiper.visible = true
			
		print("Cow got hit by diper")
		_area.queue_free()
