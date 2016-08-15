# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Rebound Drag'n'Roll"
	author: "Tony Jing (Original: benjamin saravia)"
	twitter: ""
	description: "Another take on 3D dragging with interactivity. Disclaimer: Much of the code here were a direct copy of Benjamin Sravia's original demo. I did use another approach for the drag and spin logic."


Drag = new Layer
	frame: Screen.frame
	scale: 3
	opacity: 0

Drag.draggable.enabled = true

CoreSize = 90
coreA = new Layer
	backgroundColor: null, size: CoreSize
	x: Align.center, y: Align.center
	scale: 0.5
	
window.onresize = -> coreA.center()

CircleSize = 130
Distance = 3
for i in [0..9]
	circle =  new Layer
		size: CircleSize, borderRadius: CircleSize/2
		backgroundColor: "hsl(#{390+i*50},60, 50)"
		parent: coreA, y: Align.center
		rotation: 36 * i
		originX: Distance, x: CircleSize*-Distance + CoreSize/2
		opacity: .5

#==============Dragging ==============

Drag.onDrag ->
	coreA.animateStop()

Drag.onMove ->
	oldRotation = coreA.rotation
	x = @.draggable.offset.x
	y = @.draggable.offset.y
	dist = Math.sqrt(x*x + y*y)
	if @.draggable.direction is "left" or @.draggable.direction is "up"
		dist = -dist
	coreA.rotation = dist
	
Drag.onDragAnimationEnd ->
	@.x =0; @.y=0
	