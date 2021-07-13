extends ToolbarButton

export(Array, Texture) var btn_states := []
export var states_descriptions := ['colombiano', 'español', 'english']


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	texture_normal = btn_states[E.language_idx]


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_pressed() -> void:
	E.language_idx = wrapi(E.language_idx + 1, 0, btn_states.size())
	texture_normal = btn_states[E.language_idx]

	G.show_info(self.description)


func get_description() -> String:
	return '%s: %s' % [description, E.get_text(states_descriptions[E.language_idx])]


func _translate() -> void:
	._translate()
	texture_normal = btn_states[E.language_idx]
