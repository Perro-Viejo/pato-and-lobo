tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		'Pato: Vamos a navegar la infinitud amor mío.',
		C.walk_to_clicked(),
		'Lobo: Uiiiiiiiiii',
		C.character_walk_to('Lobo', to_global(E.clicked.walk_to_point))
	]), 'completed')
	E.goto_room('Space')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
