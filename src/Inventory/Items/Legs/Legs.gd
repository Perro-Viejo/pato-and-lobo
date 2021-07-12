extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	match item.script_name: 
		'Mask', 'Dentures', 'Legs', 'Tail':
			E.run([
				'Pato: Items-Costume-Pato-01'
			])
		_:
			E.run([
				'Pato: Items-Costume-Pato-02'
			])

