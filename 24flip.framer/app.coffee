bg = new BackgroundLayer
	backgroundColor: "white"
	scale: 2
	z: -200
	html: "Flip the Card"
	style:
		color: "black"
		textAlign: "center"
		paddingTop: "500px"
		fontSize: "3rem"

Framer.Defaults.Animation = 
	curve: "ease"
	time:  0.25

cover = new Layer
	width: 600
	height: 500
	y: 700
	x: 75
	clip: true
	backgroundColor: "purple"
	html: 'Scroll down to see gradient.'
	style: 
		fontSize: "2rem"
		textAlign: "center"
		lineHeight: "4rem"
		paddingTop: "100px"
cover.states.add
	up:
		x: 75
		y: 700
		width: 600
		height: 500
		scale: 1
	full:
		y: 800
		scale: 1.4

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	visible: false
	scrollHorizontal: false
	
scrolling = new Layer
	x: 0
	y: 0
	height: 2555
	width: Screen.width
	parent: scroll.content
	scale: 1.4
	backgroundColor: "purple"
	html: 'Scroll down to see gradient.'
	style: 
		fontSize: "2rem"
		textAlign: "center"
		lineHeight: "4rem"
		paddingTop: "965px"
		background: "linear-gradient(180deg, purple 60%, orange 99%)"



invisibleTop = new Layer
	width: Screen.width
	height: 700
	y: 0
	originY: 1
	opacity: 0
	clip: true
invisibleTop.states.add
	down:
		rotationX: -180
	moving:
		scale: 0.9
		y: 100
		height: 632
	default1:
		width: Screen.width
		height: 700
		y: 0
		rotationX: 0
		opacity: 1
		scale: 1
		

invisibleBottom = new Layer
	width: Screen.width
	height: 1334-700
	y: 700
	opacity:  0
	clip: true
invisibleBottom.states.add
	moving:
		scale: 0.9
	default1:
		width: Screen.width
		height: 1334-700
		y: 700
		opacity:  1
		scale: 1
		

scrolling1 = new Layer
	x: Align.center
	y: 0
	height: 2555 * 1.4
	width: Screen.width * 1.4
	parent: invisibleTop
	backgroundColor: "purple"
	html: 'Scroll down to see gradient.'
	style: 
		fontSize: "2.782rem"
		textAlign: "center"
		lineHeight: "4rem"
		paddingTop: "853px"
		background: "linear-gradient(180deg, purple 43%, orange 99%)"

scrolling2 = new Layer
	x: Align.center
	y: -700
	height: 2555 * 1.4
	width: Screen.width * 1.4
	parent: invisibleBottom
	backgroundColor: "purple"
	html: 'Scroll down to see gradient.'
	style: 
		fontSize: "2.782rem"
		textAlign: "center"
		lineHeight: "4rem"
		paddingTop: "853px"
		background: "linear-gradient(180deg, purple 45%, orange 85%)"

articleCover = new Layer
	width: 600
	height: 500
	y: 700
	x: 75
	backgroundColor: ""
articleCover.states.add 
	up:
		y: 100
		x: 75

articleCover.draggable.enabled = true
articleCover.draggable.speedY = 0.65
articleCover.draggable.speedX = 0.15

articleCoverReal2 = new Layer
	width: articleCover.screenFrame.width
	height: articleCover.screenFrame.height
	x: articleCover.screenFrame.x
	y: articleCover.screenFrame.y
	backgroundColor: "purple"
	rotationY: 180
	originY: 0
articleCoverReal2.states.add
	up: 
		x: 75
		width: 600
		height: 500
		rotationX: 180
	full: 
		scale: 1.4

articleCoverReal = new Layer
	width: articleCover.screenFrame.width
	height: articleCover.screenFrame.height
	x: articleCover.screenFrame.x
	y: articleCover.screenFrame.y
	backgroundColor: "lightgreen"
	originY: 0
# 	z: 150
# 	scale: 0.88
articleCoverReal.states.add
	up: 
		x: 75
		width: 600
		height: 500
		rotationX: 180
	full: 
		scale: 1.4


greenTop = new Layer
	width: Screen.width
	height: 700
	backgroundColor: "lightGreen"
	opacity: 0
	originY: 1
	scale: 1
greenTop.states.add
	down:
		rotationX: -180
		opacity: 1
	moving:
		y: 100
		height: 632
		width: Screen.width * 0.9
		x: 37
	startAgain:
		scale: 1
		width: 600
		height: 500
		y: 200
		x: 75

recover = new Layer
	width: Screen.width
	height: 390
	backgroundColor: ""
recover.draggable.enabled = true
recover.draggable.horizontal = false
recover.states.add
	more:
		y: 100
recover.draggable.speedY = 0.65

articleCover.onMove ->
	deg = Utils.modulate(articleCover.screenFrame.y, [660, 100], [0, 180], true)
	articleCoverReal.rotationX = deg
	articleCoverReal.originY = 0
	articleCoverReal.y = 700
	
	articleCoverReal2.rotationX = deg
	articleCoverReal2.originY = 0
	articleCoverReal2.y = 700
	
	articleCoverReal.x = articleCover.x
	articleCoverReal2.x = articleCover.x
	cover.x = articleCover.x

articleCoverReal.on "change:rotationX", ->
	if this.rotationX >= 91
		articleCoverReal.opacity = 0
	else
		articleCoverReal.opacity = 1

articleCoverReal2.on "change:rotationX", ->
	if this.rotationX >= 91
		articleCoverReal2.opacity = 1
	else
		articleCoverReal2.opacity = 0
	
	if this.rotationX >= 179
		articleCoverReal.states.switch('full')
		articleCoverReal2.states.switch('full')
		cover.states.switch('full')
		Utils.delay 0.26, ->
			scroll.visible = true
			scroll.opacity = 1
			scroll.bringToFront()
			cover.opacity = 0
			articleCoverReal2.opacity = 0
			recover.bringToFront()


articleCover.onDragEnd ->
	if this.y < 350
		articleCover.states.switch("up")
		articleCoverReal.states.switch("up")
		articleCoverReal2.states.switch("up")
		cover.states.switch("up")
	else 
		articleCover.states.switch("default")
		articleCoverReal.states.switch("default")
		articleCoverReal2.states.switch("default")
		cover.states.switch("default")

scroll.onMove ->
	scrolling1.y = -scroll.scrollY
	scrolling2.y = -scroll.scrollY - 700

recover.onDragStart ->
	invisibleTop.bringToFront()
	invisibleTop.opacity = 1
	invisibleBottom.bringToFront()
	invisibleBottom.opacity = 1
	recover.bringToFront()
	scroll.opacity = 0
	invisibleTop.states.switch("moving")
	greenTop.states.switch("moving")
	greenTop.bringToFront()
	invisibleBottom.states.switch("moving")

dragDeg = 0
recover.onDrag ->
	dragDeg = Utils.modulate(recover.y, [0, 650], [0, -180], true)
	invisibleTop.rotationX = dragDeg
	
invisibleTop.on "change:rotationX", ->
	greenTop.rotationX = dragDeg
	if invisibleTop.rotationX <= -86.5
		greenTop.opacity = 1
		invisibleTop.opacity = 0
	else 
		greenTop.opacity = 0
		invisibleTop.opacity = 1

recover.onDragEnd ->
	this.states.switch("default")
	if dragDeg <= -85
		invisibleTop.states.switch("down")
		greenTop.states.switch("down")
		greenTop.bringToFront()
		scroll.visible = false
		scroll.sendToBack()
		Utils.delay 0.26, ->
			invisibleTop.states.switchInstant("default")
			invisibleTop.sendToBack()
			invisibleBottom.states.switchInstant("default")
			invisibleBottom.sendToBack()
			invisibleTop.opacity = 0
			invisibleBottom.opacity = 0
			greenTop.states.switchInstant("down")
			greenTop.states.switch("startAgain")
			Utils.delay 0.26, ->
				greenTop.states.switchInstant("default")
				articleCover.states.switchInstant("default")
				articleCoverReal.states.switchInstant("default")
				articleCoverReal2.states.switchInstant("default")
				cover.states.switchInstant("default")
				invisibleTop.states.switchInstant("default")
				invisibleBottom.states.switchInstant("default")
				scroll.scrollY = 0
				scrolling1.y = 0
				scrolling2.y = -700
	else 
		invisibleTop.states.switch("default1")
		invisibleBottom.states.switch("default1")
		Utils.delay 0.26, ->
			invisibleTop.states.switchInstant("default")
			invisibleBottom.states.switchInstant("default")
			scroll.opacity = 1
			scroll.bringToFront()
			recover.bringToFront()

