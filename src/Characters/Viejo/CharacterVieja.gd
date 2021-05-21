tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	D.show_dialog('ChatWithVieja')


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'Cocktail':
		E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Vea señora. Le invito este traguito.',
			'Pato: Es suavezongo congo. Como pa usté.',
			'Vieja: pffffffffffffff'
		])


func get_dialog_pos() -> float:
	return $AnimatedSprite.position.y - 32.0
