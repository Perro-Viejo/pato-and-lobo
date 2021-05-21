tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run(['Conejuno: ¿De qué pola quiere?']), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: Gracias.',
				A.play('sfx_beer', C.player.global_position),
				G.display('Pato se tomó la cerveza rápido'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup glup glup',
				'...',
				'Pato: Pues no me dio un brinco'
			]), 'completed')
		'Opt2':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				'Pato: Gracias.',
				A.play('sfx_beer', C.player.global_position),
				G.display('Pato se tomó la cerveza lentamente'),
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup glup glup glup glup glup glup glup glup',
				'...',
				'Pato: Ay juepuerca... esta Patada al espacio...'
			]), 'completed')
			D.finish_dialog()
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Space')
			return
		'Opt3':
			yield(_ask_beer(opt.text), 'completed')
			yield(E.run([
				A.play('sfx_beer', C.player.global_position),
				'Pato: Gracias.',
				A.play('sfx_drink_beer', C.player.global_position),
				'Pato: glup glup.... glup...... glup',
				'...',
				'Pato: ¡Qué cerveza más fea!',
				G.display('Pato regó lo que quedaba de la cerveza')
			]), 'completed')
		'Exit':
			D.finish_dialog()
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()


func _ask_beer(beer_name: String) -> void:
	yield(E.run([
		'Pato: Que sea una...',
		C.player_say(beer_name + ', por favor.'),
		'Conejuno: Sale una ' + beer_name.to_lower()
	]), 'completed')
