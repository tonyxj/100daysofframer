# SETUP
# Import file "hangout-icons"
sketch = Framer.Importer.load("imported/hangout-icons@1x")

Utils.globalLayers(sketch)
Framer.Defaults.Animation = curve: "spring(180,15,0)"

# GLOBALS
size = 135
margin = 70
numButtons = 3
buttons = []

# CONTAINER
container = new Layer	
	size: Screen.size
	backgroundColor: "black"
	contrast: 6000
container.center()

# UI
button = new Layer	
	size: size
	backgroundColor: "red"
	borderRadius: "100%"
	blur: 20
	x: Screen.width - size - margin
	y: Screen.height - size - margin * 1.5
	parent: container

for i in [0...numButtons]
	buttonCopy = button.copy()
	buttonCopy.props =
		parent: container
	buttonCopy.name = "buttonCopy#{i}"
	buttons.push(buttonCopy)
	buttonCopy.states.add 
		clicked:
			scale: 1.1
			x: buttonCopy.x - i * size
			y: buttonCopy.y - size * 2 + i * size

for icon, t in ["people", "messages", "video"]
	sketch[icon].props =
		scale: 0.4
		opacity: 0
		midX: container.subLayers[t+1].midX
		midY: container.subLayers[t+1].midY
	sketch[icon].states.add 
		clicked:
			opacity: 1
			x: sketch[icon].x - t * size
			y: sketch[icon].y - size * 2 + t * size 
	sketch[icon].bringToFront()

plus.props = 
	scale: 0.45
	midX: button.midX
	midY: button.midY
plus.states.add clicked: rotation: 180, opacity: 0

minus.props =
	scale: 0.45
	midX: button.midX
	midY: button.midY 
minus.name = "minus"
minus.states.add clicked: rotation: 180, opacity: 1

plus.bringToFront()
minus.bringToFront()

# EVENTS
button.onClick ->
	plus.states.next()
	minus.states.next()
	for button in buttons
		button.states.next()
	for icon in ["messages", "people", "video"]
		sketch[icon].states.next()
