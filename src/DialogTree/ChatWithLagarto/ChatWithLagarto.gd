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
					'Lagarto: ChatWithLagarto-Opt1-Lagarto-01',
					'Pato: ChatWithLagarto-Opt1-Pato-02'
				]),
				'completed'
			)
			_show_options()
			return
		'Opt2':
			yield(
				E.run([
					'Lagarto: ChatWithLagarto-Opt2-Lagarto-01'
				]),
				'completed'
			)
			D.finish_dialog()
			D.show_dialog('SongList')
		'Exit':
			D.finish_dialog()
