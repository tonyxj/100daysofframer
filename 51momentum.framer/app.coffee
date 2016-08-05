# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""

inertiaCurve = "spring(150, 10, 0)"

Layer::inertia = () ->
	speedConstant = 80
	
	dragDirectionisUpwards = @.draggable.calculateVelocity().y < 0
	currentVelocityY = Math.abs(@.draggable.calculateVelocity().y)
	currentYPosition = @.y
	
	dragDirectionisForwards = @.draggable.calculateVelocity().x < 0
	currentVelocityX = Math.abs(@.draggable.calculateVelocity().x)
	currentXPosition = @.x
	
	if dragDirectionisUpwards
		@.animate
			properties: y: currentYPosition - (currentVelocityY * speedConstant)
			curve: inertiaCurve
	else
		@.animate
			properties: y: currentYPosition + (currentVelocityY * speedConstant)
			curve: inertiaCurve
	
	if dragDirectionisForwards
		@.animate
			properties: x: currentXPosition - (currentVelocityX * speedConstant)
			curve: inertiaCurve
	else
		@.animate
			properties: x: currentXPosition + (currentVelocityX * speedConstant)
			curve: inertiaCurve
	
	@.onAnimationEnd ->
		if @.maxY > Screen.height
			@.animate
				properties: 
					maxY: Screen.height
				curve: inertiaCurve
		if @.y < 0
			@.animate
				properties: 
					y: 0
				curve: inertiaCurve
		if @.maxX > Screen.width
			@.animate
				properties: 
					maxX: Screen.width
				curve: inertiaCurve
		if @.x < 0
			@.animate
				properties: 
					x: 0
				curve: inertiaCurve
		
inertiaLayer = new Layer size: 180, backgroundColor: "lightblue", html: "inertia"
inertiaLayer.draggable.enabled = true
inertiaLayer.center()
inertiaLayer.centerY(-100)

momentumLayer = new Layer size: 180, backgroundColor: "lightgreen", html: "momentum"
momentumLayer.draggable.enabled = true
momentumLayer.draggable.overdrag = false

momentumLayer.center()
momentumLayer.centerY(100)

momentumLayer.draggable.momentumOptions =
	tension: 200
	friction: 5
	
momentumLayer.draggable.constraints =
	x: 0
	y: 0
	width: Screen.width
	height: Screen.height

detectHit = ->
	if inertiaLayer.maxX >= momentumLayer.x and 
	inertiaLayer.x <= momentumLayer.maxX and
	inertiaLayer.maxY >= momentumLayer.y and
	inertiaLayer.y <= momentumLayer.maxY
		inertiaLayer.animate 
			properties: 
				backgroundColor: "orange" 
				opacity: 0.7
			curve: inertiaCurve
		momentumLayer.animate 
			properties: 
				backgroundColor: "red" 
				opacity: 0.7
			curve: inertiaCurve
	else
		inertiaLayer.animate 
			properties: 
				backgroundColor: "lightblue"
				opacity: 1
			curve: inertiaCurve
		momentumLayer.animate 
			properties: 
				backgroundColor: "lightgreen" 
				opacity: 1
			curve: inertiaCurve
	

inertiaLayer.on Events.DragEnd, -> 
	@.inertia()
	detectHit()
	@.onAnimationEnd ->
		detectHit()

inertiaLayer.onMove ->
	detectHit()
	
momentumLayer.on Events.DragEnd, -> 
	@.inertia()
	detectHit()
	@.onAnimationEnd ->
		detectHit()

momentumLayer.onMove ->
	detectHit()
	



