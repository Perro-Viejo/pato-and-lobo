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
						'Pato: CharacterLobo-Bar-Pato-01',
						C.walk_to_clicked(),
						C.face_clicked(),
						'...',
						'Pato: CharacterLobo-Bar-Pato-02',
						'Pato: CharacterLobo-Bar-Pato-03',
						'Lobo: CharacterLobo-Bar-Lobo-04',
						'Pato: CharacterLobo-Bar-Pato-05'
					]), 'completed')
				else:
					yield(E.run([
						'Pato: CharacterLobo-Bar-Pato-06',
						'Pato: CharacterLobo-Bar-Pato-07',
						C.walk_to_clicked(),
						C.player.face_right(),
						'...',
						'Pato: CharacterLobo-Bar-Pato-08',
						'Pato: CharacterLobo-Bar-Pato-09',
						'Pato: CharacterLobo-Bar-Pato-10',
						C.player.face_left(),
						'...',
						C.player.face_right(),
						'...',
						'Pato: CharacterLobo-Bar-Pato-11',
						A.play_music('mx_bar_03'),
					]), 'completed')

				E.goto_room('End')
			else:
				E.run([
					C.face_clicked(),
					'Pato: CharacterLobo-Bar-Pato-12',
					'Pato: CharacterLobo-Bar-Pato-13',
					face_left(),
					C.face_clicked(),
					dance(),
					'Pato: CharacterLobo-Bar-Pato-14',
					'Pato: CharacterLobo-Bar-Pato-15'
				])
		'Sea':
			E.run([
				'Lobo: CharacterLobo-Sea-Lobo-01',
				'Lobo: CharacterLobo-Sea-Lobo-02',
				'Pato: CharacterLobo-Sea-Pato-03'
			])
		'Luna':
			D.show_dialog('ChatWithLoboInLuna')


func on_look() -> void:
	E.run(['Pato: CharacterLobo-Look-Pato-01'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mopbrella':
			yield(E.run([
				'Pato: CharacterLobo-Mopbrella-Pato-01',
			]), 'completed')
			A.stop('bg_dream_boat', 0, false)
			I.remove_item(item.script_name, false)
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Bar')
	else:
		E.run([
			'Pato: CharacterLobo-OnItemUsed-Pato-01',
		])


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')


func drowning() -> void:
	anim_suffix = '_drowning'
	idle(false)
