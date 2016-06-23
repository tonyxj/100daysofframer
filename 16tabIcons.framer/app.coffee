iconS = 130
bMargin = 40
folders = []
bottomIcons = []
animationTime = 0.35

bg = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "black"
bg.states.add
	large:
		scale: 8
		opacity: 0
	medium:
		scale: 4.85
		opacity: 0
bg.states.animationOptions = time: animationTime

outLayer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: null
	superLayer: bg

bottomTab = new Layer
	width: Screen.width
	height: 200
	y: Screen.height - 200
	backgroundColor: "rgba(255,255,230, 0.3)"
	superLayer:  bg

for i in [0..3]
	bottomIcon = new Layer
		width: iconS
		height: iconS
		borderRadius: 18
		backgroundColor: Color.random()
		superLayer: bottomTab
		y: 36
		x: 55 + (iconS + bMargin) * i
	bottomIcons.push(bottomIcon)
	
	bottomIcon.onClick ->
		selector = this
		selector.opacity = 0
		bg.originY = 1

		if this.id == 4
			bg.originX = 0
		if this.id == 5
			bg.originX = 0.33
		if this.id == 6
			bg.originX = 0.66
		if this.id == 7
			bg.originX = 1
			
		bg.states.switch("large")
		newIcon = this.copy()
		newIcon.opacity = 1
		newIcon.frame = this.screenFrame
		newIcon.states.add
			large:
				width: Screen.width
				height: Screen.height
				x: 0
				y: 0
				borderRadius: 0 
				backgroundColor: "white"
		newIcon.states.animationOptions = time: animationTime
		newIcon.states.switch("large")
		newIcon.onClick ->
			bg.animate
				properties: 
					scale: 1
					opacity: 1
				time: animationTime
			newIcon.states.switch("default")
			newIcon.onAnimationEnd ->
				this.destroy()
				bg.states.switchInstant("default")
				selector.opacity = 1
		
		

for i in [0..2]
	folder = new Layer
		width: iconS
		height: iconS
		borderRadius: 18
		x: 55 + (iconS + bMargin) * i
		y: 40
		backgroundColor: "rgb(100,100,100)"
		superLayer: bg
	folders.push(folder)
	
	
	for j in [0..2]
		subIcon = new Layer
			width: 30
			height: 30
			borderRadius: 7
			backgroundColor: Color.random()
			x: 15 + (30 + 6) * j
			y: 16
			superLayer: folder
	
	folder.onClick ->
		selector = this
		selector.opacity = 0
		bg.originY = 0
		
		if this.id == 8
			bg.originX = 0.1
		if this.id == 12
			bg.originX = 0.35
		if this.id == 16
			bg.originX = 0.66
		
		bg.states.switch("medium")
		newFolder = this.copy()
		newFolder.opacity = 1
		newFolder.frame = this.screenFrame
		newFolder.states.add
			large:
				scale: 4.5
				x: 310
				y: 520
			xlarge: 
				scale: 12
				opacity: 0
		newFolder.states.animationOptions = time: animationTime
		newFolder.states.switch("large")
		
		outLayer.onClick ->
			bg.animate
				properties: 
					scale: 1
					opacity: 1
				time: animationTime
			newFolder.states.switch("default")
			newFolder.onAnimationEnd ->
				this.destroy()
				bg.states.switchInstant("default")
				selector.opacity = 1
			
		for c in [0..newFolder.subLayers.length-1]
			newFolder.subLayers[c].onClick ->
				newSub = this.copy()
				originalPos = this.screenFrame
				newSub.frame = originalPos
				originalColor = newSub.backgroundColor
				
				if newSub.x < 230
					newFolder.states.switch("xlarge")
					newFolder.animate
						properties:
							x: 800
						time: animationTime
				else if newSub.x >= 231 and newSub.x < 400
					newFolder.states.switch("xlarge")
				else
					newFolder.states.switch("xlarge")
					newFolder.animate
						properties:
							x: -150
						time: animationTime
				newSub.states.add
					large:
						width: Screen.width
						height: Screen.height
						x: 0
						y: 0
						borderRadius: 0
						backgroundColor: "white"
				newSub.states.animationOptions = time: animationTime
				newSub.states.switch("large")
				newSub.onClick ->
					newSub.states.switch("default")
					newSub.animate
						properties:
							width: originalPos.width
							height: originalPos.height
							x: originalPos.x
							y: originalPos.y
							borderRadius: 7 * 4.5
							backgroundColor: originalColor
						time: animationTime
					newFolder.states.switch("large")
					newFolder.opacity = 1
					newSub.onAnimationEnd ->
						this.destroy()
						
				
				
	

				


