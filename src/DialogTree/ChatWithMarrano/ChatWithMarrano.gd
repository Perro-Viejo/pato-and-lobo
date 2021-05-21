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
					'Marrano: Aléjate de mi domo y de mí',
					'Pato: Óigame éste... groseris',
				]), 'completed')
		'OptB':
			yield(E.run([
					C.player_say(opt.text),
					'Marrano: Pero si me lambe el rabo',
					'Marrano: No vendo nada ni comparto mi precioso domo...',
					'Pato: ...',
				]), 'completed')
		'OptC':
			yield(E.run([
					C.player_say(opt.text),
					'Marrano: La única persona aquí la mande lejos por no respetar mi privacidad...',
					'Pato: jojojo',
					'Marrano: Seré Marrano pero no huevón...',
				]), 'completed')
		'OptD':
			yield(E.run([
				C.player_say(opt.text),
				C.character_say('Marrano', 'Ábrase de aquí')
			]), 'completed')
			D.finish_dialog()
			return
			
	_show_options()
