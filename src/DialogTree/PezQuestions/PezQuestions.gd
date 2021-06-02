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
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'TheQuestion':
			yield(E.run([
				G.display(''),
				E.wait(3),
				'Pez: ',
				'...',
				'Pez: ',
				pez.face_right(),
				'...',
				'Pez: ',
				pez.face_left(),
				'...',
				'Pez: ',
				'Pez: ',
				'Pez: ',
				'...',
				pez.face_right(),
				'Pez: ',
				E.wait(2),
				pez.face_left(),
				'Pez: ',
				pez.face_right()
			]), 'completed')
			E.current_room.state.cocktail_unlocked = true
			D.get_dialog_tree('CocktailsMenu').show_option('Opt3')
			D.get_dialog_tree('ChatWithPez').show_option('Opt6', false)
			opt.visible = false
			D.finish_dialog()
			return
		'Opt2':
			yield(E.run([
				'Pez: PezQuestions-Opt2-Pez-01',
				'Pez: PezQuestions-Opt2-Pez-02'
			]), 'completed')
			opt.visible = false
		'Opt3':
			yield(E.run([
				'Pez: PezQuestions-Opt3-Pez-01',
				'Pez: PezQuestions-Opt3-Pez-02',
				pez.face_right(),
				'...',
				'Pez: PezQuestions-Opt3-Pez-03',
				E.wait(2),
				pez.face_left()
			]), 'completed')
			opt.visible = false
		'Opt4':
			yield(E.run([
				'Pez: PezQuestions-Opt4-Pez-01',
				'Pez: PezQuestions-Opt4-Pez-02',
				'Pez: PezQuestions-Opt4-Pez-03'
			]), 'completed')
			opt.visible = false
			show_option('Opt5')
		'Opt5':
			yield(E.run([
				'Pez: PezQuestions-Opt5-Pez-01',
				'Pez: PezQuestions-Opt5-Pez-02',
				'...',
				pez.face_right(),
				'Pez: PezQuestions-Opt5-Pez-03'
			]), 'completed')
			opt.visible = false
			show_option('TheQuestion')
		'Exit':
			yield(E.run(['Pez: PezQuestions-Exit-Pez-01']), 'completed')
			D.show_dialog('ChatWithPez')
			return
	_show_options()
