extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: El de la barra dice que me puede tirar al piso',
		'Pato: Por supuesto no me lo voy a tomar...',
		'Pato: Pero me puede servir pa\' algo'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailSecret':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: He creado un coctel fuerte y de sabor clásico',
			I.add_item('CocktailSuper'),
		])
