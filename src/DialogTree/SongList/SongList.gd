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
						'Lagarto: SongList-Opt1-Lagarto-01',
						'Lagarto: SongList-Opt1-Lagarto-02',
						C.get_character('Lagarto').remove_mask(),
						A.stop('mx_bar_01'),
						A.stop('mx_bar_02'),
						A.stop('mx_bar_03'),
						A.play_music('mx_bar_03'),
						'Lagarto: SongList-Opt1-Lagarto-03',
					]),
					'completed'
				)
				D.finish_dialog()
			else:
				yield(
					E.run([
						'Lagarto: SongList-Opt1-Lagarto-04',
					]),
					'completed'
				)
				opt.visible = false
				_show_options()
		'Opt2', 'Opt4':
			yield(
				E.run([
					'Lagarto: SongList-Opt2-Lagarto-01',
					'...',
					'Lagarto: SongList-Opt2-Lagarto-02'
				]),
				'completed'
			)
			_show_options()
		'Opt3':
			yield(
				E.run([
					'Lagarto: SongList-Opt3-Lagarto-01',
					A.stop('mx_bar_01'),
					A.stop('mx_bar_02'),
					A.stop('mx_bar_03'),
					A.play_music('mx_bar_02'),
					C.player_walk_to(E.current_room.get_point('DanceFloor2')),
					C.player.dance(),
					E.wait(3),
					'Pato: SongList-Opt3-Pato-02',
					'...'
				]),
				'completed'
			)
			
			if not Globals.moon_song_played:
				Globals.moon_song_played = true
				yield(E.run(['Pato: SongList-Opt3-Pato-03']), 'completed')
				opt.visible = false
				D.finish_dialog()
				A.play('sfx_dream_transition', Vector2.ZERO, false)
				E.goto_room('Luna')
			else:
				yield(Globals.moon_daydream_repeated(), 'completed')
				D.finish_dialog()
		'Exit':
			yield(E.run(['Lagarto: SongList-Exit-Lagarto-01']), 'completed')
			D.finish_dialog()
