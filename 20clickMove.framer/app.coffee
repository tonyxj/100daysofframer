

bg = new Layer
	backgroundColor: "null"
	width: Screen.width
	height: Screen.height
	x: 0 
	y: 0
# bg.draggable.enabled = true;
# bg.draggable.momentum = false;

circle = new Layer
	backgroundColor: "white"
	borderRadius: "50%"
	width: 100
	height: 100
circle.center()

bg.on Events.TouchMove, (e, layer) ->
	touchEvent = Events.touchEvent(e)
	if Utils.isPhone() || Utils.isTablet()
		tX = touchEvent.clientX - layer.x
		tY = touchEvent.clientY - layer.y
	else 
		tX = touchEvent.offsetX 
		tY = touchEvent.offsetY
# 	print "tX: " + tX + ",  tY: " + tY
	
	pa = (tX - circle.x) * (tX - circle.x) + (tY - circle.y) * (tY - circle.y)
	dist = Math.sqrt(pa)
# 	print dist / 300
	
	circle.animate 
		properties:
			x: tX
			y: tY
			scale: dist / 300
		curve: "linear"
		time: 1	
	 