# Script en el que se pueden guardar funciones de uso transversal entre todos
# los nodos y scripts del proyecto
extends Node

func get_screen_coords_for(node: Node) -> Vector2:
	return node.get_viewport().canvas_transform * node.get_global_position()


func get_random_array_element(arr: Array):
	randomize()
	return arr[randi() % arr.size()]


func in_editor() -> bool:
	return OS.has_feature("editor")
