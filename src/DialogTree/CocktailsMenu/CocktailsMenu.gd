tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		'Conejuno: The bar is not responsible for what may happen',
		'Conejuno: But I offer you these cocktails'
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(
		E.run([C.player_say(opt.text + ', por favor.')]),
		'completed'
	)
	match opt.id:
		'Opt1':
			yield(E.run([
				'Conejuno: I warn you that this can KO you',
				'Conejuno: Drink it slowly... no hurries',
				'Pato: Ok. Thanks.',
				A.play('sfx_prepare_drink', C.player.global_position, true, true),
				A.play('sfx_cocktail_pu', C.player.global_position),
				I.add_item('CocktailGolem'),
			]), 'completed')
		'Opt2':
			yield(E.run([
				'Conejuno: Wanna erase your memories, don\'t you?',
				'Conejuno: Be careful',
				'Pato: Mmmmmmm.....',
				G.display('Pato had an idea...'),
				'Pato: Ok... (nosy)',
				#TODO: ¿Subirle el coraje cuando se tome este? (a.k.a. final alternativo)
			]), 'completed')
		'Opt3':
			yield(E.run([
				'Conejuno: So you know about our forbidden drinks?',
				'Conejuno: Now I like you.',
				'Conejuno: Just... let me prepare the ingredients',
				A.play('sfx_prepare_drink', C.player.global_position, true, true),
				'Conejuno: Here it is. Classic flavor, but nothing strong.',
				A.play('sfx_cocktail_pu', C.player.global_position),
				I.add_item('CocktailSecret')
			]), 'completed')
		'Exit':
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()
