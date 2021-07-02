extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play({cue_name = 'sfx_cocktail_active', pos = Vector2.ZERO, is_in_queue = false})
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
			A.play({cue_name = 'sfx_cocktail_combine', pos = Vector2.ZERO}),
			I.add_item('CocktailSuper'),
		])
