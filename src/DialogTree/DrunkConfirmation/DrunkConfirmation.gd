tool
extends DialogTree


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func start() -> void:
	yield(E.run([
		'Conejuno: CocktailsMenu-Opt2-Conejuno-01',
	]), 'completed')
	
	# La llamada al método start del padre hace que se muestren las opciones
	.start()


func option_selected(opt: DialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(Globals.get_drunk(), 'completed')
		'Opt2':
			yield(E.run([
				'Conejuno: DrunkConfirmation-Conejuno-01',
			]), 'completed')
			
			D.show_dialog('CocktailsMenu', false)
			return
