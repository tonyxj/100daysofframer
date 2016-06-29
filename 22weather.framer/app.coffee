# Import file "weather"
sketch = Framer.Importer.load("imported/weather@1x")
{Pointer} = require "Pointer"

bg = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "white"

sketch.tmr_blue.opacity = 0

sketch.openner.center()
sketch.openner.bringToFront()
sketch.openner.props = 
	z: 100
	shadowY: 30
	shadowBlur: 60
	scale: 0.75
	clip: true
sketch.openner.centerX()
sketch.openner.centerY(-100)

sketch.openner.onTapStart ->
	this.animate
		properties:
			z: 80
			shadowY: 25
			shadowBlur: 40
		curve: "linear"
		time: 0.03
		
sketch.openner.onTapEnd ->
	Utils.delay 0.25, ->
		sketch.openner.animate
			properties:
				z: 0
				x: 0
				y: 0
				scale: 1
				opacity: 0
				width: Screen.width
				height: Screen.height
				shadowY: 30
				shadowBlur: 60
			time: 0.35


circle = new Layer
	superLayer: sketch.openner
	borderRadius: "50%"
	opacity: 0
	backgroundColor: "#00ABFF"

sketch.openner.on Events.Click, (event, layer) ->
	coords = Pointer.offset event, layer
	
	circle.scale = 0
	circle.opacity = 1
	circle.midX = coords.x
	circle.midY = coords.y
	circle.animate
		time: .5
		curve: "ease-out"
		properties:
			scale: 18
			opacity: 0
	Utils.delay 0.5, ->
		sketch.info.animate
			properties:
				opacity: 1
				scale: 1
			time: 0.25
		
		animateToday()


sketch.info.bringToFront()
sketch.info.props =
	opacity: 0
	scale: 0.9

animateToday = () ->
	sketch.tday_blue.animate
		properties:
			opacity: 1
		time: 0.3
	
	sketch.tmr_blue.animate
		properties:
			opacity: 0
		time: 0.3
	
	sketch.raindrop.animate
		properties:
			opacity: 1
		time: 0.3
	
	sketch.location.animate
		properties:
			x: 865
		curve: "spring(200, 22, 0)"
		
	sketch.thunder.animate
		properties:
			x: 0
			opacity: 1
		curve: "spring(200, 22, 0)"
	
	sketch.sunny.animate
		properties:
			x: 780
			opacity: 0
		time: 0.3
	
	sketch.sun.animate
		properties:
			scale: 1
			x: 100
			rotation: 0
		time: 0.3
	
	sketch.weather_icon.animate
		properties:
			x: 846
			scale: 1
			y: 535
		curve: "spring(100, 15, 0)"
	
	sketch.temperature.animate
		properties:
			x: 1100
		curve: "spring(110, 25, 0)"
	
	sketch.lightening.animate
		properties:
			y: 190
			x: 85
			scale: 1
		curve: "spring(110, 25, 0)"
		
	sketch.date_select.animate
		properties:
			y: Screen.height - 185
		curve: "spring(110, 25, 0)"
		
	sketch.temperature_tmr.animate
		properties:
			opacity: 0
			x: 1608
		curve: "spring(110, 25, 0)"
	
	sketch.temperature.animate
		properties:
			opacity: 1
			x: 1100
		curve: "spring(110, 25, 0)"
		
	Utils.delay 0.3, ->
		sketch.raindrop.animate
			properties:
				y: 295
				opacity: 0.3
			curve: "spring(60, 22, 0)"
				

sketch.tday_btn.onClick ->
	animateToday()

sketch.tmr_btn.onClick ->
	animateTmr()

animateTmr = () ->
		
	sketch.tday_blue.animate
		properties:
			opacity: 0
		time: 0.3
	
	sketch.tmr_blue.animate
		properties:
			opacity: 1
		time: 0.3
	
	sketch.raindrop.animate
		properties:
			opacity: 0
		time: 0.3
	
	sketch.thunder.animate
		properties:
			opacity: 0
			x: 150
		time: 0.3
	
	sketch.temperature.animate
		properties:
			opacity: 0
			x: 950
		time: 0.25
	
	sketch.sunny.animate
		properties:
			opacity: 1
			x: 868
		curve: "spring(200, 22, 0)"
	
	sketch.temperature_tmr.animate
		properties:
			opacity: 1
			x: 1100
		curve: "spring(110, 25, 0)"
	
	sketch.lightening.animate
		properties:
			opacity: 1
			x: 160
			y: 0
			scale: 0.6
		curve: "spring(200, 22, 0)"
	
	Utils.delay 0.31, ->
		sketch.raindrop.animate
			properties:
				opacity: 1
				y: 100
			time: 0
			
	Utils.delay 0.1, ->
		sketch.weather_icon.animate
			properties:
				x: 900
				y: 545
				scale: 0.7
			curve: "spring(100, 15, 0)"
			
		sketch.sun.animate
			properties:
				x: -55
				scale: 2.6
				rotation: -60
			curve: "spring(80, 21, 0)"
