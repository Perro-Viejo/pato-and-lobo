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
		'Pato: Hi ma\'am',
		'Vieja: Hi',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Vieja: Well, I had a better time when I was younger. Like you.',
				'Vieja: Now it is very difficult to flirt, although sometimes it is achieved.',
				'Vieja: But in my younger days...',
				'Vieja: Ouuueeeee!',
				'Pato: Oh my!'
			]), 'completed')
			opt.visible = false
		'Opt2':
			yield(E.run([
				'Vieja: Something for babies.',
				'Vieja: I need stronger emotions in my life.',
				'Vieja: An adventure that reminds me of the crazy youth years.',
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			yield(E.run([
				'Vieja: Something strong, but that tastes old.',
				'Vieja: That Golem cocktail is poop',
				'Pato: Strong that...',
				'Vieja: tastes old.',
				'Vieja: Do you like them like that too?',
				'Pato: Emmm....mmmm......mmmmmmm.....',
				G.display('Pato blushed'),
				'Vieja: In my time there were no cocktails. We drank everything pure.',
			]), 'completed')
		'Opt4':
			yield(E.run([
				'Vieja: hihihihihihi.... thanks for the compliment, but I use dentures.',
				'Vieja: Take advantage of your teeth while you can.',
				'Vieja: hihihihihihi',
				G.display('The old woman took out her dentures and played with them'),
				'Pato: ....'
			]), 'completed')
			opt.visible = false
		'Exit':
			yield(E.run(['Vieja: Have fun young and pretty lady... hihihihihihi']), 'completed')
			D.finish_dialog()
			return
	_show_options()
