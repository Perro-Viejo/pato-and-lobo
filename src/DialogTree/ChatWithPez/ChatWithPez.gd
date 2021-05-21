tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: Emmm....',
		'Pato: Hola',
		C.get_character('Pez').face_left(),
		'Pez: Quiubo.',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Pez: ¿Sabías que en este bar hay una bebida secreta?',
				'Pato: ¡NO!',
				'Pez: jojojojojojo...pues la hay.',
				'Pato: ¿Y cómo se llama?',
				'Pez: Sudor de Hércules.',
				'Pato: Guácala.',
				'Pez: Por eso es secreta.'
			]), 'completed')
			D.get_dialog_tree('CocktailsMenu').show_option('Opt3')
			opt.visible = false
		'Exit':
			D.finish_dialog()
			return
	_show_options()
