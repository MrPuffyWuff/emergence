extends Node3D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$MeshInstance3D.material_override = StandardMaterial3D.new()
	$MeshInstance3D.material_override.albedo_color = Color(rng.randf(), rng.randf(), rng.randf())
