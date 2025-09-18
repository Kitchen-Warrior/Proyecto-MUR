extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

<<<<<<< HEAD
<<<<<<< HEAD
const SPEED = 135.0
=======
const SPEED = 120.0
>>>>>>> 0dd1e8cc208d61350bbe192d984da2e87a70ca66
const JUMP_VELOCITY = -250.0
=======
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
>>>>>>> parent of 84b012b (cambios en niveles rj)
var health: int = 5



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

# Comprueba si caemos en pinchos
func _check_spike_damage():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "spikes":
			die()


# enemies damages
func enemies_damage():
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()  #tiene en cuenta cuantos enemigos choco, cambiar
	if overlapping_mobs:
		take_damage()


# Recibe la cantidad de daño y la aplica
func take_damage() -> void:
	health -= 1
	print("Vida restante: ", health)
	if health <= 0:
		die()


func die() -> void:
	print("¡Game Over!")
	queue_free()
