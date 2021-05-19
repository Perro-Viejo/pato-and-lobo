tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	pass


func on_look() -> void:
	E.run(['Pato: Ese es el lavamanos.'])


func on_item_used(_item: Item) -> void:
	pass
