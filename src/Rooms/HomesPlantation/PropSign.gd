tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run([
				C.walk_to_clicked(),
				'Pato: Echele ojo a esta, está re kiut ^^',
				'Lobo: Awwwww, es la casa de nuestros sueños',
				'Pato: Tengamos relaciones sepsuales en ella :3'
			]), 'completed'
		)
		E.goto_room('Spaceship')
		Globals.did(Globals.GameState.GOT_HOME)

func on_look() -> void:
	E.run([
		'Pato: Fue plantada hace 8 meses, antejardín, dos habitaciones, baño con tina...'
	])


func on_item_used(item: Item) -> void:
	pass
