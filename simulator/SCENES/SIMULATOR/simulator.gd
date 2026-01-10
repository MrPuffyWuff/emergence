extends Node

const COULOMBS_CONSTANT := 8.987551785972 * 10**9
const GRAVITATIONAL_CONSTANT := 6.67430 * 10**-11

var running_simulation : bool = false

var particles : Array[Particle]

'''
 = [
	Particle.new(Vector3(0,0,0), Particle.PROTON_CHARGE, Particle.PROTON_MASS),
	Particle.new(Vector3(0,1,0), Particle.ELECTRON_CHARGE, Particle.ELECTRON_MASS),
]
'''

var output_string : String = ""

var frame : int = 0
var time_to_simulate : int = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	save_frame()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not running_simulation:
		return
	#Process all particles against each other
	for i_part in particles:
		for o_part in particles:
			if i_part == o_part:
				continue
			apply_coulombs_force(i_part, o_part)
			#apply_gravitational_force(i_part, o_part)
	#Move particles by velocity
	for p in particles:
		p.position += p.velocity
	save_frame()
	#Increment frame
	frame += 1
	if frame == time_to_simulate:
		GlobalsVars.simulation_done.emit()
		running_simulation = false
		var file = FileAccess.open("C:\\Users\\jaspe\\OneDrive\\Documents\\fake_data.txt", FileAccess.WRITE)
		file.store_string(str(output_string))
		file.close()
		print("DONE!")
		return

func save_frame():
	output_string += "["
	for p in particles:
		output_string += str(p)
		output_string += ", "
	output_string += "]\n"

func apply_coulombs_force(a_part : Particle, b_part : Particle) -> void:
	print(10**18)
	print(10**19)
	print(10**20)
	var q1 : float = a_part.charge
	var q2 : float = b_part.charge
	var a_to_b_vec : Vector3 = b_part.position - a_part.position
	var r2 : float = (b_part.position - a_part.position).length_squared()
	var force := COULOMBS_CONSTANT * q1 * q2 / r2
	var force_applied : Vector3 = a_to_b_vec.normalized() * force
	#var delta_v :=  force_applied * GlobalsVars.TIME_STEP / a_part.mass
	#a_part.velocity = a_part.velocity + delta_v

func apply_gravitational_force(a_part : Particle, b_part : Particle) -> void:
	var m1 : float = a_part.mass
	var m2 : float = b_part.mass
	var a_to_b_vec : Vector3 = b_part.position - a_part.position
	var r2 : float = (b_part.position - a_part.position).length_squared()
	var force := GRAVITATIONAL_CONSTANT * m1 * m2 / r2
	var force_applied : Vector3 = a_to_b_vec.normalized() * force
	#var delta_v :=  force_applied * GlobalsVars.TIME_STEP / a_part.mass
	#a_part.velocity = a_part.velocity + delta_v
	
