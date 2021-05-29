	tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.DOME_SPOTTED):
		E.run([
			C.walk_to_clicked(),
			C.player.face_up_right(),
			'Pato: Can I...',
			'Marrano: You touch it, I kill you.',
			C.player.face_right(),
			'Pato: Ok ok...'
		])
	else:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: It is mine!!!',
			disable(),
			A.play('sfx_watercase_pu', global_position),
			I.add_item('WaterCase'),
			'Pato: My love. Use the teleport ray to take me out of here.',
			'Lobo: As you command, love of my loves',
		]), 'completed')
		Globals.did(Globals.GameState.WATER_TAKEN)
		E.goto_room('Spaceship')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
