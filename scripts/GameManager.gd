extends Node

var current_level := 1
const TOTAL_LEVELS := 4

func next_level():
	current_level += 1
	if current_level > TOTAL_LEVELS:
		get_tree().change_scene_to_file("res://scenes/ui/GameOver.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/levels/Level%d.tscn" % current_level)

func restart_game():
	current_level = 1
	get_tree().change_scene_to_file("res://scenes/levels/Level1.tscn")
