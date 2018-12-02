extends KinematicBody2D

var velocity = Vector2(0,0)
var damage = 0

func _process(delta):
	move_and_slide(velocity, Vector2(0,0))


func _on_Arrow_body_entered(body):
	$BreakParticles.emitting = true
	$WindParticles.emitting = false
	$QueueFree.start()

func _on_QueueFree_timeout():
	queue_free()

func _on_DestroyArrow_timeout():
	$BreakParticles.emitting = true
	$WindParticles.emitting = false
	$QueueFree.start()
