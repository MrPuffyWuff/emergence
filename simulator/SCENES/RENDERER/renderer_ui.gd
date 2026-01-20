extends Control

var MAIN_MENU = load("res://SCENES/MAIN/main_menu.tscn")
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
	if $PlayButton.button_pressed:
		$FrameSlider.value += 1
		
	render_frames(delta)

func render_frames(delta : float):
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
	var particles := data.split(";", false, number_of_particles)
	for i in range(number_of_particles):
		var p_parts := particles[i].split("_")
		var vel_str := p_parts[0].split(",")
		var p : Particle = particles_parent.get_child(i)
		p.position = Vector3(float(vel_str[0]),float(vel_str[1]),float(vel_str[2]))
		var charge = float(p_parts[3])
		if charge in p.colors:
			p.cur_color = p.colors[float(p_parts[3])]
		else:
			p.cur_color = Color(2.0, 0.0, 0.0, 1.0)
		if p_parts.size() >= 5:
			var is_quantum : String = p_parts[4]
			if is_quantum == 'true':
				p.cur_color = Color(0.0, 2.0, 0.0, 1.0)

func initial_content_scrape():
	frames = content.split("\n")
	print(len(frames))
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
	$FrameSlider.max_value = len(frames) - 2
	can_render = true
	display_frame(0)


func _on_back_button_pressed() -> void:
	SceneSwitcher.goto_scene(MAIN_MENU)
