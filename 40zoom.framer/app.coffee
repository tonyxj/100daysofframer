statesTime = 0.6
snowTime = 11

bg = new Layer
	width: Screen.width
	height: Screen.height
	scale: 1.05
	image: "images/meh.ro10874.jpg"
	z: 0
	blur: 6
bg.states.add
	one:
		scale: 1.25
		blur: 3
		originY: 0
	two:
		scale: 1.43
		blur: 0
bg.states.animationOptions = curve: "ease-in-out", time: statesTime * 2



mountain = new Layer
	width: Screen.width
	height: 760
	image: "images/mountain-psd89920.png"
	maxY: Screen.height
	blur: 3
	z: 40
mountain.states.add 
	one:
		blur: 0
		scale: 1.35
		originY: 1
		rotationX: 3
	two: 
		scale: 2.3
		originY: 0
		y: 1300
mountain.states.animationOptions = curve: "ease-in-out", time: statesTime * 2

snow = new Layer
	size: Screen.size
	x: 0
	y: 0
	z: 100
	opacity: 0.95
	backgroundColor: null
snow.states.add 
	one:
		blur: 10
		scale: 15
		originY: 0
	two:
		opacity: 0.8
snow.states.animationOptions = curve: "ease-in-out", time: statesTime * 2

snowfall = new Layer
	width: Screen.width
	height: Screen.height
	maxY: Screen.height
	parent: snow
	image: "images/Transparent_Snowfall_PNG_Effect.png"

snowfall1 = snowfall.copy()
snowfall1.props =
	name: "snowfall1"
	parent: snow
	maxY: 0
	
snowing = new Animation
	layer: snowfall
	properties:
		y: Screen.height
	time: snowTime
	curve: "linear"

snowing1 = new Animation
	layer: snowfall1
	properties:
		y: 0
	time: snowTime
	curve: "linear"

snowing.start()
snowing1.start()

snowfall.on Events.AnimationEnd, (animation, layer) ->
	snowfall.y = 0
	snowing.start()

snowfall1.on Events.AnimationEnd, (animation, layer) ->
	snowfall1.maxY = 0
	snowing1.start()



touchLayer = new Layer
	size: Screen.size
	opacity: 0

touchLayer.onClick ->
	snow.states.next()
	mountain.states.next()
	bg.states.next()




