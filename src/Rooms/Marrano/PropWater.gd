	tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.DOME_SPOTTED):
		E.run([
			'Pato: Mmmm, ese cerdo no se quita de ahí',
			'Pato: No se si pueda convencerlo...',
		])
	else:
		yield(
			E.run([
			'Pato: ¡Ya lo tengo!',
			'Pato: ¡Telestransportame con prontitud!',
			'Lobo: Listongolo',
		]), 'completed')
		E.goto_room('Spaceship')
		Globals.did(Globals.GameState.WATER_TAKEN)


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
