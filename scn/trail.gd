@tool
extends MeshInstance3D

@export_range(3,100,1,"prefer_slider") var max_points:= 30:
	set(value):
		_update_max_points(value)

var position_history: Array[Vector3] = []

func _update_max_points(value: int):
	if not is_inside_tree(): return
	
	max_points = value
	material_override.set_shader_parameter("MAX_POINTS", max_points)
	_adjust_history_size()


func _adjust_history_size():
	if position_history.size() != max_points:
		position_history.resize(max_points)
		position_history.fill(global_position)

func _ready() -> void:
	_adjust_history_size()

func _process(delta: float) -> void:
	position_history.insert(0, global_position)
	position_history.pop_back()
	
	if material_override:
		material_override.set_shader_parameter('positions', position_history)
