# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Vars
numTasks = 12
taskH = 155

red = "#FF2230"
green = "#22FF30"
greenBg = "#22bf35"

helperText1 = "Pull for new task."
helperText2 = "Release to create it."

textStyles = 
	fontSize: "2.8rem",
	lineHeight: "9.5rem",
	paddingLeft: "3rem"
	
Framer.Defaults.Animation =
	curve: "spring(300,20,0)"

# Layers
scroll = new ScrollComponent
	size: Screen
	scrollHorizontal: false

for i in [0..numTasks]
	Framer["task#{i+1}"] = new Layer
		name: "task#{i+1}"
		width: Screen.width
		height: taskH
		parent: scroll.content
		html: "Task #{i + 1}"
		style: 
			textStyles
		y: taskH * i
		backgroundColor: "hsl(#{335 + i * 7}, 50, 50)"

	Framer["done#{i+1}"] = new Layer
		name: "done#{i+1}"
		parent: Framer["task#{i+1}"]
		height: Framer["task#{i+1}"].height
		html: "Done", color: green
		backgroundColor: "", opacity: 0
		style: paddingLeft: "2rem", fontWeight: 300
		z: -1
	
	Framer["del#{i+1}"] = new Layer
		name: "del#{i+1}"
		parent: Framer["task#{i+1}"]
		height: Framer["task#{i+1}"].height
		html: "Delete", color: red
		backgroundColor: "", opacity: 0
		style: paddingLeft: "2rem", fontWeight: 300
		z: -1
	
	Framer["task#{i+1}"].draggable.enabled = true
	Framer["task#{i+1}"].draggable.vertical = false
	
helper = new Layer 
	html: "Pull for new task."
	backgroundColor: "HSL(328, 50, 50)"
	width: Screen.width
	rotationX: 10
	scale: 0.95
	maxY: scroll.screenFrame.y
	height: taskH
	style: 
		textStyles

# Events
scroll.onMove ->
	rotateX = Utils.modulate(scroll.scrollY, [-20, -200], [60, 0], true)
	gapTop = Utils.modulate(scroll.scrollY, [-20, -200], [75, 0], true)
	scaling = Utils.modulate(scroll.scrollY, [-20, -200], [0.96, 1], true)
	op = Utils.modulate(scroll.scrollY, [-20, -200], [0.5, 1], true)
	
	helper.props =
		maxY: scroll.content.screenFrame.y + gapTop
		rotationX: rotateX
		scale: scaling
		opacity: op
	if rotateX <= 0
		helper.html = helperText2
	if rotateX >= 30
		helper.html = helperText1

scroll.onScroll ->
	for layer in scroll.content.subLayers
		layer.draggable.enabled = false

scroll.onScrollEnd ->
	for layer in scroll.content.subLayers
		layer.draggable.enabled = true
	
oldBg = Color.random()
removedLayerY = 0

for layer in scroll.content.subLayers
	layer.onDragStart ->
		oldBg = @backgroundColor
		removedLayerY = @y
		
	layer.onDrag ->
		scroll.scrollVertical = false
		
		op = Utils.modulate(@x, [0, 200], [0, 1], true)
		op1 = Utils.modulate(@x, [0, -200], [0, 1], true)
		@.children[0].opacity = op
		@.children[1].opacity = op1
		
		if @x >= 200 
			@.children[0].x = -200
			@.done = true
			@.animate 
				properties: backgroundColor: greenBg
				time: 0.1, curve: "ease"
		else 
			@.children[0].x = -@.x
			@.done = false
			@.animate 
				properties: backgroundColor: oldBg
				time: 0.1, curve: "ease"
			
		if @x <= -200
			@.children[1].x = Screen.width 
		else
			@.children[1].maxX = Screen.width - @.x
		
	layer.onDragEnd ->
		scroll.scrollVertical = true
		if @x < -200 
			@.animate 
				properties: x: -Screen.width * 1.3
			@.onAnimationEnd ->
				@.destroy()
				animateScrollUp()
		else
			@.animate 
				properties: x: 0
			if @done is true
				animateDoneTask(@)
				
animateScrollUp = ->
	for layer, t in scroll.content.subLayers
		if layer.y > removedLayerY
			layer.animate properties: y: layer.y - taskH

doneCount = 0
animateDoneTask = (layer) ->
	biggestY = 0
	for content in scroll.content.subLayers
		biggestY = content.y
	Utils.delay 0.35, ->
		animateScrollUp()
		layer.bringToFront()
		layer.animate 
			properties: 
				y: biggestY + doneCount * taskH
				backgroundColor: null
				opacity: 0.5
		layer.style.textDecoration = "line-through"
		doneCount += 1
	


	
	