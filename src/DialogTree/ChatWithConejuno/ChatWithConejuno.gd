tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(
		E.run([
			C.walk_to_clicked(),
			C.player.face_up(),
			E.offset_camera(Vector2(0.0, -2.0)),
			E.wait(0.5),
			'Conejuno: ChatWithConejuno-Start-01'
		]),
		'completed'
	)
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			D.show_dialog('BeersMenu')
			return
		'Opt2':
			D.show_dialog('CocktailsMenu')
			return
		'Exit':
			yield(E.run([
				'Conejuno: ChatWithConejuno-Exit-01'
			]), 'completed')
			D.finish_dialog()
