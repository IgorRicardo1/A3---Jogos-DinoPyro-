extends CharacterBody2D

const SPEED := 200.0
const JUMP_FORCE := -400.0
const GRAVITY := 900.0
var is_knocked_back := false
var knockback_timer := 0.0

@onready var anim = $AnimatedSprite2D

func apply_knockback(from_position: Vector2):
	var dir = sign(global_position.x - from_position.x)
	velocity.x = dir * 150
	velocity.y = -150
	is_knocked_back = true
	knockback_timer = 0.3    

func take_damage(from_position: Vector2):
	var hud = get_tree().current_scene.get_node("HUD")
	if hud:
		hud.take_damage()
	apply_knockback(from_position)

func _physics_process(delta):
	if is_knocked_back:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knocked_back = false
	else:
		var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		velocity.x = direction * SPEED

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if is_on_floor() and Input.is_action_just_pressed("jump") and not is_knocked_back:
		velocity.y = JUMP_FORCE

	move_and_slide()

	if not is_on_floor():
		anim.play("jump")
	elif not is_knocked_back and velocity.x != 0:
		anim.play("run")
		anim.flip_h = velocity.x < 0
	elif not is_knocked_back:
		anim.play("idle")
