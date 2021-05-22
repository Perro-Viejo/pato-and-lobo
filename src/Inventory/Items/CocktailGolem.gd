extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_cocktail_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: The barman says this one can K.O. me.',
		'Pato: Of course I\'ll not drink it...',
		'Pato: Tho, might be helpful.'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailSecret':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: I\'ve created a strong and elder flavored cocktail',
			I.add_item('CocktailSuper'),
		])
