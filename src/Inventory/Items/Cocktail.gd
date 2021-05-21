extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: El de la barra dice que me puede tirar al piso',
		'Pato: Por supuesto no me lo voy a tomar...',
		'Pato: Pero me puede servir pa\' algo'
	])


func on_item_used(item: Item) -> void:
	.on_item_used(item)
