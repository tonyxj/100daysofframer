# Import file "checkout"
background = new BackgroundLayer backgroundColor: "white"
Framer.Defaults.Animation = curve: "spring(100,14.7,0)"

sketch = Framer.Importer.load("imported/checkout@1x")
Utils.globalLayers(sketch)

seventy_nine.states.add
	hide:
		x: 520
		opacity: 0
seventy_nine.states.switchInstant('hide')

nine.states.add
	hide:
		x: 550
		opacity: 0

background.states.add
	dark:
		backgroundColor: "rgba(255,255,255, 0.8)"
		
jul.states.add
	hide:
		x: 510
		opacity: 0
jul.states.switchInstant("hide")

aug.states.add
	hide:
		x: 510
		opacity: 0

bg.states.add 
	back:
		blur: 38
		
overlay.states.add
	front:
		y: 45

selector.states.add
	year:
		x: 350

bg.onClick ->
	@.states.switch("back")
	background.states.switch("dark")
	Utils.delay 0.3, ->
		overlay.states.switch("front")

year.onClick ->
	selector.states.switch("year")
	aug.states.switch("hide")
	jul.states.switch("default")
	nine.states.switch("hide")
	seventy_nine.states.switch("default")
	
month.onClick ->
	selector.states.switch("default")
	aug.states.switch("default")
	jul.states.switch("hide")
	nine.states.switch("default")
	seventy_nine.states.switch("hide")

closeB.onClick ->
	overlay.states.switch("default")
	Utils.delay 0.3, ->
		bg.states.switch("default")
		background.states.switch("default")

cancel.onClick ->
	overlay.states.switch("default")
	Utils.delay 0.3, ->
		bg.states.switch("default")
		background.states.switch("default")

purchaseB.onClick ->
	overlay.states.switch("default")
	Utils.delay 0.3, ->
		bg.states.switch("default")
		background.states.switch("default")