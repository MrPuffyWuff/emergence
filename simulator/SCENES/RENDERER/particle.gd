extends Node3D

class_name Particle

var rng = RandomNumberGenerator.new()

var colors : Dictionary[float, Color] = {
	0.0 : Color(0.461, 0.461, 0.461, 1.0),
	-1.0 : Color(0.0, 0.0, 2.0, 1.0)
}

var cur_color : Color = colors[0]

func _ready() -> void:
	$MeshInstance3D.material_override = StandardMaterial3D.new()

func _process(delta: float) -> void:
	$MeshInstance3D.material_override.albedo_color = cur_color
