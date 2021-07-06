tool
extends Character


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	match E.current_room.script_name:
		'Bar':
			if Globals.has_done(Globals.GameState.GOT_DRUNK):
				# Pato le habló a Lobo teniendo borracha
				E.clicked = self
				yield(E.run(
					[
						C.walk_to_clicked(),
						C.face_clicked(),
						C.player.dance(),
						'Pato: CharacterLobo-Bar-Pato-16',
						C.player.dance(),
						face_left(),
						'Lobo: CharacterLobo-Bar-Lobo-17',
						dance()
					]
				), 'completed')
				
				E.goto_room('End')
			elif Globals.courage >= 50:
				if Globals.has_done(Globals.GameState.DISGUISED):
					# Pato le habló a Lobo teniendo el disfraz
					if Globals.courage < 100:
						yield(E.run([
							'Pato: CharacterLobo-Bar-Pato-01',
							C.walk_to_clicked(),
							C.face_clicked(),
							'...',
							'Pato: CharacterLobo-Bar-Pato-02',
							'Pato: CharacterLobo-Bar-Pato-03',
							face_left(),
							'Lobo: CharacterLobo-Bar-Lobo-04',
							'Pato: CharacterLobo-Bar-Pato-05'
						]), 'completed')
					else:
						# ...y el coraje
						yield(E.run([
							face_left(),
							dance(),
							'Pato: CharacterLobo-Bar-Pato-18',
							'Pato: CharacterLobo-Bar-Pato-19',
							C.walk_to_clicked(),
							C.face_clicked(),
							'Pato: CharacterLobo-Bar-Pato-20',
							'Lobo: CharacterLobo-Bar-Lobo-21',
							'Lobo: CharacterLobo-Bar-Lobo-22',
							'Pato: CharacterLobo-Bar-Pato-23',
							'Pato: CharacterLobo-Bar-Pato-24',
						]), 'completed')
				else:
					# Pato le habló a Lobo teniendo el coraje
					yield(E.run([
						face_right(),
						dance(),
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
						C.player_walk_to(E.current_room.get_point('DanceFloor3'))
					]), 'completed')
					Globals.did(Globals.GameState.UNABLE)

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
				C.player_walk_to(E.current_room.get_point('ProwPoint')),
				'...',
				'Pato: CharacterLobo-Mopbrella-Pato-01',
			]), 'completed')
			A.stop('bg_dream_boat', 0, false)
			I.remove_item(item.script_name, false)
			C.get_character('Lagarto').check_music()
			A.play({cue_name = 'sfx_dream_transition', pos = Vector2.ZERO, is_in_queue = false})
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
