extends Control

var MAIN_MENU = load("res://SCENES/MAIN/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instantiate_element_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

func make_button(name : String, min_size : Vector2) -> Button:
	var b := Button.new()
	b.text = name
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
