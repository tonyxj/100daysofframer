
scroll = new ScrollComponent
	size: Screen.size
	scrollVertical: false
	speedX: 0.6
scroll.content.backgroundColor = null

size = 480

swipeText = new Layer
	html: "Swipe Left"
	parent: scroll.content
	width: size
	color: "#000"
	x: Align.center
	y: Align.center(60)
	backgroundColor: null
	style:
		fontSize: "5rem"
		textAlign: "center"

container = new Layer
	size: Screen.size
	backgroundColor: "#fff"
	contrast: 5000
	opacity: 1

blurSide = new Layer
	height: Screen.height
	width: Screen.width/3
	x: Screen.width
	superLayer: container
	backgroundColor: "#000"
	blur: 50

circle = new Layer
	size: size
	y: Align.center
	x: Screen.width + size
	backgroundColor: "#000"
	borderRadius: "50%"
	opacity: 1
	superLayer: container
	blur: 50

circleText = new Layer
	html: "Gooey"
	width: size
	color: "#fff"
	x: Align.center
	y: Align.center
	backgroundColor: null
	style:
		fontSize: "3.8rem"
		lineHeight: "12rem"
		textAlign: "center"
		fontWeight: 300

scroll.on Events.Move, ->
	print scroll.scrollX
	circle.x = Utils.modulate(scroll.scrollX, [0, 100], [Screen.width + size, Screen.width/2-size/2], true)
	circle.scale = Utils.modulate(scroll.scrollX, [0, 100], [0, 1], true)
	swipeText.opacity = Utils.modulate(scroll.scrollX, [0, 70], [1, 0], true)
	
	circleText.x = Utils.modulate(scroll.scrollX, [0, 100], [Screen.width + size, Screen.width/2-size/2], true)
	circleText.scale = Utils.modulate(scroll.scrollX, [0, 100], [0, 1.2], true)
	circleText.opacity = Utils.modulate(scroll.scrollX, [50, 100], [-1, 1], true)

scroll.bringToFront()




