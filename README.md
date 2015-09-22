# godotShapeTrails2D
Scripts and scene components to make trails2D in godotEngine

Check demo scene.

<img src="graphics/out.gif" />


There are two main scripts:

	*trails
	*trail_maker


## trails.gd
The first one lets you draw a trail along an *ArrayVector* or curve using three sprites ( head, body, tail)
head and tail only would be drawn one time, and body will be repeated.

You need to apply this script to a Path2D type node.


*Start Draw* checkbox, lets you draw a trail one time.

First be sure to provide an ArrayVector of points, or curve.
If you add a curve, change it *bake interval* parameter to fix amount of points.

Then adjust the trail width *radio*, 

Finally *Active collisions* checkbox will add a shape to an Area2D or StaticBody2D node that you have to add previously as a child to Path2D Trail node.


## trail_maker.gd
The second script **trail_maker.gd** creates an *ArrayVector2d* from  the target position coordinates. *Step distance* sets distance between points.

It Needs to be used in a *Node2D*, with a *trail node* as a first child. 

First assign target node. Be sure this node it's not a child of the **trail_maker.gd** node.

You can enable or disable  trail generation with  *active* checkbox.

*Max limit* lets you limit the total amount of trail points.

*Active collision* set this property in Trail child node. 
