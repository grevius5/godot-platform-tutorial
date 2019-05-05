extends KinematicBody2D

const FLOOR_NORMAL : = Vector2(0, -1)

var gravity : = 10
var speed : = 100.0
var velocity : = Vector2()
var target_speed : = 0.0
var jump_speed : = -225.0

onready var animated_sprite : = $AnimatedSprite as AnimatedSprite


func _process(delta: float) -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

	if velocity.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

	if !is_on_floor():
		animated_sprite.play("jump")


func _physics_process(delta: float) -> void:
	get_inputs()

	velocity.y = velocity.y + gravity

	velocity.x = lerp(velocity.x, target_speed, .4)

	if abs(velocity.x) < 1:
		velocity.x = 0

	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_inputs() -> void:
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = jump_speed

	target_speed = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed