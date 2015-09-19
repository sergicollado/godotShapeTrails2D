extends Node2D


export (NodePath) var target_path
export var active = false
export var step_distance= 50
export var max_limit = 10
export var active_collision = false
export var collision_group = ""

var target
var distance  = 0
var previous_step
var trail
var points = []
var path


func _ready():
	target = get_node(target_path)
	trail = get_child(0)
	trail.points = points
	if(active_collision):
		trail.active_collision = true
	set_point(target.get_pos())
	
	previous_step = target.get_pos()
	set_fixed_process(true)

	
func _fixed_process(delta):
	if(not active):
		if(points.size()> 0):
			points.clear()
		return
	
	var target_pos = target.get_pos()
	distance += previous_step.distance_to(target_pos)
	if(distance > step_distance):
		set_point(target_pos)
		previous_step = target_pos
		distance = 0
	else:
		if(points.size()>0):
			points[points.size()-1] = target_pos	
	
	if(points.size()>max_limit):
		points.remove(0)
	trail.draw()
		

func set_point(point):
	points.append(point)
