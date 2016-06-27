Circles = []
circleAmt = 10

for i in [0..circleAmt]
	circle = new Layer
		width: 120
		height: 120
		backgroundColor: "white"
		borderRadius: "50%"
		opacity: 1 - i * 1 / (circleAmt + 1)
	circle.center()
	Circles.push(circle)
	
	
touchCircle = new Layer
	width: 120
	height: 120
	backgroundColor: "lightgreen"
	opacity: 0.7
	x: Screen.width - 150
	y: Screen.height - 150
	borderRadius: "50%"

touchCircle.draggable.enabled = true
touchCircle.draggable.constraints =
	x: 0
	y: 0
	width: Screen.width
	height: Screen.height

touchCircle.onMove ->
	for i in [0...Circles.length]
		Circles[i].animate
			properties:
				backgroundColor: "white"
				x: touchCircle.x
				y: touchCircle.y
			curve: "linear"
			time: i * 0.07

touchCircle.onDragAnimationEnd ->
	this.animate
		properties: 
			backgroundColor: "lightyellow"
			opacity: 1
			scale: 1.6
		time: 0.5
	for i in [0...Circles.length]
		Circles[i].animate
			properties:
				backgroundColor: "yellow"
				scale: i * 1.15
			curve: "spring(200, 5, 0)"

touchCircle.onDragStart ->
	this.animate
		properties: 
			backgroundColor: "yellow"
			opacity: 1
			scale: 1
		time: 0.5
	for i in [0...Circles.length]
		Circles[i].animate
			properties:
				scale: 1
			curve: "linear"
			time: i * 0.09