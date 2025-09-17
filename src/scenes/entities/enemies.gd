extends Node2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("funciona hitbox body")
	body.take_damage()
