# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


COLOR = Utils.randomColor().darken(20)
ACCELERATION = 80
boxCopyNum = 8
copy = []

background = new BackgroundLayer 
	backgroundColor: COLOR, opacity: 0.08

perspectiveArea = new Layer
	perspective: 900, size: Screen, backgroundColor: ""

box = new Layer
	size: 140, borderRadius: 4, z: 130, opacity: 0.3
	backgroundColor: COLOR.darken(10)
	superLayer: perspectiveArea
box.center()

BOX_ORIGINAL = box.props
box.draggable.enabled = true

box.on Events.TouchStart, (event) ->
	@originX = event.offsetX / @width
	@originY = event.offsetY / @height
	
	@animate 
		properties: 
			scale: 1.05, brightness: 90
		curve: "spring(200, 14, 10, 0)"

box.on Events.DragMove, (event) ->
	moveX = box.midX - Screen.width/2
	moveY = box.midY - Screen.height/2
	xVal = 0
	yVal = 0
	if @originY >= 0.5 
		xVal = - Utils.modulate @draggable.calculateVelocity().y, [-1, 1], [-45, 30], true
	else 
		xVal = - Utils.modulate @draggable.calculateVelocity().y, [-1, 1], [-30, 45], true
	
	if @originX >= 0.5
		yVal = Utils.modulate @draggable.calculateVelocity().x, [-1, 1], [-45, 30], true
	else 
		yVal = Utils.modulate @draggable.calculateVelocity().x, [-1, 1], [-30, 45], true

	@animate
		properties:
			rotationX: xVal
			rotationY: yVal
		curve: "spring(200, 18, 10, 0.1)"
	
	for layer, i in copy
		layer.animate
			properties:
				rotationX: xVal
				rotationY: yVal 
				x: Align.center(moveX/(i + 1))
				y: Align.center(moveY/(i + 1))
			curve: "spring(200, 18, 10, 0.1)"

box.on Events.DragEnd, ->
	@animateStop
	@animate
		properties:
			rotationX: BOX_ORIGINAL.rotationX
			rotationY: BOX_ORIGINAL.rotationY
			rotationZ: BOX_ORIGINAL.rotationZ
			scale: BOX_ORIGINAL.scale
			brightness: BOX_ORIGINAL.brightness
			y: BOX_ORIGINAL.y
			x: BOX_ORIGINAL.x
		curve: "spring(200, 30, 0, 0, 0.1)"
	for layer, i in copy
		layer.animate
			properties:
				rotationX: 0
				rotationY: 0 
				x: Align.center
				y: Align.center
			curve: "spring(200, 30, 0, 0, 0.1)"

for i in [0...boxCopyNum]
	boxCopy = new Layer
		size: box.size, borderRadius: 4
		scale: 1.2 - (i * 0.18)
		backgroundColor: COLOR.darken(i + 9)
		z: 100 / boxCopyNum * (i+1)
		opacity: 0.2
	boxCopy.center()
	copy.push(boxCopy)
	