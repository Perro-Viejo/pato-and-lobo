tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(C.character_say('Marrano', 'Oink, oink', false), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'OptA':
			yield(E.run([
					C.player_say(opt.text),
					'Marrano: ...',
					'Marrano: Get away from my dome and me',
					'Pato: You are so... mean',
				]), 'completed')
		'OptB':
			yield(E.run([
					C.player_say(opt.text),
					'Marrano: Lick my balls',
					'Marrano: Don\'t sell, don\'t share. All for me. ',
					'Pato: ...',
				]), 'completed')
		'OptC':
			yield(E.run([
					C.player_say(opt.text),
					'Marrano: What a stupid trick...',
					'Pato: glup',
					'Marrano: Leave my lands. NOW!',
				]), 'completed')
		'OptD':
			yield(E.run([
				C.player_say(opt.text),
				'Marrano: LEEEEAVE!!!!'
			]), 'completed')
			D.finish_dialog()
			return
			
	_show_options()
