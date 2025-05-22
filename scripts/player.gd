extends CharacterBody2D

const SPEED := 200.0
const JUMP_FORCE := -400.0
const GRAVITY := 900.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	velocity.x = direction * SPEED

	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE

	move_and_slide()

	# Animações
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("run")
		anim.flip_h = direction < 0
	else:
		anim.play("idle")
