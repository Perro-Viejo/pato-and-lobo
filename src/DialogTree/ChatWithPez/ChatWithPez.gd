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
		'Pato: Emmm....',
		'Pato: Hola',
		pez.face_left(),
		'Pez: Quiubo.',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Pez: Gracias. Lo gané hace poco en una pelea de miradas.',
				'Pato: ¿Una pelea de miradas?',
				'Pez: Sí. Una pelea de miradas.',
				'Pato: ¿Y eso cómo se juega?',
				'Pez: ¿Jugar?',
				pez.face_right(),
				E.wait(2),
				'Pez: La pelea de miradas no es un juego, amiga.',
				'Pez: Es una prueba de valor y concentración... muy honorable.',
				pez.face_left(),
				'...',
				'Pato: Entiendo, entiendo.'
			]), 'completed')
			opt.visible = false
			show_option('Opt2')
		'Opt2':
			yield(E.run([
				'Pez: Puedes comprarla o ganarla en una pelea de miradas.',
				'Pez: Así fue como gané la mía.',
				'Pato: Sí sí... ya lo dijites.'
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					'Pez: Podrías... si no estuvieras tan sucia.',
					'Pato: ¡YO NO ESTOY SUCIA!',
					G.display('Pato se enojó como hace mucho no lo hacía'),
					G.display('Ora sí estaba dispuesta a derrotarlo en la pelea de miradas'),
					'Pez: Estás muuuuuy sucia. Lo noto desde aquí.',
					'Pato: Ya... ¿y qué tengo sucio?',
					'Pez: Tus alas... ¡guagh!',
					pez.face_right(),
					'...',
					'Pez: No sé cómo puedes vivir así'
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: Déjame ver tus alas',
					G.display('Pato mostró sus alas a Pez'),
					'Pez: Muy bien. Cumples el requisito. Puedes retarme.'
				]), 'completed')
				opt.visible = false
				show_option('Opt4')
		'Opt4':
			E.shake_camera({strength = 5.0, duration = 5.0})
			E.main_camera.offset_v = -2.0
			yield(E.tween_zoom(Vector2.ONE * 0.3, 5.0, false), 'completed')
			yield(E.run([
				'Pez: ¡NO PUEDE SER!',
				E.tween_zoom(Vector2.ONE, 0.5),
				pez.face_right(),
				'...',
				'Pez: Me has derrotado...',
				G.display('Para Pato fue algo realmente fácil.'),
				G.display('El viejo truco de mirar el entrecejo, no los ojos.'),
				'Pato: ¡Pues sí! Ahora dame tu aparato',
				'Pez: No puedo darte todo, porque si lo hago no podré volver a casa.',
				'Pez: Te daré sólo las piernas.'
			]), 'completed')
			opt.visible = false
		'Opt5':
			yield(E.run([
				'Pez: ¿Y oler el sudor... y ver los cuerpo sucios?',
				'Pez: Ni porque me pagaran un chirrión de pesos',
				'Pato: ¿Qué haces en un lugar así entonces?',
				pez.face_right(),
				'...',
				'Pez: Algo me dijo que debía venir esta noche...',
				G.display('Pez miró al cielo y luego cerró los ojos'),
				G.display('...pasaron muchos minutos...'),
				pez.face_left(),
				'...',
				'Pez: Sólo sé que debo responder a una pregunta.',
				'Pez: Pero no sé cuál es la pregunta...'
			]), 'completed')
			show_option('Opt6')
		'Opt6':
			yield(E.run([
				'Pez: Sí...'
			]), 'completed')
			D.show_dialog('PezQuestions')
			return
		'Exit':
			D.finish_dialog()
			return
	_show_options()
