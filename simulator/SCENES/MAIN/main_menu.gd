extends Control

var SIMULATOR_UI = load("res://SCENES/SIMULATOR/simulator_ui.tscn")
var RENDERER_UI = load("uid://cw8exqfcgtmm0")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_simulator_button_pressed() -> void:
	SceneSwitcher.goto_scene(SIMULATOR_UI)


func _on_renderer_button_pressed() -> void:
	SceneSwitcher.goto_scene(RENDERER_UI)
