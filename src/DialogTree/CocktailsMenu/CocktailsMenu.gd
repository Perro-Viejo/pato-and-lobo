tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		'Conejuno: El bar no se hace responsable por lo que pueda pasar',
		'Conejuno: Pero le ofrezco estos cocteles'
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(
		E.run([C.player_say(opt.text + ', por favor.')]),
		'completed'
	)
	match opt.id:
		'Opt1':
			yield(E.run([
				'Conejuno: Le advierto que ese la puede dejar tirada en el piso',
				'Conejuno: Así que tómeselo con despacio... con calmación',
				'Pato: Tabuenoeñor',
				I.add_item('Cocktail'),
			]), 'completed')
		'Opt2':
			yield(E.run([
				'Conejuno: ¿Se quiere borrar el caseto?',
				'Conejuno: Pilaricas con tomárselo de afán',
				'Pato: Mmmmmmm.....',
				G.display('Pato pensó en algo...'),
				'Pato: Bueno pues... (sapo)',
				#TODO: ¿Subirle el coraje cuando se tome este? (a.k.a. final alternativo)
			]), 'completed')
		'Exit':
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()
