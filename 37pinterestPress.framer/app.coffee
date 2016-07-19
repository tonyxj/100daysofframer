# SETUP
# Import file "pinterest-pressHold"
sketch = Framer.Importer.load("imported/pinterest-pressHold@1x")
Screen.backgroundColor = "#fff"

Utils.globalLayers(sketch)
pressTime = 0.3

overlay.style =
	mixBlendMode: "darken"

bg.states.add up: y: -30
bg.states.animationOptions = curve: "spring(100, 16, 0)"

picker.states.add up: y: 0
picker.states.animationOptions = curve: "spring(100, 16, 0)"
picker.draggable.enabled = true
picker.draggable.horizontal = false
picker.onDragEnd ->
	if picker.y <= 400
		picker.states.switch("up")
	else
		picker.states.switch("default")
		bg.states.switch("default")
		card.states.switch("default")
	
pickerClose = new Layer
	parent: picker
	width: 100
	height: 100
	x: 5
	y: 10
	backgroundColor: null
pickerClose.onClick ->
	picker.states.switch("default")
	bg.states.switch("default")
	card.states.switch("default")
	
cover.opacity = 0
cover.states.add 
	on: opacity: 1
cover.states.animationOptions = time: pressTime/2

buttons.opacity = 0
buttons.states.add 
	on: opacity: 1
buttons.states.animationOptions = time: pressTime/3

card.opacity = 0
card.states.add 
	on: opacity: 1
	off: opacity: 0
	up: y: -30
card.states.animationOptions = time: pressTime/3

labels.opacity = 0
for layer in labels.subLayers
	layer.opacity = 0

		


# BUTTONS STATES
save.states.add right: x: -60, y: -150, scale: 1
save.states.add left: x: 150, y: 0, scale: 1
save.states.add topLeft: x: -160, y: 0, scale: 1
save.states.add topRight: x: -180, y: -30, scale: 1
save.states.add rightSelect: x: -80, y: -180, scale: 1.3
save.states.add leftSelect: x: 180, y: 0, scale: 1.3
save.states.add topLeftSelect: x: -190, y: 0, scale: 1.3
save.states.add topRightSelect: x: -210, y: -50, scale: 1.3
save.states.animationOptions = curve: "spring(200, 19, 0)"

like.states.add right: x: -160, y: -40, scale: 1
like.states.add left: x: 70, y: -130, scale: 1
like.states.add topLeft: x: -100, y: 140, scale: 1
like.states.add topRight: x: -180, y: 90, scale: 1
like.states.add rightSelect: x: -190, y: -60, scale: 1.3
like.states.add leftSelect: x: 100, y: -150, scale: 1.3
like.states.add topLeftSelect: x: -130, y: 160, scale: 1.3
like.states.add topRightSelect: x: -210, y: 110, scale: 1.3
like.states.animationOptions = curve: "spring(200, 19, 0)"

send.states.add right: x: -160, y: 90, scale: 1
send.states.add left: x: -70, y: -130, scale: 1
send.states.add topLeft: x: 40, y: 150, scale: 1
send.states.add topRight: x: -90, y: 160, scale: 1
send.states.add rightSelect: x: -190, y: 110, scale: 1.3
send.states.add leftSelect: x: -100, y: -150, scale: 1.3
send.states.add topLeftSelect: x: 60, y: 170, scale: 1.3
send.states.add topRightSelect: x: -100, y: 200, scale: 1.3
send.states.animationOptions = curve: "spring(200, 19, 0)"

more.states.add right: x: -20, y: 160, scale: 1
more.states.add left: x: -140, y: 0, scale: 1
more.states.add topLeft: x: 150, y: 30, scale: 1
more.states.add topRight: x: 35, y: 160, scale: 1
more.states.add rightSelect: x: -40, y: 190, scale: 1.3
more.states.add leftSelect: x: -170, y: -10, scale: 1.3
more.states.add topLeftSelect: x: 180, y: 50, scale: 1.3
more.states.add topRightSelect: x: 45, y: 190, scale: 1.3
more.states.animationOptions = curve: "spring(200, 19, 0)"

for layer in buttons.subLayers
	layer.subLayers[0].states.add off: opacity: 0
	layer.subLayers[0].states.animationOptions = time: pressTime/10
	layer.subLayers[0].states.switchInstant("off")

# CARD TAP END
# card.onTapStart ->

card.onTapEnd ->
	for layer in buttons.subLayers
		layer.states.switch("default")
	cover.states.switch("default")
	for l in labels.subLayers
		l.opacity = 0
	
	if save_red.states.current == "default"
		picker.states.switch("up")
		picker.bringToFront()
		bg.states.switch("up")
		card.animate properties: {scale: 1, y: 20}, curve: "spring(100, 16, 0)"
	else
		card.animate properties: {scale: 1}, time: pressTime/5, curve: "ease"
		
	Utils.delay pressTime/1.5, ->
		for layer in buttons.subLayers
			layer.animate {properties: (opacity: 0), time: pressTime/4}
	Utils.delay pressTime, ->
		cover.states.switch("default")
		card.states.switch("off")



# BUTTONS INTERACTIONS
card.on Events.TouchStart, (e, layer) ->
	for layer in buttons.subLayers
		layer.states.switchInstant("default")
	card.scale = 1
	card.states.switch("on")
	card.animate properties: {scale: 0.98}, time: pressTime-0.1, curve: "ease"
	buttons.opacity = 0
	
	for layer in buttons.subLayers
		layer.subLayers[0].states.switchInstant("off")
		
	touchEvent = Events.touchEvent(e)
	if Utils.isPhone() || Utils.isTablet()
		tX = touchEvent.clientX - layer.x
		tY = touchEvent.clientY - layer.y
	else 
		tX = touchEvent.offsetX 
		tY = touchEvent.offsetY
	buttons.midX = tX
	buttons.midY = tY
# 	print "tX: " + tX, "tY: " + tY
	Utils.delay pressTime, ->
		buttons.states.switch("on")
		cover.states.switch("on")
		if tX <= 165 && tY <= 245
			for layer in buttons.subLayers
				layer.states.switch("topLeft")
		else if tX <= 165 && tY > 245
			for layer in buttons.subLayers
				layer.states.switch("left")
		else if tX > 165 && tY <= 245
			for layer in buttons.subLayers
				layer.states.switch("topRight")
		else
			for layer in buttons.subLayers
				layer.states.switch("right")

# SELECTION
card.on Events.TouchMove, (e, layer) ->
	touchEvent = Events.touchEvent(e)
	if Utils.isPhone() || Utils.isTablet()
		tX = touchEvent.clientX - layer.x
		tY = touchEvent.clientY - layer.y
	else 
		tX = touchEvent.offsetX 
		tY = touchEvent.offsetY
	touchX = card.x + tX
	touchY = card.y + tY
	
# 	print "X: " + touchX, "Y: " + touchY
	for layer in buttons.subLayers
		layerX = layer.screenFrame.x + 50
		layerY = layer.screenFrame.y + 50
		if layer.states.current != "default"
			currentLayer = layer.states.current
			
			if Math.abs(layerX - touchX) <= 55 && Math.abs(layerY - touchY) <= 55
				layer.subLayers[0].states.switch("default")
				
				for l in labels.subLayers
						l.opacity = 0
				if layer.name == "more"
					moreLabel.opacity = 1
				if layer.name == "send"
					sendLabel.opacity = 1
				if layer.name == "like"
					likeLabel.opacity = 1
				if layer.name == "save"
					saveLabel.opacity = 1
					
				labels.animate {properties: (opacity: 1), time: pressTime/3}
				if currentLayer == "right"
					layer.states.switch("rightSelect")
					labels.y = 300
				if currentLayer == "left"
					layer.states.switch("leftSelect")
					labels.y = 160
				if currentLayer == "topLeft"
					layer.states.switch("topLeftSelect")
					labels.y = 500
				if currentLayer == "topRight"
					layer.states.switch("topRightSelect")
					labels.y = 500
			else
				layer.subLayers[0].states.switch("off")
				if currentLayer == "rightSelect"
					layer.states.switch("right")
					labels.states.switch("default")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "leftSelect"
					layer.states.switch("left")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "topLeftSelect"
					layer.states.switch("topLeft")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "topRightSelect"
					layer.states.switch("topRight")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
			

bg.on Events.TouchMove, (e, layer) ->
	touchEvent = Events.touchEvent(e)
	if Utils.isPhone() || Utils.isTablet()
		tX = touchEvent.clientX - layer.x
		tY = touchEvent.clientY - layer.y
	else 
		tX = touchEvent.offsetX 
		tY = touchEvent.offsetY

# 	print "X: " + tX, "Y: " + tY
	for layer in buttons.subLayers
		layerX = layer.screenFrame.x + 50
		layerY = layer.screenFrame.y + 50
		if layer.states.current != "default"
			currentLayer = layer.states.current
			
			if Math.abs(layerX - tX) <= 55 && Math.abs(layerY - tY) <= 55
				layer.subLayers[0].states.switch("default")
				
				for l in labels.subLayers
						l.opacity = 0
				if layer.name == "more"
					moreLabel.opacity = 1
				if layer.name == "send"
					sendLabel.opacity = 1
				if layer.name == "like"
					likeLabel.opacity = 1
				if layer.name == "save"
					saveLabel.opacity = 1
					
				labels.animate {properties: (opacity: 1), time: pressTime/3}
				if currentLayer == "right"
					layer.states.switch("rightSelect")
					labels.y = 300
				if currentLayer == "left"
					layer.states.switch("leftSelect")
					labels.y = 160
				if currentLayer == "topLeft"
					layer.states.switch("topLeftSelect")
					labels.y = 500
				if currentLayer == "topRight"
					layer.states.switch("topRightSelect")
					labels.y = 500
			else
				layer.subLayers[0].states.switch("off")
				if currentLayer == "rightSelect"
					layer.states.switch("right")
					labels.states.switch("default")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "leftSelect"
					layer.states.switch("left")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "topLeftSelect"
					layer.states.switch("topLeft")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
				if currentLayer == "topRightSelect"
					layer.states.switch("topRight")
					for l in labels.subLayers
						l.opacity = 0
					labels.animate {properties: (opacity: 0), time: pressTime/3}
			

