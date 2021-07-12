extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play({cue_name = 'sfx_mask_active', pos = Vector2.ZERO, is_in_queue = false})
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(_item: Item) -> void:
	match _item.script_name: 
		'Mask', 'Dentures', 'Legs', 'Tail':
			E.run([
				'Pato: Items-Costume-Pato-01'
			])
		_:
			E.run([
				'Pato: Items-Costume-Pato-02'
			])

