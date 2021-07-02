tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	# Aquí van las instrucciones que se ejecutarán antes de que se muestren las
	# opciones del diálogo
	# P.e. Hacer que el personaje jugable mire al personaje con el que va a hablar,
	# camine hasta éste y lo salude (o sea saludado).
	yield(E.run([
		'Conejuno: CocktailsMenu-Start-Conejuno-01',
		'Conejuno: CocktailsMenu-Start-Conejuno-02'
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	yield(
		E.run([C.player_say(
			'%s %s' % [E.get_text(opt.text), E.get_text('CocktailsMenu-Please')]
		)]),
		'completed'
	)
	match opt.id:
		'Opt1':
			yield(E.run([
				'Conejuno: CocktailsMenu-Opt1-Conejuno-01',
				'Conejuno: CocktailsMenu-Opt1-Conejuno-02',
				'Pato: CocktailsMenu-Opt1-Pato-03',
				A.play({cue_name = 'sfx_prepare_drink', pos = C.player.global_position, is_in_queue = true, wait_audio_complete = true}),
				A.play({cue_name = 'sfx_cocktail_pu', pos = C.player.global_position}),
				I.add_item('CocktailGolem'),
			]), 'completed')
		'Opt2':
			yield(Globals.get_drunk(), 'completed')
		'Opt3':
			yield(E.run([
				'Conejuno: CocktailsMenu-Opt3-Conejuno-01',
				'Conejuno: CocktailsMenu-Opt3-Conejuno-02',
				'Conejuno: CocktailsMenu-Opt3-Conejuno-03',
				A.play({cue_name = 'sfx_prepare_drink', pos = C.player.global_position, is_in_queue = true, wait_audio_complete = true}),
				'Conejuno: CocktailsMenu-Opt3-Conejuno-04',
				A.play({cue_name = 'sfx_cocktail_pu', pos = C.player.global_position}),
				I.add_item('CocktailSecret')
			]), 'completed')
		'Exit':
			D.show_dialog('ChatWithConejuno')
			return
	D.finish_dialog()
