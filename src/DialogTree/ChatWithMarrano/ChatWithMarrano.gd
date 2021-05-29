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
		"Marrano: Oink, oink."
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'OptA':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: What do you want?",
				"Pato: I'm just saying hi.",
				"Marrano: So you want to steal one of my flowers.",
				"Pato: Of course not. Why would I do that?",
				"Marrano: Because everyone wants to steal my flowers.",
				"Marrano: But no one can.",
				"Pato: I just said... hi.",
			]), 'completed')
			opt.visible = false
			show_option('OptD')
		'OptB':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: No!",
				"Pato: Can you sell me some?",
				"Marrano: Don't sell, don't share. It is all for me and my precious flowers.",
				"Pato: ...",
			]), 'completed')
			opt.visible = false
			show_option('OptC')
			if is_option_visible('OptA'):
				show_option('OptA', false)
				show_option('OptD')
		'OptC':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: What a stupid trick...",
				"Pato: glup",
				"Marrano: You're not trying to steal my water, don't ya?",
				"Pato: I would never do that.",
				"Marrano: Sure. I wouldn't want to have to kill you.",
				"Pato: Why are you so mean?",
				"Marrano: I am a staunch protector of private property.",
			]), 'completed')
			opt.visible = false
		'OptD':
			yield(E.run([
				C.player_say(opt.text),
				"Marrano: It is a Light-vault-3000X.",
				"Marrano: It protects my flowers from being stolen.",
				"Marrano: No one can even touch them... except...",
				"Pato: You.",
				"Marrano: Or something strong enough to break the shield.",
				"Marrano: But that would be impossible.",
				"Pato: Unless you are super strength.",
				"Pato: (Or that you have something heavy enough).",
				"Marrano: Yes."
			]), 'completed')
			E.current_room.state.container_weakness_revealed = true
			E.current_room.get_prop('Container').description = 'Light-vault-3000X'
		'Exit':
			yield(E.run([
				C.player_say(opt.text),
				'Marrano: Yes. You better LEEEEAVE FOREVER!!!!'
			]), 'completed')
			D.finish_dialog()
			return
	_show_options()
