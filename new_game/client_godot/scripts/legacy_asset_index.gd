extends Node

const LEGACY_ROOT := "res://assets/legacy"

var categories := {
	"ui": "res://assets/legacy/ui",
	"characters": "res://assets/legacy/characters",
	"maps": "res://assets/legacy/maps",
	"icons": "res://assets/legacy/icons",
	"effects": "res://assets/legacy/effects",
}


func path_for(category: String, file_name: String) -> String:
	if not categories.has(category):
		push_warning("Categoria de asset desconhecida: %s" % category)
		return "%s/%s" % [LEGACY_ROOT, file_name]
	return "%s/%s" % [categories[category], file_name]
