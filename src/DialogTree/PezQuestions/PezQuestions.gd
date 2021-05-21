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
				G.display('Pez abrió sus ojotes como si hubiera visto un muerto'),
				E.wait(3),
				'Pez: Eso era...',
				'...',
				'Pez: Eso era lo que tenía que contar.',
				pez.face_right(),
				'...',
				'Pez: La razón de estar aquí...',
				pez.face_left(),
				'...',
				'Pez: Su nombre era Sudor de Hércules...',
				'Pez: Uno de los tragos más antiguos del continente',
				'Pez: Se sentía como...',
				'...',
				pez.face_right(),
				'Pez: Como estar tomando sudor de un viejo muy viejo...',
				E.wait(2),
				pez.face_left(),
				'Pez: No quiero hablar más del pasado de este lugar.',
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
				'Pez: Ponían otro tipo de música, algo más relajado',
				'Pez: Y las personas que venían solían ser más sociables'
			]), 'completed')
			opt.visible = false
		'Opt3':
			yield(E.run([
				'Pez: Sin duda las bebidas que vendía el anterior dueño',
				'Pez: Solían ser más...',
				pez.face_right(),
				'...',
				'Pez: Mejores',
				E.wait(2),
				pez.face_left()
			]), 'completed')
			opt.visible = false
		'Opt4':
			yield(E.run([
				'Pez: Ciertamente más de uno.',
				'Pez: Antes solía haber un pasadizo secreto donde ahora hay baños.',
				'Pez: Y también estaban las bebidas prohibidas.'
			]), 'completed')
			opt.visible = false
			show_option('Opt5')
		'Opt5':
			yield(E.run([
				'Pez: Sí. Eran muy fuertes y generaron muchos problemas.',
				'Pez: Al final, sólo algunos podíamos beberlas.',
				'...',
				pez.face_right(),
				'Pez: Y entre todas... había una. La más especial de las especiales.'
			]), 'completed')
			opt.visible = false
			show_option('TheQuestion')
		'Exit':
			yield(E.run(['Pez: Como quieras quiero']), 'completed')
			D.show_dialog('ChatWithPez')
			return
	_show_options()
