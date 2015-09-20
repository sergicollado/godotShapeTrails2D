
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
	var area = get_parent().get_node("static_trail/Area2D")
	area.connect("body_enter",self,"_check_collision")
	
	
	set_fixed_process(true)

func _fixed_process(delta):
	points = trail_movement.points
	polygons = static_trail.polygons_points
	update()

func _check_collision(body):
	print("collision ruler")
	print(body.get_name())

func _draw():
	if(points.size() > 0):
		var  i = 0
		for point in points:
#			draw_string(font,point,str(i))
#			draw_circle(point,10,Color(100))
			i+=1
#	if(polygons.size()>0):
#		var i = 0
#		for point in polygons[5]:
#			draw_string(font,point,str(i))
#			i+=1
#

			