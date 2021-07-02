extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play({cue_name = 'sfx_watercase_active', pos = Vector2.ZERO, is_in_queue = false})
	.on_interact()


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	A.play({cue_name = 'sfx_watercase_use', pos = C.player.global_position, is_in_queue = false})
	.on_item_used(item)
