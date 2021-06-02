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
		'Pato: ChatWithVieja-Start-Pato-01',
		'Vieja: ChatWithVieja-Start-Vieja-02',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'Opt1':
			yield(E.run([
				'Vieja: ChatWithVieja-Opt1-Vieja-01',
				'Vieja: ChatWithVieja-Opt1-Vieja-02',
				'Vieja: ChatWithVieja-Opt1-Vieja-03',
				'Vieja: ChatWithVieja-Opt1-Vieja-04',
				'Pato: ChatWithVieja-Opt1-Pato-05'
			]), 'completed')
			opt.visible = false
		'Opt2':
			yield(E.run([
				'Vieja: ChatWithVieja-Opt2-Vieja-01',
				'Vieja: ChatWithVieja-Opt2-Vieja-02',
				'Vieja: ChatWithVieja-Opt2-Vieja-03',
			]), 'completed')
			opt.visible = false
			show_option('Opt3')
		'Opt3':
			yield(E.run([
				'Vieja: ChatWithVieja-Opt3-Vieja-01',
				'Vieja: ChatWithVieja-Opt3-Vieja-02',
				'Pato: ChatWithVieja-Opt3-Pato-03',
				'Vieja: ChatWithVieja-Opt3-Vieja-04',
				'Vieja: ChatWithVieja-Opt3-Vieja-05',
				'Pato: ChatWithVieja-Opt3-Pato-06',
				G.display('ChatWithVieja-Opt3-Game-07'),
				'Vieja: ChatWithVieja-Opt3-Vieja-08',
			]), 'completed')
		'Opt4':
			yield(E.run([
				'Vieja: ChatWithVieja-Opt4-Vieja-01',
				'Vieja: ChatWithVieja-Opt4-Vieja-02',
				'Vieja: ChatWithVieja-Opt4-Vieja-03',
				G.display('ChatWithVieja-Opt4-Game-04'),
				'Pato: ChatWithVieja-Opt4-Pato-05'
			]), 'completed')
			opt.visible = false
		'Exit':
			yield(E.run(['Vieja: ChatWithVieja-Exit-Vieja-01']), 'completed')
			D.finish_dialog()
			return
	_show_options()
