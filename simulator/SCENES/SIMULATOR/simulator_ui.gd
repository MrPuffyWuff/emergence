extends Control

var MAIN_MENU = load("res://SCENES/MAIN/main_menu.tscn")

var cur_mass : float = 0.0
var cur_charge : int = 0.0
var cur_position : Vector3 = Vector3.ZERO
var cur_velocity : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instantiate_element_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cur_mass = $SelectionPanel/MassInput/FloatInput.value
	cur_charge = $SelectionPanel/ChargeInput/IntInput.value
	cur_position = Vector3(
		$SelectionPanel/PositionInput/XInput.value,
		$SelectionPanel/PositionInput/YInput.value,
		$SelectionPanel/PositionInput/ZInput.value,
	)
	cur_velocity = Vector3(
		$SelectionPanel/VelocityInput/XInput.value,
		$SelectionPanel/VelocityInput/YInput.value,
		$SelectionPanel/VelocityInput/ZInput.value,
	)
	$Preview/Content.text = "Mass: " + str(cur_mass) + "\nCharge: " + str(cur_charge) + "\nPosition: " + str(cur_position) + "\nVelocity: " + str(cur_velocity)

func instantiate_element_buttons():
	var elements : GridContainer = $TabContainer/Elements
	var b_size := Vector2(80, 80)
	elements.custom_minimum_size.x = b_size.x * elements.columns
	#Hydrogen and Helium
	elements.add_child(make_button("H", b_size))
	for i in range(6):
		elements.add_child(make_spacer(b_size))
	elements.add_child(make_button("He", b_size))
	var element_names = ["Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar"]
	for name in element_names:
		elements.add_child(make_button(name, b_size))

func make_button(namei : String, min_size : Vector2) -> Button:
	var b := Button.new()
	b.text = namei
	b.custom_minimum_size = min_size
	return b

func make_spacer(min_size : Vector2) -> Variant:
	var s := Label.new()
	s.custom_minimum_size = min_size
	#var style_box := StyleBoxFlat.new()
	#style_box.bg_color = Color(0, 0, 0, 0)
	#s.add_theme_stylebox_override("normal", style_box)
	return s

func _on_back_button_pressed() -> void:
	SceneSwitcher.goto_scene(MAIN_MENU)

func _on_simulate_button_pressed() -> void:
	pass

func _on_reset_button_pressed() -> void:
	cur_mass = 0.0
	cur_charge = 0.0
	cur_position = Vector3.ZERO
	cur_velocity = Vector3.ZERO
	$SelectionPanel/MassInput/FloatInput.value = 0
	$SelectionPanel/ChargeInput/IntInput.value = 0
	$SelectionPanel/PositionInput/XInput.value = 0
	$SelectionPanel/PositionInput/YInput.value = 0
	$SelectionPanel/PositionInput/ZInput.value = 0
	$SelectionPanel/VelocityInput/XInput.value = 0
	$SelectionPanel/VelocityInput/YInput.value = 0
	$SelectionPanel/VelocityInput/ZInput.value = 0
