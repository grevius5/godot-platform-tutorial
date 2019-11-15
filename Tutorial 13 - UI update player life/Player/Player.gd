extends KinematicBody2D
class_name Player

signal update_life()

const FLOOR_NORMAL : = Vector2(0, -1)

var gravity : = 10
var speed : = 100.0
var velocity : = Vector2()
var target_speed : = 0.0
var jump_speed : = -225.0
var jumping : = false

var life : = 10

onready var animated_sprite : = $AnimatedSprite as AnimatedSprite
onready var animation : AnimationPlayer = $AnimationPlayer as AnimationPlayer

onready var foot : Node2D = $Foot as Node2D


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
	get_enemy_raycast()

	velocity.y = velocity.y + gravity

	velocity.x = lerp(velocity.x, target_speed, .4)

	if abs(velocity.x) < 1:
		velocity.x = 0

	var snap : = Vector2.DOWN * 8 if !jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR_NORMAL)

	if is_on_floor():
		jumping = false


func get_inputs() -> void:
	if Input.is_action_pressed("ui_up") && !jumping:
		velocity.y = jump_speed
		jumping = true

	target_speed = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * speed


func get_enemy_raycast() -> void:
	for ray in foot.get_children():
		var collider = ray.get_collider()
		if collider && collider.is_in_group("Enemy"):
			velocity.y = jump_speed * .5
			collider.damage()


func damage() ->void:
	if animation.is_playing():
		return

	life -= 1
	animation.play("damage")

	emit_signal("update_life", life)

