tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.current_room.state.has_dentures = false
	Globals.did(Globals.GameState.DENTURES_TAKEN)
	E.run([
		C.walk_to_clicked(),
		'Pato: RoomBar-GlassWithDentures-Pato-01',
		C.player.grab(),
		A.play('sfx_dentures_pu', global_position),
		disable(),
		I.add_item('Dentures'),
		'Pato: RoomBar-GlassWithDentures-Pato-02',
		'Pato: RoomBar-GlassWithDentures-Pato-03'
	])


func on_look() -> void:
	E.run([
		C.player_say('RoomBar-GlassWithDentures-Pato-04')
	])


func on_item_used(_item: Item) -> void:
	pass
