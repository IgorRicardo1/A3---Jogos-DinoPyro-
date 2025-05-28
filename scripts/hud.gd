extends CanvasLayer

var max_life := 5
var current_life := 5

@onready var heart_container := $HBoxContainer

func _ready():
	update_hearts()

func update_hearts():
	for i in range(heart_container.get_child_count()):
		heart_container.get_child(i).visible = i < current_life

func take_damage():
	if current_life > 0:
		current_life -= 1
		update_hearts()

	if current_life <= 0:
		GameManager.restart_game()
