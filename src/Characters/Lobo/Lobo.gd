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
						'Pato: Now that I have my disguise I won\'t fear.',
						C.walk_to_clicked(),
						C.face_clicked(),
						'...',
						'Pato: Hi.',
						'Pato: Hell',
						'Lobo: Ey!... What\'s the costume for?',
						'Pato: Well...'
					]), 'completed')
				else:
					yield(E.run([
						'Pato: I will not hesitate anymore.',
						'Pato: I\'m gonna talk with Lobo NOW!',
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
						'Pato: He..... he..... h.....',
						A.play_music('mx_frolic'),
					]), 'completed')

				E.goto_room('End')
			else:
				E.run([
					C.face_clicked(),
					'Pato: He is sooooo handsome!!!',
					'Pato: I\'ll never have the guts to talk him',
					face_left(),
					C.face_clicked(),
					dance(),
					'Pato: And look how he moves..\n\/( > __ < \\)'
				])
		'Sea':
			E.run([
				'Lobo: Heeeeeeeeeeeeeeeeelp',
				'Lobo: I\'m drowning!!!',
				'Pato: Hang on there my love. I\'ll get you out of there.'
			])
		'Luna':
			D.show_dialog('ChatWithLoboInLuna')


func on_look() -> void:
	E.run(['Pato: He is soooooooooo hot!!!'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mopbrella':
			yield(E.run([
				'Pato: I\'ve saved your life, love of my.',
			]), 'completed')
			A.stop('bg_dream_boat', 0, false)
			I.remove_item(item.script_name, false)
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Bar')
	else:
		E.run([
			'Pato: I can not reach you',
		])


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')


func drowning() -> void:
	anim_suffix = '_drowning'
	idle(false)
