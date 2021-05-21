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
			'Conejuno: ¿Qué le sirvo mijín?'
		]),
		'completed'
	)
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			if Globals.asked_polas == 0:
				yield(E.run([
					C.player_say(opt.text),
					'Conejuno: Se nos acabó la pola',
				]), 'completed')
			else:
				yield(E.run([
					C.player_say(opt.text),
					'Conejuno: ...',
					'Conejuno: ¡Que se nos acabó la pola!',
				]), 'completed')
			Globals.asked_polas += 1
		'Opt2':
			yield(E.run([
				C.player_say(opt.text),
				'Conejuno: Entonces ábrase'
			]), 'completed')
			D.emit_signal('dialog_finished')
			return
	_show_options()
