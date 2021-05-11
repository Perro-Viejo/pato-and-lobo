tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.player_say('¡¡¡Ayyyy pero qué guapote!!!'),
		'...',
		C.player.face_left(),
		'...',
		C.player.face_right(),
		'...',
		'Pato: Nunca seré capaz de hablarle'
	])


func on_look() -> void:
	E.run(['Pato: Está más bueno que el pan con chocolate'])
