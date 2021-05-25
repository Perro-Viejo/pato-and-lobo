tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run(['Conejuno: Which beer?']), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: Thanks.',
				A.play('sfx_beer', C.player.global_position),
				G.display('Pato drank the beer quickly'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup glup glup',
				'...',
				'Pato: Nothing happened'
			]), 'completed')
		'Opt2':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: Thanks.',
				A.play('sfx_beer', C.player.global_position),
				G.display('Pato drank the beer slowly'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup glup glup glup glup glup glup glup glup',
				'...',
				'Pato: Wow... now I feel the KICK TO THE COSM...'
			]), 'completed')
			opt.visible = false
			D.finish_dialog()
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Luna')
			return
		'Opt3':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				A.play('sfx_beer', C.player.global_position),
				'Pato: Thanks.',
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup.... glup...... glup',
				'...',
				'Pato: What a disgusting beer',
				G.display('Pato watered what was left of the beer')
			]), 'completed')
		'Exit':
			D.finish_dialog()
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()


func _ask_beer(beer_name: String) -> void:
	yield(E.run([
		'Pato: I want a...',
		C.player_say(beer_name + ', please.'),
		'Conejuno: Serving a ' + beer_name.to_lower()
	]), 'completed')
