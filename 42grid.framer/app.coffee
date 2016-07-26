{Pointer} = require "Pointer"

margin = 0
lineWidth = 4
gridSize = 70
gridExpandSize = 60

GridsH = []
GridsV = []
animateTime = 0.25

bg = new Layer
	x: margin
	y: margin
	width: Screen.width - margin * 2
	height: Screen.height - margin * 2
	backgroundColor: "lightgreen"
	borderRadius: lineWidth*2
	borderWidth: lineWidth
	borderColor: "white"
	clip: true

gridFactorVer = (Screen.width-margin * 2)/(lineWidth+gridSize)
gridFactorHor = (Screen.height-margin * 2)/(lineWidth+gridSize)

gridGap = bg.width / gridFactorVer
gridColor = new Color("white")

for gridIndex in [0...gridFactorHor - 1]
	gridHor = new Layer
		name: "gridHor"
		width: bg.width-lineWidth*2
		height: lineWidth
		x: 0
		y: gridGap * gridIndex + gridGap - 5
		backgroundColor: gridColor
		parent: bg
	GridsH.push(gridHor)
	
	gridHor.states.add 
		up1: 
			y: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize
		down1: 
			y: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize
		up2: 
			y: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/1.5
		down2: 
			y: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/1.5
		up3: 
			y: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/2
		down3: 
			y: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/2
		up4: 
			y: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/2.2
		down4: 
			y: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/2.2
	gridHor.states.animationOptions = curve: "ease-out", time: animateTime
		
for gridIndex in [0...gridFactorVer - 1]
	gridVer = new Layer
		name: "gridVer"
		width: lineWidth
		height: bg.height-lineWidth*2
		x: gridGap * gridIndex + gridGap - 5
		y: 0
		backgroundColor: gridColor
		parent: bg
	GridsV.push(gridVer)
	
	gridVer.states.add 
		left1: 
			x: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize
		right1: 
			x: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize
		left2: 
			x: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/1.5
		right2: 
			x: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/1.5
		left3: 
			x: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/2
		right3: 
			x: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/2
		left4: 
			x: gridGap * gridIndex + gridGap - lineWidth - gridExpandSize/2.2
		right4: 
			x: gridGap * gridIndex + gridGap - lineWidth + gridExpandSize/2.2
	gridVer.states.animationOptions = curve: "ease-out", time: animateTime

bg.on Events.Click, (e, layer) ->
	coords = Pointer.offset event, layer
	tX = coords.x
	tY = coords.y
	
		
	for grid in bg.subLayers
# 		print grid.name
# 		if grid.name == "gridVer"
# 			print "hey"
# 		grid.states.next()
		if Math.abs(grid.x - tX) <= 135 && grid.name == "gridVer"
# 			print coords
			if grid.x < tX
				grid.states.switch("left4")
			else 
				grid.states.switch("right4")
		if Math.abs(grid.x - tX) <= 95 && grid.name == "gridVer"
			if grid.x < tX
				grid.states.switch("left3")
			else 
				grid.states.switch("right3")
		if Math.abs(grid.x - tX) <= 55 && grid.name == "gridVer"
			if grid.x < tX
				grid.states.switch("left2")
			else 
				grid.states.switch("right2")
		if Math.abs(grid.x - tX) <= 15 && grid.name == "gridVer"
			if grid.x < tX
				grid.states.switch("left1")
			else 
				grid.states.switch("right1")
		
		if Math.abs(grid.y - tY) <= 135 && grid.name == "gridHor"
			if grid.y < tY
				grid.states.switch("up4")
			else 
				grid.states.switch("down4")
		if Math.abs(grid.y - tY) <= 95 && grid.name == "gridHor"
			if grid.y < tY
				grid.states.switch("up3")
			else 
				grid.states.switch("down3")
		if Math.abs(grid.y - tY) <= 55 && grid.name == "gridHor"
			if grid.y < tY
				grid.states.switch("up2")
			else 
				grid.states.switch("down2")
		if Math.abs(grid.y - tY) <= 15 && grid.name == "gridHor"
			if grid.y < tY
				grid.states.switch("up1")
			else 
				grid.states.switch("down1")
		grid.onAnimationEnd ->
			this.states.switch("default")
