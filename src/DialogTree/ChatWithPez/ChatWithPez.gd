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
					G.display('Ora sí estaba dispuesta a derrotar a Pez en la pelea de miradas'),
					'Pez: Estás muuuuuy sucia. Lo noto desde aquí.',
					'Pato: Qué qué... ¿Qué tengo sucio?',
					'Pez: Las alas... ¡guagh!',
					pez.face_right(),
					'...',
					'Pez: No sé cómo puedes vivir así.',
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
			if not Globals.has_done(Globals.GameState.SEA_DREAMED):
				yield(E.run([
					pez.face_left(),
					G.display('Pez miró las alas de Pato.'),
					'Pez: Primero quítate el mugre de las alas... y lucharemos',
					pez.face_right()
				]), 'completed')
				D.finish_dialog()
				return
			else:
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
				show_option('Opt7')
		'Opt5':
			yield(E.run([
				'Pez: Este no es el bar que conocí hace unos años.',
				'Pez: Ha cambiado...pa peor.',
				'Pato: ¿Por qué vienes entonces?',
				pez.face_right(),
				'...',
				'Pez: Algo me dijo que debía venir esta noche...',
				G.display('Pez miró al cielo y luego cerró los ojos'),
				G.display('...pasaron muchos minutos...'),
				pez.face_left(),
				'...',
				'Pez: Tal vez para contar sobre el pasado de este lugar.',
				'Pez: Puede que así vuelva a ser como solía ser...'
			]), 'completed')
			opt.visible = false
			show_option('Opt6')
		'Opt6':
			yield(E.run([
				'Pez: Sí...'
			]), 'completed')
			D.show_dialog('PezQuestions')
			return
		'Opt7':
			if E.current_room.state.cocktail_unlocked:
				Globals.did(Globals.GameState.LEGS_TAKEN)
				yield(E.run([
					'Pez: Bien. Pues es la hora de cumplir.',
					'Pez: Aquí están...',
					I.add_item('Legs'),
					'Pez: Y no siendo más mi propósito en este lugar...',
					'Pez: Mmmmme voy.',
					pez.disable(),
					'...',
					'Pato: A juepuerca. Desapareció...',
					G.display('Pato sorprendida, pero Pato con patas de lobo.')
				]), 'completed')
				D.finish_dialog()
				return
			else:
				yield(E.run([
					'Pez: Antes de darte mis patas, hay algo que debemos resolver'
				]), 'completed')
		'Exit':
			yield(E.run([pez.face_right()]), 'completed')
			D.finish_dialog()
			return
	_show_options()
