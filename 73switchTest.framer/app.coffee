# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""

Screen.backgroundColor = "#ececec"

switchSize = 220
switchRadius = switchSize/2
switchHandleInset = .95
gray = "rgba(100, 100, 100, .8)"
green = new Color r: 0, g: 255, b: 175
blue = green.darken(5)
black = new Color r: 0, g: 0, b: 0

switchBg = new Layer 
	backgroundColor: gray
	width: switchSize
	height: switchSize /2
	borderRadius: switchRadius
switchBg.center()

handBg = new Layer
	parent: switchBg
	width: switchSize
	height: switchSize /2
	scale: 0.97
	borderRadius: switchRadius
	backgroundColor: "rgba(220,220,220,0.7)"

switchHandle = new Layer
	midY: switchBg.height/2
	parent: switchBg
	size: switchSize / 2
	backgroundColor: "#fff"
	borderRadius: "50%"
	scale: switchHandleInset
	shadowY: 2
	shadowSpread: 3
	shadowColor: "rgba(0,0,0,0.1)"

onLabel = new Layer
	html: "ON"
	backgroundColor: ""
	color: gray
	opacity: 0.5
	style: 
		fontWeight: 700
		fontFamily: "Helvetica Neue, sans-serif"
		fontSize: "2.9rem"
		textShadow: "0 0 10px white"
onLabel.centerX(switchSize + 25)
onLabel.centerY(switchSize/2 - 25)

offLabel = new Layer
	html: "OFF"
	width: 40
	backgroundColor: ""
	color: "black"
	opacity: 1
	style: 
		fontWeight: 700
		fontFamily: "Helvetica Neue, sans-serif"
		fontSize: "2.9rem"
		textShadow: "0 0 10px white"
offLabel.centerX(-switchSize)
offLabel.centerY(switchSize/2 - 25)

copy = new Layer
	html: "Show my feed to this contact"
	width: Screen.width
	backgroundColor: ""
	color: black
	style: 
		fontSize: "2.9rem"
		fontWeight: 400
		textAlign: "center"
copy.center()
copy.centerY(-50)
	

switchHandle.draggable.enabled = true
switchHandle.draggable.vertical = false
switchHandle.draggable.constraints = switchBg.size
switchHandle.draggable.overdrag = false
switchHandle.draggable.momentum = false
switchHandle.draggable.bounce = false

switchBg.states.add on: backgroundColor: green
switchHandle.states.add on: maxX: switchBg.width
handBg.states.add on: scale: 0
offLabel.states.add on: opacity: 0.5, color: gray
onLabel.states.add on: opacity: 1, color: blue

switchHandle.states.animationOptions =
	 time: 0.25

switchBg.states.animationOptions = 		switchHandle.states.animationOptions
offLabel.states.animationOptions = 		switchHandle.states.animationOptions
onLabel.states.animationOptions = 			switchHandle.states.animationOptions
handBg.states.animationOptions = 
	time: 0.3
	
switchHandle.onDragMove ->
	fraction = Utils.modulate(@x, [0, switchBg.width - @width], [0, 1], true)
	scaleFactor = Utils.modulate(@x, [0, switchBg.width - @width], [0.97, 0], true)
	op = Utils.modulate(@x, [0, switchBg.width - @width], [0.5, 1], true)
	reverseOp = Utils.modulate(@x, [0, switchBg.width - @width], [1, 0.5], true)

	handBg.scale = scaleFactor
	switchBg.backgroundColor = Color.mix(gray, green, fraction, true)
	onLabel.opacity = op
	onLabel.color = Color.mix(gray, blue, fraction, true)
	offLabel.opacity = reverseOp
	offLabel.color = Color.mix(black, gray, fraction, true)
	
switchHandle.onDragEnd ->
	state = if @midX < switchBg.width/2 then "default" else "on"
	for layer in [switchBg, switchHandle, handBg, onLabel, offLabel]
		layer.states.switch state
	
switchBg.onClick ->
	return if switchHandle.draggable.isMoving
	state = if @states.current is "default" then "on" else "default"
	
	for layer in [switchBg, switchHandle, handBg, onLabel, offLabel]
		layer.states.switch state
	
	



