tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if Globals.courage >= 20:
		yield(E.run([
			'Pato: Ya no le daré más vueltas',
			'Pato: Voy con toda a hablarle a Lobo',
			C.walk_to_clicked(),
			C.player.face_right(),
			'...',
			'Pato: ...',
			'Pato: ........',
			'Pato: ......................',
			C.player.face_left(),
			'...',
			C.player.face_right(),
			'...',
			'Pato: Ho..... ho..... ho.....',
			A.play_music('mx_frolic'),
		]), 'completed')
		E.goto_room('End')
	else:
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
