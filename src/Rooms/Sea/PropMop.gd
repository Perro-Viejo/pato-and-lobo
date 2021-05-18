tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		C.walk_to_clicked(),
		C.player_say('Esta re puerco pero creo que me servirá.'),
		disable(),
		I.add_item('Mop'),
		C.player_say('Esto huele a miaos... :('),
		C.player_say('Pero es medio largo.')
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
