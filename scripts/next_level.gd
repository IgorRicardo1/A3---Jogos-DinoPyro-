extends Area2D

@export var nextlevel = ""

func _on_body_entered(body: Node2D) -> void:
	call_deferred("load_next_level")
func load_next_level():
	get_tree().change_scene_to_file("res://Scenes/levels/" + nextlevel + ".tscn")
