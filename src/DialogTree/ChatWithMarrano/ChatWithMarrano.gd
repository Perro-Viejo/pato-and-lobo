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
		"Marrano: ChatWithMarrano-Start-Marrano-01"
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: ChatWithMarrano-Opt1-Marrano-01",
				"Pato: ChatWithMarrano-Opt1-Pato-02",
				"Marrano: ChatWithMarrano-Opt1-Marrano-03",
				"Pato: ChatWithMarrano-Opt1-Pato-04",
				"Marrano: ChatWithMarrano-Opt1-Marrano-05",
				"Marrano: ChatWithMarrano-Opt1-Marrano-06",
				"Pato: ChatWithMarrano-Opt1-Pato-07",
			]), 'completed')
			opt.visible = false
			show_option('Opt4')
		'Opt2':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: ChatWithMarrano-Opt2-Marrano-01",
				"Pato: ChatWithMarrano-Opt2-Pato-02",
				"Marrano: ChatWithMarrano-Opt2-Marrano-03",
				"Pato: ChatWithMarrano-Opt2-Pato-04",
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
			if is_option_visible('Opt1'):
				show_option('Opt1', false)
				show_option('Opt4')
		'Opt3':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: ChatWithMarrano-Opt3-Marrano-01",
				"Pato: ChatWithMarrano-Opt3-Pato-02",
				"Marrano: ChatWithMarrano-Opt3-Marrano-03",
				"Pato: ChatWithMarrano-Opt3-Pato-04",
				"Marrano: ChatWithMarrano-Opt3-Marrano-05",
				"Pato: ChatWithMarrano-Opt3-Pato-06",
				"Marrano: ChatWithMarrano-Opt3-Marrano-07",
			]), 'completed')
			opt.visible = false
		'Opt4':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: ChatWithMarrano-Opt4-Marrano-01",
				"Marrano: ChatWithMarrano-Opt4-Marrano-02",
				"Marrano: ChatWithMarrano-Opt4-Marrano-03",
				"Pato: ChatWithMarrano-Opt4-Pato-04",
				"Marrano: ChatWithMarrano-Opt4-Marrano-05",
				"Marrano: ChatWithMarrano-Opt4-Marrano-06",
				"Pato: ChatWithMarrano-Opt4-Pato-07",
				"Pato: ChatWithMarrano-Opt4-Pato-08",
				"Marrano: ChatWithMarrano-Opt4-Marrano-09"
			]), 'completed')
			E.current_room.state.container_weakness_revealed = true
			E.current_room.get_prop('Container').description = 'Light-vault-3000X'
		'Exit':
			yield(E.run([
				C.player_say(opt.text),
				'Marrano: ChatWithMarrano-Exit-Marrano-01'
			]), 'completed')
			D.finish_dialog()
			return
	_show_options()
