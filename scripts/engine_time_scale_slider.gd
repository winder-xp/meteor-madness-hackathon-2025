extends HSlider
@onready var spin_box = $SpinBox
@onready var h_slider = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_value_changed(value):
	spin_box.value = value
	Engine.time_scale = value # Replace with function body.


func _on_spin_box_value_changed(value):
	h_slider.value = value
