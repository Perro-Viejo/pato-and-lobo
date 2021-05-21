tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: Hola señora',
		'Vieja: Hola.',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Vieja: Pues la pasaba mejor cuando era más joven. Como tú.',
				'Vieja: Ahora es muy difícil levantar polvo, aunque a veces se logra.',
				'Vieja: Pero cuando era joven...',
				'Vieja: no había noche en la que no me revolcara.',
				'Pato: ¡Ay santo pollo!'
			]), 'completed')
			opt.visible = false
		'Opt2':
			yield(E.run([
				'Vieja: Una mierda como para bebés.',
				'Vieja: Necesito emociones más fuertes en mi vida.',
				'Vieja: Un aventura que me recuerde los locos años de la juventú.',
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			yield(E.run([
				'Vieja: Algo que sea fuerte, pero que sepa a viejo.',
				'Vieja: Ese tal trago del gólem sabe a fresa... guácatelas.',
				'Pato: Fuerte y...',
				'Vieja: Viejo, sí.',
				'Vieja: ¿También te gustan así?',
				'Pato: Emmm....mmmm......mmmmmmm.....',
				G.display('Pato se sonrojó'),
				'Vieja: En mis tiempos no había cocteles. Tomábamos todo puro.',
				'Vieja: ¿CÓMO ES POSIBLE QUE EN ESTE LUGAR NO VENDAN ALGO ASÍ?',
			]), 'completed')
		'Opt4':
			yield(E.run([
				'Vieja: jijijijijiji.... gracias por el cumplido, pero son postizos.',
				'Vieja: Aprovecha tus dientes mientras puedas.',
				'Vieja: jijijijijiji',
				G.display('La vieja se sacó la dentadura e hizo piruetas'),
				'Pato: ....(vieja puerca)'
			]), 'completed')
			opt.visible = false
		'Exit':
			yield(E.run(['Vieja: Que se diviertas... jijijijijiji']), 'completed')
			D.finish_dialog()
			return
	_show_options()
