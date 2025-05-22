extends Control

func _on_play_button_pressed():
	GameManager.restart_game() 

func _on_instructions_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/Instructions.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/Credits.tscn")
