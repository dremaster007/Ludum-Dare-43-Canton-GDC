extends Area2D

func _on_Dagger_body_entered(body):
	if body.is_in_group("player"):
		body.dagger()
		queue_free()