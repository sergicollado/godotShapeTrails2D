extends Path2D

export (Texture) var head
export (Texture) var body
export (Texture) var tail

export var start_draw = false
export var active_collision = false
export var collision_group = ""
export var radio=0
export (Vector2) var texture_offset = Vector2(0,0)
export (Vector2Array) var points = []

var last_offset = Vector2(0,0)
var polygons
var area
var polygons_points = []

func _ready():
	
	if(get_child_count() > 0):
		for node in get_children():
			if(node.get_type() == "Area2D" or node.get_type() == "StaticBody2D"):
				area = node

	if(collision_group != ""):
		area.add_to_group(collision_group)
	var curve = get_curve()
	if(curve):
		points = curve.get_baked_points()
		
	if(start_draw):
		draw()

func draw():
	makePolys()
	
func makePolys():
	var collisionPoly
	if(polygons):
		polygons.queue_free()
	
	polygons_points.clear()
	polygons = Node2D.new()
	add_child(polygons)
	
	var points_size = points.size()
	var next_coordinates = [];
	var offset = texture_offset
	for i in range(points_size):
		if(i+1>=points_size):
			return
		var texture = body
		if(i==0):
			offset = Vector2(0,0)
			texture = head
		elif(i==points_size-2):
			offset = Vector2(0,0)
			texture = tail

		var start_point = points[i]
		var end_point = points[i+1]
		var next_point = end_point
		if(i+2<points_size):
			next_point = points[i+2]
		
		var poly = makePoly(texture, start_point, end_point, next_point, offset, next_coordinates)
		polygons.add_child(poly)
		var polygon = poly.get_polygon()
		polygons_points.append(polygon)
		next_coordinates=[polygon[1],polygon[2]]
		if(active_collision and area):
			area.clear_shapes()
			var shape = ConcavePolygonShape2D.new()
			shape.set_segments(polygon)
			area.add_shape(shape)

			
			
func makePoly(texture,start_point, end_point, next_point, uv_offset, init_coordinates):	

	var seg_init = (end_point-start_point).normalized()
	var seg_tree = (next_point-start_point).normalized()
	
	var points = []
	if(init_coordinates.size() == 0):
		init_coordinates = [ 
			Vector2(seg_init.y*radio,-seg_init.x*radio)+start_point,
		 	Vector2(-seg_init.y*radio,seg_init.x*radio)+start_point
		]

	points.append(init_coordinates[0])
	points.append(Vector2(seg_tree.y*radio,-seg_tree.x*radio)+end_point)
	points.append(Vector2(-seg_tree.y*radio,seg_tree.x*radio)+end_point)
	points.append(init_coordinates[1])
	
	var poly = Polygon2D.new()
	poly.set_polygon(points)
	poly.set_texture(texture)
	set_uv(texture, poly, uv_offset)

	return poly

func set_uv(texture, poly, uv_offset):
	
	var height = texture.get_height()
	var width = texture.get_width()
	poly.set_uv([Vector2(0,0)+uv_offset,Vector2(0,height)+uv_offset,Vector2(width,height)+uv_offset,Vector2(height,0)+uv_offset])

func _process(delta):
	if(last_offset == texture_offset):
		return
	last_offset = texture_offset
	makePolys()