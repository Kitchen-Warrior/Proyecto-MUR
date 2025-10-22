extends Node2D

@onready var ataques: Area2D = $ataques

@onready var sprites_enemies: AnimatedSprite2D = $CharacterBody2D/sprites_enemies

var damage_frames: Array = [3, 5]
var damage_cooldown: float = 5
var last_damage_time: float = 0.0




func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if sprites_enemies.animation == "atack" and sprites_enemies.frame in damage_frames:
		ataques.monitoring = true
		check_damage()  # Verificar daño continuamente
	else:
		ataques.monitoring = false
	
	


# Si el jugador entra en el area del esqueleto pierde vida, falta hacer que el 
# esqueleto solo dañe si toca el fame de ataque 



#func _on_ataques_body_entered(body: Node2D) -> void:
		#if sprites_enemies.animation == "atack":
			#if sprites_enemies.frame in damage_frames:
				#ataques.monitoring = true  # activa colisiones
				#if ataques.monitoring == true and body.name == "jugador_mau":
					#body.take_damage()
					#last_damage_time = 0.0
		#else:
			#ataques.monitoring = false # desactiva colisiones.
			#ataques.monitoring = false 
		
func check_damage():
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_damage_time >= damage_cooldown:
		print("Tendria que hacer daño")
		var bodies = ataques.get_overlapping_bodies()
		for body in bodies:
			if body.name == "jugador_mau":
				body.take_damage()
				last_damage_time = current_time
				print("Daño aplicado")
				break  # Importante: salir después del primer daño
				
				
func _on_arackbox_body_entered(body: Node2D) -> void:
	if body.name == "jugador_mau":
		print("JUGADOR ENTRO EN HITBOX")
		sprites_enemies.play("atack")
# Detener el movimiento del esqueleto
		set_physics_process(false)  # O el método que uses para movimiento
		


func _on_atackbox_body_exited(body: Node2D) -> void:
	if body.name == "jugador_mau":
		print("JUGADOR SALIO DEL HITBOX")
		# Cambiar a animación idle o reanudar movimiento
		sprites_enemies.play("idle")  # o "walk" según tus animaciones
		# Reanudar el movimiento si es necesario
		set_physics_process(true)
