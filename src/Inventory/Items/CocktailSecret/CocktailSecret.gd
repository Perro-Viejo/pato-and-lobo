extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: Items-CocktailSecret-Pato-01',
		'Pato: Items-CocktailSecret-Pato-02'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailGolem':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: Items-CocktailSecret-Pato-03',
			A.play('sfx_cocktail_combine', Vector2.ZERO),
			I.add_item('CocktailSuper'),
		])
