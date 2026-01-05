extends Control

const PARTICLE = preload("uid://dqr2y6q64nni2")

var current_file : String = ""
var content : String = ""

var frames : PackedStringArray

var can_render := false

@onready var particles_parent = $SubViewportContainer/SubViewport/Rend3dViewer/Particles

var title : String
var number_of_particles : int

var prev_frame := 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not can_render: return
	
	var cur_frame : int = int($FrameSlider.value)
	
	if cur_frame != prev_frame:
		prev_frame = cur_frame
		display_frame(cur_frame)

func _on_file_dialog_button_pressed() -> void:
	$FileDialog.popup()


func _on_file_dialog_file_selected(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	content = file.get_as_text()
	current_file = path
	$FileDialogButton/CurrentFileLabel.text = "Current File Open: " + current_file
	initial_content_scrape()

func display_frame(frame : int):
	var data : String = frames.get(frame)
	print(data)
	var particles = data.split(">,", false, number_of_particles)
	for i in range(number_of_particles):
		var part_data = particles.get(i).split(": ", false)
		print(part_data)
		var raw_poz_str : String = part_data.get(1)# <0.0, 0.0, 0.0> Velocity
		print(raw_poz_str)
		var poz_str := raw_poz_str.split("> Velocity").get(0).substr(1)# 0.0, 0.0, 0.0
		print(poz_str)
		var poz_array = poz_str.split(", ")
		var particle = particles_parent.get_child(i)
		particle.position = Vector3(float(poz_array.get(0)), float(poz_array.get(1)), float(poz_array.get(2)))

func initial_content_scrape():
	frames = content.split("\n")
	title = frames.get(0)
	frames.remove_at(0)# Remove Title
	var info_line = frames.get(0)
	# Particle Count: 9
	number_of_particles = int(info_line.substr(16))
	for child in particles_parent.get_children():
		child.queue_free()
	for i in range(number_of_particles):
		var instance = PARTICLE.instantiate()
		particles_parent.add_child(instance)
	frames.remove_at(0)# Remove Info Line
	$FrameSlider.max_value = len(frames)
	can_render = true
	display_frame(0)
