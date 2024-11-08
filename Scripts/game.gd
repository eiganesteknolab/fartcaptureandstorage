extends Node2D

var ch4LevelsValue = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_ch_4_levels_value() -> void:
	ch4LevelsValue = ch4LevelsValue + 1
	$Player/Camera2D/RichTextLabel.clear()
	$Player/Camera2D/RichTextLabel.append_text("[color=red]CH4 Levels at " + str(ch4LevelsValue) + "[/color]")
