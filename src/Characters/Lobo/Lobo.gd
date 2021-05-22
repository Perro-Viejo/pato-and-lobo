tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	match E.current_room.script_name:
		'Bar':
			if Globals.courage >= 50:
				if Globals.has_done(Globals.GameState.DISGUISED):
					# El jugador decidió hablarle a Lobo teniendo el disfraz
					yield(E.run([
						'Pato: Así con el disfraz sentiré menos meyo',
						C.walk_to_clicked(),
						C.face_clicked(),
						'...',
						'Pato: Ho.',
						'Pato: Hola',
						'Lobo: Hola... ¿para qué es el disfraz?',
						'Pato: Emmmmmmm'
					]), 'completed')
				else:
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
					C.face_clicked(),
					C.player_say('¡¡¡Ayyyy pero qué guapote!!!'),
					'Pato: Nunca seré capaz de hablarle',
					face_left(),
					C.face_clicked(),
					dance(),
					'Pato: Ayyyy... qué rico se mueve... \/( > __ < \\)'
				])
		'Sea':
			E.run([
				'Lobo: Aiuudaaaaaaaaaaaaaaaaaaaaaaaa',
				'Lobo: Mi hogo!!!',
				'Pato: Aguanta amor meo. Te sacaré de ahí.'
			])
		'Luna':
			E.run([
				'Lobo: Vamos a buscar cositas para hacer nuestra casa en la Luna',
				'Pato: Sí sí. Ya vamos.'
			])


func on_look() -> void:
	E.run(['Pato: Está más bueno que el pan con chocolate'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mopbrella':
			yield(E.run([
				C.player_say('Te salve de la desgracía Lobo de mis amores'),
			]), 'completed')
			A.stop('bg_dream_boat', 0, false)
			I.remove_item(item.script_name, false)
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Bar')
	else:
		E.run([
			C.player_say('No alcanzo hasta allá'),
		])


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')
