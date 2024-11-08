extends Area2D

@export var Fart: PackedScene
@export var FullDyper: PackedScene


func _ready():
	$fullTimer.paused = true

func _on_area_entered(_area: Area2D) -> void:
	#print("Cow got hit by something")
	#print(_area.name)
	#print(_area.get_path())
	#print(_area.get_groups())
	if _area.is_in_group("emptyDiper"):
		if $EmptyDiper.visible == false:
			$EmptyDiper.visible = true
			$ch4Timer.paused = true
			$fullTimer.paused = false
			
		#print("Cow got hit by diper")
		_area.queue_free()


func _on_ch_4_timer_timeout() -> void:
	fart()

func fart() -> void:
	var b = Fart.instantiate()
	owner.add_child(b)
	b.global_transform = $FartPoint.global_transform

func _on_full_timer_timeout() -> void:
	fullDiper()
	$EmptyDiper.visible = false
	$ch4Timer.paused = false
	$fullTimer.paused = true
	
func fullDiper() -> void:
	var c = FullDyper.instantiate()
	owner.add_child(c)
	c.global_transform = $FartPoint.global_transform
