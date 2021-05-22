tool
extends DialogTree

onready var pez: Character = null


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	pez = C.get_character('Pez')

	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(E.run([C.player_say(opt.text)]), 'completed')
	match opt.id:
		'TheQuestion':
			yield(E.run([
				G.display('Pez opened his eyes as if he had seen a dead being'),
				E.wait(3),
				'Pez: That was...',
				'...',
				'Pez: That was what I had to tell.',
				pez.face_right(),
				'...',
				'Pez: The purpose of being here...',
				pez.face_left(),
				'...',
				'Pez: It\'s name was Hercules sweat...',
				'Pez: One of the oldest drinks of the continent',
				'Pez: It felt like...',
				'...',
				pez.face_right(),
				'Pez: Like being drinking the sweat of an old man so old...',
				E.wait(2),
				pez.face_left(),
				'Pez: I don\'t want to talk about the past of this place anymore.',
				pez.face_right()
			]), 'completed')
			E.current_room.state.cocktail_unlocked = true
			D.get_dialog_tree('CocktailsMenu').show_option('Opt3')
			D.get_dialog_tree('ChatWithPez').show_option('Opt6', false)
			opt.visible = false
			D.finish_dialog()
			return
		'Opt2':
			yield(E.run([
				'Pez: They played another type of music, something looser',
				'Pez: And people that would come used to be more social'
			]), 'completed')
			opt.visible = false
		'Opt3':
			yield(E.run([
				'Pez: Without any doubt the drinks that the last owner sold',
				'Pez: Used to be...',
				pez.face_right(),
				'...',
				'Pez: Better',
				E.wait(2),
				pez.face_left()
			]), 'completed')
			opt.visible = false
		'Opt4':
			yield(E.run([
				'Pez: Certainly two or more.',
				'Pez: Before, there was a secret passage where the washroom is located.',
				'Pez: And also the forbidden drinks.'
			]), 'completed')
			opt.visible = false
			show_option('Opt5')
		'Opt5':
			yield(E.run([
				'Pez: Yeah. Those were very strong and made a lot of issues.',
				'Pez: At the end, only a few (me included, of course) could drink them.',
				'...',
				pez.face_right(),
				'Pez: And between them all... There was one. The most special of the specials.'
			]), 'completed')
			opt.visible = false
			show_option('TheQuestion')
		'Exit':
			yield(E.run(['Pez: As you want I want']), 'completed')
			D.show_dialog('ChatWithPez')
			return
	_show_options()
