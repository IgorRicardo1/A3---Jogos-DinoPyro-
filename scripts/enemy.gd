extends CharacterBody2D

const SPEED := 100.0
var direction := -1
var is_attacking := false
var can_attack := true
var players_in_range := []


@onready var sprite = $AnimatedSprite2D
@onready var ray = $GroundRay
@onready var cooldown_timer = $AttackCooldown

func _ready():
	for p in get_tree().get_nodes_in_group("player"):
		ray.add_exception(p)

	update_raycast_direction()

func _physics_process(delta):
	if not is_attacking:
		velocity.x = direction * SPEED
		move_and_slide()

		if not ray.is_colliding() or is_on_wall():
			direction *= -1
			update_raycast_direction()
	else:
		velocity.x = 0
		move_and_slide()

	sprite.flip_h = direction > 0

	if is_attacking:
		if sprite.animation != "attack":
			sprite.play("attack")
	elif sprite.animation != "walk":
		sprite.play("walk")

func update_raycast_direction():
	ray.position.x = 12 * direction

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_attack:
		direction = sign(body.global_position.x - global_position.x)
		is_attacking = true
		can_attack = false
		cooldown_timer.start()

		if sprite.animation != "attack":
			sprite.play("attack")

		if body.has_method("take_damage"):
			body.take_damage(global_position)

func _on_attack_cooldown_timeout():
	can_attack = true
	is_attacking = players_in_range.size() > 0


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not players_in_range.has(body):
			players_in_range.append(body)
		is_attacking = true


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		players_in_range.erase(body)
		if players_in_range.size() == 0:
			is_attacking = false


func _on_head_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.velocity.y > 0:
		body.velocity.y = -300
		await get_tree().process_frame  # espera um frame antes de remover
		queue_free() 
