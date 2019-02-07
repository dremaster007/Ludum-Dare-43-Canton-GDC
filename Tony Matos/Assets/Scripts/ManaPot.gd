extends Area2D

func _on_ManaPot_body_entered(body):
	if body.is_in_group("player"):
		body.manapot()
		queue_free()