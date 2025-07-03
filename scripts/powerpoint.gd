extends Node2D
@onready var shader_transition: ColorRect = $shader_transition

var shader_time = 0

func _ready() -> void:
	shader_transition.material.set_shader_parameter("u_time", 0.0)

func _process(delta: float) -> void:
	#shader_transition.visible = true
	shader_time += delta
	shader_transition.material.set_shader_parameter("u_time", shader_time)
