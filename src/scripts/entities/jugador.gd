extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health: int = 3

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.play("jump")

	# Salto
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Movimiento horizontal
	var direction := Input.get_axis("IZQUIERDA", "DERECHA")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Animaciones
	if Input.is_action_pressed("DERECHA") and is_on_floor():
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run")
	elif Input.is_action_pressed("IZQUIERDA") and is_on_floor():
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run")
	elif not (Input.is_action_pressed("IZQUIERDA") 
		   or Input.is_action_pressed("DERECHA") 
		   or Input.is_action_pressed("JUMP")) and is_on_floor():
		animated_sprite_2d.play("idle")
	
	# Movimiento + colisiones
	move_and_slide()
	_check_spike_damage()


################### DAÑO ###################

func _check_spike_damage():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "spikes":
			take_damage()

func take_damage() -> void:
	health -= 1
	print("Vida restante: ", health)
	if health <= 0:
		die()

func die() -> void:
	print("¡Game Over!")
	queue_free()
