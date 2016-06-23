# Import file "16_lock"
sketch = Framer.Importer.load("imported/16_lock@1x")

# Change the names for better editing
all = sketch.all
bg = sketch.bg
secondPage = sketch.secondPage
slideShine = sketch.slideShine
topHandle = sketch.topHandle
bottomHandle = sketch.bottomHandle
statusBar = sketch.statusBar
circles = sketch.circles

# Set initial opacity for first load fade in
bg.opacity = 0
topHandle.opacity = 0
bottomHandle.opacity = 0
statusBar.opacity = 0
all.opacity = 0
circles.opacity = 0

# setting y variables for handle bars to use later
toriginY = topHandle.y
boriginY = bottomHandle.y

# First load fade in
bg.animate {properties: (opacity: 1, scale: 1.08), time: 0.3, delay: 0.2}
topHandle.animate {properties: (opacity: 1), time: 0.3, delay: 0.2}
bottomHandle.animate {properties: (opacity: 1), time: 0.3, delay: 0.2}
statusBar.animate {properties: (opacity: 1), time: 0.3, delay: 0.2}
all.animate {properties: (opacity: 1), time: 0.3, delay: 0.2}

# Add states to modulated elements with swipe
bg.states.add
	blur: 
		blur: 55
		scale: 1
	original:
		blur: 0
		opacity: 1
		scale: 1.08
bg.states.animationOptions = time: 0.3

topHandle.states.add
	hide: 
		y: 0 - 50
	original:
		y: toriginY
		opacity: 1
topHandle.states.animationOptions = time: 0.3

bottomHandle.states.add
	hide: 
		y: Screen.height + 30
	original:
		y: boriginY
		opacity: 1
bottomHandle.states.animationOptions = time: 0.3

# Add the blur mask for num pad
blurredBg = new Layer
	image: bg.image
	x: -88
	y: -196
	width: Screen.width
	height: Screen.height
	superLayer: secondPage
	opacity: 0
	blur: 10
	style:
		"-webkit-mask": "url(images/circlesCut.png)"
blurredBg.states.add
	show:
		opacity: 1
blurredBg.states.animationOptions = time: 0.3

circles.bringToFront()

# Animate the glow on the slide copy
slideShine.states.add 
	move: {x: 640}
slideShine.states.animationOptions = curve: "linear", time: 1.8
Utils.interval 2.6, ->
	slideShine.states.switch("move")
	slideShine.onAnimationEnd ->
		if slideShine.states.current == "move"
			slideShine.states.switchInstant("default")

# Enable drag and modulate the swipe into corresponding values
all.draggable.enabled = true
all.draggable.vertical = false

all.onMove -> 
	dist = Utils.modulate(Math.abs(all.x), [700, 40], [33, -10], true)
	bottomHandle.y = Screen.height - dist
	topHandle.y = -14 + dist
	
	blurAmt = Utils.modulate(Math.abs(all.x), [700, 40], [0, 55], true)
	bg.blur = blurAmt
	
	scaleAmt = Utils.modulate(Math.abs(all.x), [700, 40], [1.08, 1], true) 
	bg.scale = scaleAmt
	
	opAmt = Utils.modulate(Math.abs(all.x), [700, 40], [-1, 1], true)
	blurredBg.opacity = opAmt

# Add ending states to tie up loose ends
all.onDragEnd ->
	if all.x <= -450
		all.animate
			properties: 
				x: -700
			curve: "spring(200, 30, 0)"
		topHandle.states.switch("original")
		bottomHandle.states.switch("original")
		bg.states.switch("original")
		blurredBg.states.switch("default")
	else
		all.animate
			properties: 
				x: 60
			curve: "spring(200, 30, 0)"
		topHandle.states.switch("hide")
		bottomHandle.states.switch("hide")
		bg.states.switch("blur")
		blurredBg.states.switch("show")
