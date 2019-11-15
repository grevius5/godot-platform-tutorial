extends CanvasLayer

onready var progress_life : ProgressBar = $HBoxContainer/VBoxContainer/ProgressBar as ProgressBar
onready var life_tween : Tween = $HBoxContainer/VBoxContainer/ProgressBar/Tween as Tween


func _on_Player_update_life(life : int) -> void:
	life_tween.interpolate_property(progress_life, "value", progress_life.value, life, .25, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	life_tween.start()
