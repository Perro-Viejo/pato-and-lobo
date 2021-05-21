tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		'Pato: This might be the name of the game',
		'...',
		'Pato: Sounds exciting...'
	])


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
