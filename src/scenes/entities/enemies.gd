extends Node2D

@onready var ataques: Area2D = $ataques

@onready var sprites_enemies: AnimatedSprite2D = $CharacterBody2D/sprites_enemies

var damage_frames: Array = [3, 5]





func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
	


# Si el jugador entra en el area del esqueleto pierde vida, falta hacer que el 
# esqueleto solo dañe si toca el fame de ataque 
func _on_hitbox_body_entered(body: Node2D) -> void:
	pass
	#print("funciona hitbox body")
	#if body.name == "jugador_mau":
		#sprites_enemies.play("atack")
	#if ataques.monitoring and body.name == "jugador_mau":
		#body.take_damage()
		


func _on_ataques_body_entered(body: Node2D) -> void:
	print("golpe de espada")
	if sprites_enemies.animation == "atack":
		if sprites_enemies.frame in damage_frames:
			ataques.monitoring = true  # activa colisiones
		else:
			ataques.monitoring = false # desactiva colisiones.
	if ataques.monitoring and body.name == "jugador_mau":
		body.take_damage()
			
