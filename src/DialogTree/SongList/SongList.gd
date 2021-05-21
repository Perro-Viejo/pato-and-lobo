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
			if E.current_room.state.has_mask:
				yield(
					E.run([
						'Lagarto: Buena eletción. Ya mismo se la pongo',
						'Lagarto: Pero me voy a quitar esto porque esa me hace sudar',
						C.get_character('Lagarto').remove_mask(),
						A.stop('mx_bar_01'),
						A.stop('mx_bar_02'),
						A.stop('mx_frolic'),
						A.play_music('mx_frolic'),
						'Lagarto: ¡Ora sí! A gozaaaaaaar',
					]),
					'completed'
				)
				D.finish_dialog()
			else:
				yield(
					E.run([
						'Lagarto: No... esa canción me trae malos recuerdos',
					]),
					'completed'
				)
				opt.visible = false
				_show_options()
		'Opt2', 'Opt4':
			yield(
				E.run([
					'Lagarto: ¡De una!',
					'...',
					'Lagarto: ¡Ah juepuerca! Se me quedó ese disco'
				]),
				'completed'
			)
			_show_options()
		'Opt3':
			yield(
				E.run([
					'Lagarto: Uffffffffff... mi canción más favorita',
					A.stop('mx_bar_01'),
					A.stop('mx_bar_02'),
					A.stop('mx_frolic'),
					A.play_music('mx_bar_02'),
					C.player_walk_to(E.current_room.get_point('DanceFloor2')),
					C.player.dance(),
					E.wait(3),
					'Pato: Esta música mí gustar mucho muy',
					'...',
					'Pato: Y si...'
				]),
				'completed'
			)
			D.finish_dialog()
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Space')
		'Exit':
			yield(E.run(['Lagarto: Ta bueno.']), 'completed')
			D.finish_dialog()
