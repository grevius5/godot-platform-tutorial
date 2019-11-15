extends Node2D


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("Player"):
		$AnimationPlayer.play("GetCoin")
