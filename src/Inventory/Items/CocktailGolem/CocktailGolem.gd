extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: Items-GolemCocktail-Pato-01',
		'Pato: Items-GolemCocktail-Pato-02',
		'Pato: Items-GolemCocktail-Pato-03'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailSecret':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: Items-GolemCocktail-Pato-04',
			I.add_item('CocktailSuper'),
		])
