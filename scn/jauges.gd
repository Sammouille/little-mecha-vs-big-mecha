extends Control

var hp_max:= 1.0
var endu_max:= 1.0

var memoire_hp:= 1.0
var memoire_endu:= 1.0

var tsize = size.y / 3.0

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2(-4.0, tsize), Vector2(hp_max * 0.5 * size.x + 4, tsize), Color.DARK_RED, 22)
	draw_line(Vector2(-4.0, tsize * 2.0), Vector2(endu_max * 0.4 * size.x + 4, tsize * 2.0), Color.DARK_OLIVE_GREEN, 22)
	
	draw_line(Vector2(0.0, tsize), Vector2(memoire_hp * 0.5 * size.x, tsize), Color.RED, 14)
	draw_line(Vector2(0.0, tsize * 2.0), Vector2(memoire_endu * 0.4 * size.x, tsize * 2.0), Color.YELLOW_GREEN, 14)
	
