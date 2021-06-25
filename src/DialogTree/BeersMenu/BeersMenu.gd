tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run(['Conejuno: BeersMenu-Start-Conejuno-01']), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: BeersMenu-Pato-Thanks',
				A.play('sfx_beer', C.player.global_position),
				G.display('BeersMenu-Opt1-Game-01'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: BeersMenu-Opt1-Pato-02',
				'...',
				'Pato: BeersMenu-Opt1-Pato-03'
			]), 'completed')
		'Opt2':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: BeersMenu-Pato-Thanks',
				A.play('sfx_beer', C.player.global_position),
				G.display('BeersMenu-Opt2-Game-01'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: BeersMenu-Opt2-Pato-02',
				'...',
			]), 'completed')
			
			if not Globals.cosmo_kick_drunk:
				Globals.cosmo_kick_drunk = true
				yield(E.run(['Pato: BeersMenu-Opt2-Pato-03']), 'completed')
				opt.visible = false
				D.finish_dialog()
				A.play('sfx_dream_transition', Vector2.ZERO, false)
				C.get_character('Lagarto').stop_music(false)
				C.get_character('Lagarto').timer.stop()
				E.goto_room('Luna')
				return
			else:
				yield(Globals.moon_daydream_repeated(), 'completed')
				_show_options()
				return
		'Opt3':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				A.play('sfx_beer', C.player.global_position),
				'Pato: BeersMenu-Pato-Thanks',
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: BeersMenu-Opt3-Pato-01',
				'...',
				'Pato: BeersMenu-Opt3-Pato-02',
				G.display('BeersMenu-Opt3-Game-03')
			]), 'completed')
		'Exit':
			yield(E.run([C.player_say(opt.text)]), 'completed')
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()


func _ask_beer(beer_name: String) -> void:
	yield(E.run([
		'Pato: BeersMenu-Pato-01',
		C.player_say(E.get_text(beer_name) + E.get_text('BeersMenu-Pato-02')),
		'Conejuno: %s %s' % [E.get_text('BeersMenu-Conejuno-03'), E.get_text(beer_name)]
	]), 'completed')
