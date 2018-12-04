extends Area2D



func _on_Area2D_body_entered(body):
	var new_room
	if body.is_in_group("player"):
		new_room = randi()% game_info.room_list.size()
		get_tree().change_scene("res://Assets/Scenes/Rooms/%s.tscn"% game_info.room_list[new_room])