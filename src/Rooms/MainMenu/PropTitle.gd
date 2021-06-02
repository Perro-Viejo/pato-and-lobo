tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	E.run([
		'Pato: RoomMainMenu-Title-Pato-01',
		'...',
		'Pato: RoomMainMenu-Title-Pato-02'
	])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
