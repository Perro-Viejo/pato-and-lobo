tool
class_name GAQRoom
extends Resource

export var id := '' setget _set_id
export(String, FILE, "*.tscn") var path = ''
export var scene: PackedScene = null


func _set_id(value: String) -> void:
	id = value
	resource_name = value
	property_list_changed_notify()
