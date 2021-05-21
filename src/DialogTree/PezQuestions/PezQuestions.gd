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
	# D.get_dialog_tree('CocktailsMenu').show_option('Opt3')
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'TheQuestion':
			yield(E.run([
				G.display('Pez abrió sus ojotes como si hubiera visto un muerto'),
				E.wait(3),
				'Pez: Esa es...',
				'...',
				'Pez: Esa es la pregunta que vine a esperar.',
				pez.face_right(),
				'...',
				'Pez: Y la respuesta es...',
				pez.face_left(),
				'...',
				'Pez: En este lugar hay una bebida secreta, una bebida especial.',
				'Pez: Su nombre es Sudor de Hércules...',
				'Pez: Es lo que se necesita para tumbar a la vieja...'
			]), 'completed')
			D.get_dialog_tree('ChatWithPez').show_option('Opt4', false)
			opt.visible = false
		_:
			yield(E.run([
				'Pez: Pues no...',
				'Pez: Esa no es la pregunta que espero',
				pez.face_right(),
				E.wait(2),
				'Pez: Debe haber otra...'
			]), 'completed')
			opt.visible = false
	D.finish_dialog()
