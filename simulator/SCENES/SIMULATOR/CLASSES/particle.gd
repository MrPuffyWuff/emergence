extends Node3D

class_name Particle

const ELECTRON_CHARGE := -1.602 * 10**-19
const NEUTRON_CHARGE := 0
const PROTON_CHARGE := 1.602 * 10**-19

const ELECTRON_MASS := 9.109 * 10**-31
const NEUTRON_MASS := 1.675 * 10**-27
const PROTON_MASS := 1.673 * 10**-27

var rng = RandomNumberGenerator.new()

var velocity : Vector3 = Vector3.ZERO
var charge : float = 0
var mass : float = 0
var id : int = 0

func _init(poz : Vector3, charge_i : float, mass_i : float) -> void:
	position = poz
	charge = charge_i
	mass = mass_i
	id = rng.randi_range(0,100000000000000000)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _to_string() -> String:
	if is_nan(position.x):
		print("Error! Value is: " + str(position.x))
	return "<Particle-ID: " + str(id) + " Position: " + str(position) + " Velocity: " + str(velocity) + ">"
