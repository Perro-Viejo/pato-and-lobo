tool
extends DialogTree

onready var pez: Character = null


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	pez = C.get_character('Pez')
	
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: Ehh....',
		'Pato: Hi!',
		pez.face_left(),
		'Pez: Hey.',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Pez: Thanks. I won it a while ago in a stare fight.',
				'Pato: A stare fight?',
				'Pez: Yep. A stare fight.',
				'Pato: And how do you play that?',
				'Pez: Play?',
				pez.face_right(),
				E.wait(2),
				'Pez: A stare fight is not a game, mate.',
				'Pez: It is a guts and concentration test... so honorable.',
				pez.face_left(),
				'...',
				'Pato: Got it, got it.'
			]), 'completed')
			opt.visible = false
			show_option('Opt2')
		'Opt2':
			yield(E.run([
				'Pez: You can buy it or win it at a stare fight.',
				'Pez: That\'s how i won mine.',
				'Pato: yep... you already said that.'
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					'Pez: You could... if you weren\'t so dirty.',
					'Pato: I\'M NOT DIRTY!',
					G.display('Pato got mad as she did not in a long time ago'),
					G.display('Now she was commited to defeat Pez in a stare fight'),
					'Pez: You are sooo dirtyy. I can notice from here.',
					'Pato: what what... what do you see dirty?',
					'Pez: Those wings... guagh!',
					pez.face_right(),
					'...',
					'Pez: I don\'t know how can you live like that.',
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: Let me see your wings',
					G.display('Pato showed her wings to Pez'),
					'Pez: All right. You meet the requirement. You can challenge me.'
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
		'Opt4':
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					pez.face_left(),
					G.display('Pez looked at Pato\'s wings.'),
					'Pez: First, get that dirt out of your wings... and we\'ll fight',
					pez.face_right()
				]), 'completed')
				D.finish_dialog()
				return
			else:
				E.shake_camera({strength = 5.0, duration = 5.0})
				E.main_camera.offset_v = -2.0
				yield(E.tween_zoom(Vector2.ONE * 0.3, 5.0, false), 'completed')
				yield(E.run([
					'Pez: IT CANNOT BE!',
					E.tween_zoom(Vector2.ONE, 0.5),
					pez.face_right(),
					'...',
					'Pez: You... Defeated me...',
					G.display('For Pato it was really easy.'),
					G.display('That old trick of looking at the frown, not the eyes.'),
					'Pato: Right! Now give me that thing',
					'Pez: I can not give you all of it, If i do i can\'t return home.',
					'Pez: I\'ll give you only the legs.'
				]), 'completed')
				opt.visible = false
				show_option('Opt7')
		'Opt5':
			yield(E.run([
				'Pez: This is not the place i met some years ago.',
				'Pez: It has changed...for worse.',
				'Pato: Why do you come then?',
				pez.face_right(),
				'...',
				'Pez: Something said to me i should come tonight...',
				G.display('Pez looked at the sky and closed his eyes'),
				G.display('...several minutes went by...'),
				pez.face_left(),
				'...',
				'Pez: Maybe to share something about this place.',
				'Pez: Maybe it could return to be as it was...'
			]), 'completed')
			opt.visible = false
			show_option('Opt6')
		'Opt6':
			yield(E.run([
				'Pez: Sure...'
			]), 'completed')
			D.show_dialog('PezQuestions')
			return
		'Opt7':
			if E.current_room.state.cocktail_unlocked:
				Globals.did(Globals.GameState.LEGS_TAKEN)
				yield(E.run([
					'Pez: Well, it\'s time to meet.',
					'Pez: Here they are...',
					I.add_item('Legs'),
					'Pez: And being no longer my purpose in this place...',
					'Pez: Immmm gone.',
					pez.disable(),
					'...',
					'Pato: Oh shoe. He vanished...',
					G.display('Pato surprised, but Pato with wolf legs.')
				]), 'completed')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: Before giving you my legs, there is something i must tell'
				]), 'completed')
		'Exit':
			yield(E.run([pez.face_right()]), 'completed')
			D.finish_dialog()
			return
	_show_options()
