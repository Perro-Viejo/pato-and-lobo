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
		'Pato: ChatWithPez-Start-Pato-01',
		'Pato: ChatWithPez-Start-Pato-02',
		pez.face_left(),
		'Pez: ChatWithPez-Start-Pez-03',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Pez: ChatWithPez-Opt1-Pez-01',
				'Pato: ChatWithPez-Opt1-Pez-02',
				'Pez: ChatWithPez-Opt1-Pez-03',
				'Pato: ChatWithPez-Opt1-Pez-04',
				'Pez: ChatWithPez-Opt1-Pez-05',
				pez.face_right(),
				E.wait(2),
				'Pez: ChatWithPez-Opt1-Pez-06',
				'Pez: ChatWithPez-Opt1-Pez-07',
				pez.face_left(),
				'...',
				'Pato: ChatWithPez-Opt1-Pato-08'
			]), 'completed')
			opt.visible = false
			show_option('Opt2')
		'Opt2':
			yield(E.run([
				'Pez: ChatWithPez-Opt2-Pez-01',
				'Pez: ChatWithPez-Opt2-Pez-02',
				'Pato: ChatWithPez-Opt2-Pato-03'
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					'Pez: ChatWithPez-Opt3-Pez-01',
					'Pato: ChatWithPez-Opt3-Pato-02',
					G.display('ChatWithPez-Opt3-Game-03'),
					G.display('ChatWithPez-Opt3-Game-04'),
					'Pez: ChatWithPez-Opt3-Pez-05',
					'Pato: ChatWithPez-Opt3-Pato-06',
					'Pez: ChatWithPez-Opt3-Pez-07',
					pez.face_right(),
					'...',
					'Pez: ChatWithPez-Opt3-Pez-08',
					'Pato: ChatWithPez-Opt3-Pato-09',
					'Pez: ChatWithPez-Opt3-Pez-10',
					'Pez: ChatWithPez-Opt3-Pez-11',
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: ChatWithPez-Opt3-Pez-12',
					'Pato: ChatWithPez-Opt3-Pato-13',
					'Pez: ChatWithPez-Opt3-Pez-14',
					'Pato: ChatWithPez-Opt3-Pato-15',
					'Pez: ChatWithPez-Opt3-Pez-16',
					'Pez: ChatWithPez-Opt3-Pez-17',
					'Pato: ChatWithPez-Opt3-Pato-18',
					G.display('ChatWithPez-Opt3-Game-19'),
					'Pez: ChatWithPez-Opt3-Pez-20'
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
		'Opt4':
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					pez.face_left(),
					G.display('ChatWithPez-Opt4-Game-01'),
					'Pez: ChatWithPez-Opt4-Pez-02',
					pez.face_right()
				]), 'completed')
				D.finish_dialog()
				return
			else:
				E.shake_camera({strength = 5.0, duration = 5.0})
				E.main_camera.offset_v = -2.0
				A.play({cue_name = 'sfx_stare_fight', pos = Vector2.ZERO, is_in_queue = false})
				AudioServer.get_bus_effect(1, 0).cutoff_hz = 600
				AudioServer.set_bus_volume_db(1, -8)
				yield(E.tween_zoom(Vector2.ONE * 0.3, 5.0, false), 'completed')
				yield(E.run([
					'Pez: ChatWithPez-Opt4-Pez-03',
					A.play({cue_name = 'sfx_stare_reset', pos = Vector2.ZERO, is_in_queue = false}),
					E.tween_zoom(Vector2.ONE, 0.5),
					AudioServer.get_bus_effect(1, 0).set_cutoff(20000),
					AudioServer.set_bus_volume_db(1, 0),
					pez.face_right(),
					'...',
					'Pez: ChatWithPez-Opt4-Pez-04',
					G.display('ChatWithPez-Opt4-Game-05'),
					G.display('ChatWithPez-Opt4-Game-06'),
					'Pato: ChatWithPez-Opt4-Pato-07',
					'Pez: ChatWithPez-Opt4-Pez-08',
					'Pez: ChatWithPez-Opt4-Pez-09'
				]), 'completed')
				opt.visible = false
				show_option('Opt7')
		'Opt5':
			yield(E.run([
				'Pez: ChatWithPez-Opt5-Pez-01',
				'Pez: ChatWithPez-Opt5-Pez-02',
				'Pato: ChatWithPez-Opt5-Pato-03',
				pez.face_right(),
				'...',
				'Pez: ChatWithPez-Opt5-Pez-04',
				G.display('ChatWithPez-Opt5-Game-05'),
				G.display('ChatWithPez-Opt5-Game-06'),
				pez.face_left(),
				'...',
				'Pez: ChatWithPez-Opt5-Pez-07',
				'Pez: ChatWithPez-Opt5-Pez-08'
			]), 'completed')
			opt.visible = false
			show_option('Opt6')
		'Opt6':
			yield(E.run([
				'Pez: ChatWithPez-Opt6-Pez-01'
			]), 'completed')
			D.show_dialog('PezQuestions')
			return
		'Opt7':
			if E.current_room.state.cocktail_unlocked:
				Globals.did(Globals.GameState.LEGS_TAKEN)
				yield(E.run([
					'Pez: ChatWithPez-Opt7-Pez-01',
					'Pez: ChatWithPez-Opt7-Pez-02',
					I.add_item('Legs'),
					'Pez: ChatWithPez-Opt7-Pez-03',
					'Pez: ChatWithPez-Opt7-Pez-04',
					pez.disable(),
					'...',
					'Pato: ChatWithPez-Opt7-Pato-05',
					G.display('ChatWithPez-Opt7-Game-06')
				]), 'completed')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: ChatWithPez-Opt7-Pez-07'
				]), 'completed')
		'Exit':
			yield(E.run([pez.face_right()]), 'completed')
			D.finish_dialog()
			return
	_show_options()
