extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: One of the forbidden drinks. With a flavor of an old man so old.',
		'Pato: Can be useful.'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailGolem':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: I\'ve created a strong and elder flavored cocktail',
			I.add_item('CocktailSuper'),
		])
