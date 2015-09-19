
extends Node2D

var trail_movement
var points = []
var static_trail
var polygons = []
var font

func _ready():
	font = preload("res://font.fnt")
	trail_movement = get_parent().get_node("trail_movement")
	static_trail = get_parent().get_node("static_trail")
	static_trail.get_node("Area2D").connect("body_enter",self,"_check_collision")
	
	
	set_fixed_process(true)

func _fixed_process(delta):
	points = trail_movement.points
	update()

func _check_collision(body):
	print("collision ruler")

func _draw():
	if(points.size() > 0):
		var  i = 0
		for point in points:
#			draw_string(font,point,str(i))
#			draw_circle(point,10,Color(100))
			i+=1
			


			