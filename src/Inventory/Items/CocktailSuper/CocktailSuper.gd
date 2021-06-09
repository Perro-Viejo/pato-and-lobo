extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: Items-CocktailSuper-Pato-01',
		'Pato: Items-CocktailSuper-Pato-02'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailGolem':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: Items-CocktailSuper-Pato-03',
			I.add_item('CocktailSuper'),
		])
