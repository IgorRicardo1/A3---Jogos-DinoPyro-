extends Control

func _ready():
	$VBoxContainer/BackButton.pressed.connect(_on_voltar_pressed)

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui/TitleScreen.tscn")
