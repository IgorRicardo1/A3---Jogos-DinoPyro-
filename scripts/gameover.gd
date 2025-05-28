extends Control

func _ready():
	$CenterContainer/VBoxContainer/ButtonRetry.pressed.connect(_on_retry_pressed)
	$CenterContainer/VBoxContainer/ButtonExit.pressed.connect(_on_exit_pressed)

func _on_retry_pressed():
	GameManager.restart_game()

func _on_exit_pressed():
	get_tree().quit()
