tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		'Pato: Hola señora',
		'Viejo: Hola.',
		'Viejo: ¿Qué se le ofrece?'
	])


func on_look() -> void:
	.on_look()


func get_dialog_pos() -> float:
	return $AnimatedSprite.position.y
