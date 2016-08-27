# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


# Basic Setup
# Globals
Framer.Defaults.Animation = time: 0.3
totalNumImages = 90

allImages = []
randomImages = []
group = []

for i in [1..totalNumImages]
	photo =  "images/dummy-images/d#{i}.jpg"
	allImages.push photo

randomizePhoto = (array) ->
	for i in [array.length-1..0]
		j = Math.floor(Math.random() * (i + 1))
		temp = array[i]
		array[i] = array[j]
		array[j] = temp
	return array
randomImages = randomizePhoto(allImages)

bg = new BackgroundLayer backgroundColor: "#fff"

display4 = new Layer
	width: Screen.width, height: Screen.height * 4
	backgroundColor: "#fff", midY: Screen.height/2
display3 = new Layer
	width: Screen.width, height: Screen.height * 1.72
	backgroundColor: "#fff", midY: Screen.height/2
display2 = new Layer
	width: Screen.width, height: Screen.height * 1.72
	backgroundColor: "#fff", midY: Screen.height/2
display1 = new Layer
	size: Screen, backgroundColor: "#fff"




# Utility Functions
createThumbnails = (displayW, factor, margin, d) ->
# 	for layer in group
# 		layer.destroy()
# 	group = []
	for i in [0..Math.floor(totalNumImages/factor)-1]
		for j in [0..factor - 1]
			thumbnail = new Layer
				name: "thumb:#{i},#{j},#{factor}"
				size: (displayW-margin)/factor
				x: j * (displayW + margin/(factor-1))/factor
				y: i * displayW/factor
				backgroundColor: Color.random()
				parent: d
# 			group.push thumbnail
	for layer, t in d.subLayers
		layer.image = randomImages[t]

# Photo Specific Layers
display1.show = true
display2.show = false
display2.scale = 1/1.72
display2.opacity = 0
display3.show = false
display3.scale = 1/1.5
display3.opacity = 0
display4.show = false
display4.scale = 1/2
display4.opacity = 0

createThumbnails(Screen.width, 7, 0, display1)
createThumbnails(Screen.width, 4, 15, display2)
createThumbnails(Screen.width, 3, 20, display3)
createThumbnails(Screen.width, 2, 20, display4)

for layer, t in display4.subLayers
	layer.width = Screen.width
	layer.height = 450
	layer.y = t * (450 + 20)
	layer.x = 0


# Control Layer
viewControls = new Layer
	size: Screen, backgroundColor: ""

# viewControls.onClick ->
# 	print Math.abs(@screenFrame.x) % ((Screen.width-15)/4 + 15)
	
viewControls.pinchable.enabled = true

# Interaction
viewControls.onPinchStart ->
# 	display2.midY = Screen.height / 2
	if display1.show is true 
		display1.originX = @originX
		display1.originY = @originY
		display2.originY = @originY
		
	if display2.show is true
		display2.originX = @originX
		display2.originY = @originY

viewControls.onPinch ->
	@rotation = 0 
	
	if display1.show is true 
		display1.scale = @scale
		display1.opacity = Utils.modulate(@scale, [1, 1.7], [1, 0.3], true)
		display2.opacity = Utils.modulate(@scale, [1, 1.7], [0.5, 1], true)
		display2.scale = Utils.modulate(@scale, [1, 1.7], [1/1.72, 1], true)
		
		if @scale < 1 
			@scale = display1.scale = 1
			@x = 0
			@y = 0
			
		if display1.scale > 1.72
			@pinchable.enabled = false
			
	if display2.show is true 
		display2.scale = @scale
		display2.opacity = Utils.modulate(@scale, [1, 1.5], [1, 0.2], true)
		display3.scale = Utils.modulate(@scale, [1, 1.5], [1/1.5, 1], true)
		display3.opacity = Utils.modulate(@scale, [1, 1.5], [0.5, 1], true)
		
		if @scale < 0.98
			display1.opacity = Utils.modulate(@scale, [0.98, 0.6], [1, 0], true)
			display1.scale = Utils.modulate(@scale, [0.98, 0.6], [1.72, 1], true)
			display1.opacity = Utils.modulate(@scale, [0.98, 0.6], [0, 0.8], true)
		if @scale > 1.5
			@pinchable.enabled = false
	
	if display3.show is true 
		display3.scale = @scale
		display3.opacity = Utils.modulate(@scale, [1, 2], [1, 0.3], true)
		display4.scale = Utils.modulate(@scale, [1, 2], [1/2, 1], true)
		display4.opacity = Utils.modulate(@scale, [1, 2], [0.6, 1], true)
		
		if @scale < 0.98
			display3.opacity = Utils.modulate(@scale, [0.98, 0.6], [1, 0], true)
			display2.scale = Utils.modulate(@scale, [0.98, 0.6], [1.5, 1], true)
			display2.opacity = Utils.modulate(@scale, [0.98, 0.6], [0, 0.8], true)
		if @scale > 2
			@pinchable.enabled = false
			
	if display4.show is true 
		display4.scale = @scale
		
		if @scale < 0.98
			display4.opacity = Utils.modulate(@scale, [0.98, 0.6], [1, 0], true)
			display3.scale = Utils.modulate(@scale, [0.98, 0.6], [2, 1], true)
			display3.opacity = Utils.modulate(@scale, [0.98, 0.6], [0, 0.8], true)
		if @scale > 1
			@scale = display4.scale = 1
			@x = 0
			@y = 0

# Pinch End States Housekeeping
viewControls.onPinchEnd ->
	@pinchable.enabled = true
	viewControls.scale = 1
	# 1
	if display1.show is true 
		if display1.scale > 1.7
			display1.animate 
				properties: scale: 1.72, opacity: 0
			display2.animate properties: opacity: 1
			display1.onAnimationEnd ->
				display1.show = false
				display2.show = true
		else 
			display1.animate 
				properties: scale: 1, opacity: 1
	
	if display2.show is true 
		if display2.scale < 0.99
			display1.animate 
				properties: scale: 1, opacity: 1
			display1.onAnimationEnd ->
				display1.show = true
				display2.show = false
		else if display2.scale > 1.49
				display2.animate properties: opacity: 0
				display3.animate properties: opacity: 1, scale: 1
				display3.onAnimationEnd ->
					display3.show = true
					display2.show = false
		else 
			display2.animate 
				properties: scale: 1, opacity: 1
	
	if display3.show is true 
		if display3.scale < 0.99
			display2.animate 
				properties: scale: 1, opacity: 1
			display2.onAnimationEnd ->
				display2.show = true
				display3.show = false
		else if display3.scale > 2
				display3.animate properties: opacity: 0
				display4.animate properties: opacity: 1, scale: 1
				display4.onAnimationEnd ->
					display4.show = true
					display3.show = false
		else 
			display3.animate 
				properties: scale: 1, opacity: 1
	
	if display4.show is true 
		if display4.scale < 0.99
			display4.animate 
				properties: scale: 0.5, opacity: 0
			display3.animate properties: opacity: 1, scale: 1
			display4.onAnimationEnd ->
				display4.show = false
				display3.show = true
		else 
			display4.animate 
				properties: scale: 1, opacity: 1
