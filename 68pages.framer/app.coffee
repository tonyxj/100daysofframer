# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Vars
numPages = 3
numStyle = 1
oldTitleX = 0

dir = "nil"
small = 0.7
medium = 0.73

Framer.Defaults.Animation =
	curve: "spring(220,20,0)"

# Layers
for i in [numPages..1]
	Framer["page#{i}"] = new Layer
		name: "page#{i}", size: Screen
		backgroundColor: Utils.randomColor().darken(10)
		x: 0, originX: 1, originY: 0.6
		shadowBlur: 30
		html: "#{i}"
		style: 
			fontSize: "15rem", paddingTop: "#{Screen.height/2.1}px"
			fontWeight: 100, textAlign: "center"
			fontFamily: "Helvetica Neue, Sans-serif"
			textShadow: "0 0 5px rgba(0,0,0,0.55)"
			zIndex: 10
			
Framer["page2"].scale = small
Framer["page3"].scale = small

Framer["page1"].draggable.enabled = true
Framer["page1"].draggable.vertical = false
Framer["page1"].draggable.overdrag = false
Framer["page1"].onMove ->
	if this.x < -100
		this.animate properties: x: -Screen.width
	else 
		this.animate properties: x: 0

Framer["page1"].draggable.constraints =
	x: -Screen.width
	width: Screen.width * 2
	
drag2 = new Layer
	size: Screen
	backgroundColor: "blue"
	opacity: 0, x: Screen.width
drag2.draggable.enabled = true
drag2.draggable.vertical = false
drag2.draggable.overdrag = false

drag3 = new Layer
	size: Screen
	backgroundColor: "green"
	opacity: 0, x: Screen.width
drag3.draggable.enabled = true
drag3.draggable.vertical = false
drag3.draggable.overdrag = false

titleBar = new Layer
	width: Screen.width * 2
	height: 110
	backgroundColor: "black"

titleText1 = new Layer
	parent: titleBar, backgroundColor: "", y: 36, opacity: 0.6
	html: "Title Text 1", x: Screen.width / 2 - 72
	style: 
		fontSize: "2.1rem"
		textAlign: "center"
		fontWeight: 300
		fontFamily: "Helvetica Neue, Sans-serif"
titleText2 = titleText1.copy()
titleText2.props =
	html: "Title Text 2", x: Screen.width / 2 + 200, parent: titleBar
titleText3 = titleText2.copy()
titleText3.props =
	html: "Title Text 3", x: Screen.width / 2 + 463, parent: titleBar

titleText1.opacity = 1

Framer["page1"].onDragStart ->
	stopTimer()
	
Framer["page1"].onDrag ->
	drag2.x = this.maxX
	titleBar.x = Framer["page1"].x/3.3
	Framer["page2"].scale = 
		Utils.modulate(this.x, [0, -470], [medium, 1], true)
	
Framer["page1"].onDragEnd ->
	startTimer()
	if this.x < -100
		drag2.animate properties: x: 0
		Framer["page2"].animate properties: scale: 1
		titleBar.animate properties: x: -Screen.width/2.6
		titleText1.animate properties: opacity: 0.6
		titleText2.animate properties: opacity: 1
	else
		drag2.animate properties: x: Screen.width
		titleBar.animate properties: x: 0

drag2.onDragStart ->
	oldTitleX = titleBar.x
	stopTimer()
	
drag2.onDrag ->
	if this.x < 0
		Framer["page3"].scale = 
			Utils.modulate(this.x, [0, -470], [medium, 1], true) 
		Framer["page2"].x = this.x
		drag3.x = this.maxX
		titleBar.x = oldTitleX + this.x / 3.3
	else
		Framer["page1"].maxX = this.x
		Framer["page2"].scale = 
			Utils.modulate(this.x, [0, 270], [1, medium], true) 
		titleBar.x = oldTitleX + this.x / 3.3
		
drag2.onDragEnd ->
	startTimer()
	if drag2.x < -100
		this.animate properties: x: -Screen.width
		Framer["page2"].animate properties: x: -Screen.width
		drag3.animate properties: x: 0
		Framer["page3"].animate properties: scale: 1
		titleBar.animate properties: x:-Screen.width/1.38
		titleText2.animate properties: opacity: 0.6
		titleText3.animate properties: opacity: 1
	else if drag2.x > 100
		this.animate properties: x: Screen.width 
		Framer["page1"].animate properties: x: 0
		Framer["page2"].animate properties: scale: small
		titleBar.animate properties: x: 0
		titleText2.animate properties: opacity: 0.6
		titleText1.animate properties: opacity: 1
	else 
		this.animate properties: x: 0
		Framer["page1"].animate properties: x: -Screen.width
		Framer["page2"].animate properties: x: 0, scale: 1
		drag3.animate properties: x: Screen.width
		titleBar.animate properties: x: -Screen.width/2.6

drag3.onDragStart ->
	oldTitleX = titleBar.x
	stopTimer()
	
drag3.onDrag ->
	if this.x > 0
		titleBar.x = oldTitleX + this.x / 3.3
		drag2.maxX = this.x
		Framer["page2"].maxX = this.x
		Framer["page3"].scale = 
			Utils.modulate(this.x, [0, 270], [1, medium], true) 

drag3.onDragEnd ->
	startTimer()
	if this.x < 0
		drag3.x = 0
	else if this.x > 100
		this.animate properties: x: Screen.width, scale: small
		drag2.animate properties: x: 0
		Framer["page2"].animate properties: x: 0
		Framer["page3"].animate properties: scale: small
		titleBar.animate properties: x:-Screen.width/2.6
		titleText3.animate properties: opacity: 0.6
		titleText2.animate properties: opacity: 1
	else 
		this.animate properties: x: 0
		drag2.animate properties: x: -Screen.width
		Framer["page3"].animate properties: scale: 1
		Framer["page2"].animate properties: x: -Screen.width
		titleBar.animate properties: x:-Screen.width/1.38

# Utility Functions
fadeOut = ->
	titleBar.animate 
		properties: opacity: 0
		time: 0.5

fadeIn = ->
	titleBar.animate
		properties: opacity: 1
		time: 0.5

dummy = new Layer
	y: 0, backgroundColor: null

dummyTimer = new Animation
	layer: dummy
	properties: 
		maxY: Screen.height
	curve: "linear"
	time: 1.25

stopTimer = ->
	dummyTimer.stop()
	dummy.y = 0
	fadeIn()
	
startTimer = ->
	dummy.y = 0
	dummyTimer.start()

dummyTimer.start()
dummyTimer.onAnimationEnd ->
	fadeOut()
 



