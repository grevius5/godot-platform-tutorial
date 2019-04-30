extends KinematicBody2D

const FLOOR_NORMAL : = Vector2(0, -1)

var gravity : = 10
var speed : = 100.0
var velocity : = Vector2()
var target_speed : = 0.0
var jump_speed : = -225.0

func _physics_process(delta: float) -> void:
	get_inputs()

	velocity.y = velocity.y + gravity

	velocity.x = lerp(velocity.x, target_speed, .4)

	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_inputs() -> void:
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = jump_speed

	target_speed = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed