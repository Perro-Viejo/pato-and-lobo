extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	E.run([
		'Pato: Es un trago secreto del bar. Sabor clásico muy poco dulzón.',
		'Pato: Me puede servir pa\' algo'
	])


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailGolem':
		E.run([
			I.remove_item(item.script_name),
			I.remove_item(script_name),
			'Pato: He creado un coctel fuerte y de sabor clásico',
			I.add_item('CocktailSuper'),
		])
