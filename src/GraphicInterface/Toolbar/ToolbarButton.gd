tool
class_name ToolbarButton
extends TextureButton
# warning-ignore-all:return_value_discarded

export var description := '' setget ,get_description
export var script_name := ''
export(Cursor.Type) var cursor

onready var _description_code := description


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	if not description and E.use_translations and Engine.editor_hint:
		description = 'Toolbar-' + name
	
	connect('pressed', self, 'on_pressed')
	connect('mouse_entered', self, '_on_mouse_entered')
	connect('mouse_exited', self, '_on_mouse_exited')
	
	E.connect('language_changed', self, '_translate')
	
	_translate()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func on_pressed() -> void:
	pass


func get_description() -> String:
	return description


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _on_mouse_entered() -> void:
	Cursor.set_cursor(cursor)
	G.show_info(self.description)


func _on_mouse_exited() -> void:
	Cursor.set_cursor()
	G.show_info()


func _translate() -> void:
	if Engine.editor_hint: return
	description = E.get_text(_description_code)
	if has_focus(): G.show_info(self.description)
