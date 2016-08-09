#Project Info
Framer.Info =
	title: "Extension: Wine Shope Cart"
	author: "Tony Jing (Original: Anadea Inc)"
	twitter: "TonyJing"
	description: "An another approach for the UX of Anadea Inc's app. Visual and UI design are from Anadea Inc."

#Variables
bgColor = "#FBF2E7"
purple = "#800363"

addedCount = 1
numBottles = 5
allBottles = []
firstClick = true


#Layers

iphoneBase = new Layer
	width: Screen.width, height: Screen.height
	image: "images/iPhone 6 Copy 15@2x.png"

bottle = new Layer
	width: 74, height: 220, x: 64, y: 716
	image: "images/bottle.png"

for i in [1 .. numBottles]
	Framer["bottleCopy#{i}"] = bottle.copy()
	Framer["bottleCopy#{i}"].props = name: "bottleCopy#{i}", opacity: 0
	allBottles.push(Framer["bottleCopy#{i}"])
	
text = new Layer
	width: 196, y: 733, x: 198
	image: "images/bottle_description.png"

count = new Layer
	size: 60, x: 100, y: 738, borderRadius: "50%"
	backgroundColor: "#000", opacity: 0, html: addedCount
	style: textAlign: "center", fontSize: "1.6rem", lineHeight: "3.6rem"

# bg = new Layer
# 	width: 250, height: 1200, maxX: Screen.width, maxY: Screen.height
# 	backgroundColor: "", style: background: "linear-gradient(to right, rgba(251, 242, 231, 0) 0%, rgba(251, 242, 231, 1) 60%)"
# 	

for i in [0...5]
	Framer["add#{i}"] = new Layer
		name: "add#{i}", width: 140, height: 60
		maxX: Screen.width - 20, y: 200 + i * 272
		backgroundColor: "", html: "+ ADD", color: purple
		borderColor: "", borderWidth: 2, borderRadius: 7
		style: 
			fontFamily: "Helvetica Neue", fontSize: "1.5rem"
			textAlign: "center", lineHeight: "3.5rem"

remove = new Layer
	width: 140, height: 60, opacity: 0
	maxX: Screen.width - 20, y: 829, backgroundColor: ""
	html: "REMOVE", color: purple
	borderColor: "", borderWidth: 2, borderRadius: 7
	style: 
		fontFamily: "Helvetica Neue", fontSize: "1.5rem"
		textAlign: "center", lineHeight: "3.5rem"

smoke = new Layer
	size: 400, borderRadius: "50%", scale: 0, backgroundColor: ""
	midX: bottle.midX, midY: bottle.midY + 20
	style: background: """radial-gradient(ellipse at center, 
								rgba(225, 205, 205, 1) 30%,
								rgba(255, 255, 255, 0) 100%)"""
smoke.placeBehind(bottle)


# States & Animations
text.draggable = true
text.draggable.vertical = false
text.draggable.overdrag = false
text.draggable.speedX = 1.5
text.draggable.constraints =
	x: text.x, width: Screen.width - text.x

text.states.add
text.states.animationOptions = curve: "spring(150, 18, 0)"

count.states.add show: opacity: 1
count.states.animationOptions = time: 0.5

Framer["add2"].states.add selected: 
	borderColor: purple
Framer["add2"].states.animationOptions = time: 0.2

remove.states.add selected: opacity: 1
remove.states.animationOptions = time: 0.2

bottleAddPop = new Animation
	layer: Framer["bottleCopy1"]
	properties: x: bottle.x + 75, opacity: 1
	time: 0.3

bottleAddPop.onAnimationEnd ->
	Framer["bottleCopy1"].animate
		properties: x: bottle.x, opacity: 0
		time: 0.2

textPop = new Animation
	layer: text
	properties: x: text.x + 90
	time: 0.3

textPop.onAnimationEnd ->
	text.animate
		properties: x: text.x - 90
		curve: "spring(130, 12, 0)"

puff = new Animation 
	layer: smoke
	properties: scale: 1, opacity: 0
	time: 0.1

countFadeout = new Animation
	layer: count
	properties: opacity: 0
	time: 0.3

countFadeout.onAnimationEnd ->
	count.states.switchInstant("default")

# Events
text.onDragStart ->
	count.states.switch("show")
	Framer["add2"].states.switch("selected")
	Framer["add2"].animate {properties: (opacity: 0), time: 0.5}
	remove.animate {properties: (opacity: 0), time: 0.5}
	
text.on Events.Drag, (e) ->
	if parseInt(count.html, 10) == 0
		Framer["add2"].states.switch("default")
		remove.states.switch("default")
		
	dragDist = this.x
	for i in [1..numBottles]
		if e.velocity.x > 0 and dragDist >= (i * 65 + 225)
			count.html = addedCount + 1
			for b in allBottles
				b.animate
					properties: x: bottle.x + i * 60, opacity: 1
					time: 0.1
			for n in [1..numBottles]
				if i > n
					count.html = addedCount + n + 1
					Framer["bottleCopy#{n}"].animate
						properties: x: bottle.x + n * 60, opacity: 1
						time: 0.1
		if e.velocity.x < 0
			levels = Math.floor(Utils.modulate(dragDist, [554, 198], [6, 0]))
			count.html = addedCount + levels - 1
			if i > 1 
				if Framer["bottleCopy#{i}"].x > (dragDist - 180)
					Framer["bottleCopy#{i}"].animate
						properties: 
							x: Framer["bottleCopy#{i-1}"].x
							opacity: 0
						time: 0.1
			if Framer["bottleCopy1"].x > (dragDist - 180)
				Framer["bottleCopy1"].animate 
					properties:
						x: bottle.x
						opacity: 0
					time: 0.1

text.onDragEnd ->
	Framer["add2"].animate {properties: (opacity: 1), time: 0.5}
	remove.animate {properties: (opacity: 1), time: 0.5}
	this.states.switch("default")
	for b in allBottles
		b.animate
			properties: x: bottle.x
			time: 0.1
	if parseInt(count.html, 10) == 0
		Utils.delay 0.3, ->
			countFadeout.start()
	if parseInt(count.html, 10) > 0
		addedCount = parseInt(count.html, 10) 
	else 
		addedCount = 1
	
Framer["add2"].onClick ->
	this.states.switch("selected")
	remove.states.switch("selected")
	count.states.switch("show")
	bottleAddPop.start()
	textPop.start()
	if parseInt(count.html, 10) != 1
		count.html = parseInt(count.html, 10) + 1
		addedCount = parseInt(count.html, 10)
	
	if parseInt(count.html, 10) == 1 and firstClick == false
		count.html = parseInt(count.html, 10) + 1

	if parseInt(count.html, 10) == 1 and firstClick == true
		count.html = 1
		firstClick = false 
	
remove.onClick ->
	if parseInt(count.html, 10) == 1
		count.html = 0
		Utils.delay 0.5, ->
			countFadeout.start()
		Framer["add2"].states.switch("default")
		remove.states.switch("default")
