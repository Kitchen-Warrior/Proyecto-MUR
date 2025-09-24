extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash: Node2D = $dash

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health: int = 5


#dash
const DASH_SPEED = 1200
const DASH_LENGTH = .1


#fin dash
const NORMLA_SPEED = 300.0


var health: int = 5
var jump_count: int = 0


func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.play("jump")

	#dash
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(DASH_LENGTH)
	var speed = DASH_SPEED if $dash.is_dashing() else NORMLA_SPEED


	# Salto
	if Input.is_action_just_pressed("JUMP") and  (is_on_floor() or jump_count == 0):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	if is_on_floor():
		jump_count = 0
	# Movimiento horizontal
	var direction := Input.get_axis("IZQUIERDA", "DERECHA")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
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
