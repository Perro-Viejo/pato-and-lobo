tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(
				E.run([
					'Lagarto: Yo sé. Yo soy áspero.',
					'Pato: Ajá...'
				]),
				'completed'
			)
			_show_options()
			return
		'Opt2':
			yield(
				E.run([
					'Lagarto: Claro que sí. Le tengo estos temitas.'
				]),
				'completed'
			)
			D.finish_dialog()
			D.show_dialog('SongList')
		'Exit':
			D.finish_dialog()
