extends Node

func change_message(text):
	get_node("MessageLabel").text = text
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	get_node("MessageLabel").text = " "