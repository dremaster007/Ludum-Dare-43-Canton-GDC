extends Node

func change_message(text):
	get_node("MessageLabel").text = text

func _on_MessageTimer_timeout():
	get_node("MessageLabel").text = " "
