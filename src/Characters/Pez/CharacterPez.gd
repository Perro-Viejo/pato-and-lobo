tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player.face_right(),
		'Pato: Emmm....',
		'Pato: Hola',
		C.get_character('Pez').face_left(),
		'Pez: Quiubo mijo. ¿Ta fiesta ta como buena no?',
		'Pato: Pos sí',
		C.get_character('Pez').face_right(),
	])


func on_look() -> void:
	.on_look()


func get_dialog_pos() -> float:
	return $AnimatedSprite.position.y - 32.0
