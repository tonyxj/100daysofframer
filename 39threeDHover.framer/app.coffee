# SETUP
# Import file "2001MovieAppleTV"
sketch = Framer.Importer.load("imported/2001MovieAppleTV@1x")

Utils.globalLayers(sketch)

Screen.backgroundColor = "d3d3d3"
background = new Layer
	size: Screen.size
	opacity: 0

# LAYERS
card = new Layer
	width: 534
	height: 300
	borderRadius:12
	shadowY: 50
	shadowSpread: -35
	shadowBlur: 70
	shadowColor: "rgba(0,0,0,0.9)"
	clip: true

card.x = Align.center
card.y = Align.center
card.perspective = 100

bg.superLayer = card
bg.scale = 1.1
earth.superLayer = card
title.superLayer = card

sun = new Layer
	height: 40
	width: 40
	borderRadius: 30
	backgroundColor: "#ffffee"
	parent: card
	x: 250
	y: 88
	shadowBlur: 20
	shadowSpread: 10
	shadowColor: "rgba(255,255,210, 0.75)"
sun.placeBehind(earth)

sunGlow = sun.copy()
sunGlow.props =
	parent: card
	name: "sunGlow"
	shadowBlur: 250
	shadowSpread: 50
	backgroundColor: null
	scale: 0.5
	shadowColor: "rgba(255,255,210, 0.5)"

reflection = new Layer
	width: 1000
	height: 1000
	x: -200
	y: -200
	superLayer: card
	borderRadius: 1000
	opacity: 0.2
	style:
		"background": "radial-gradient( rgba(255,255,255,1) 0%, rgba(255,255,255,0) 60%)"

# INTERACTION
background.on Events.TouchMove, (event) ->
	delta =
	x: card.midX - Events.touchEvent(event).clientX
	y: card.midY - Events.touchEvent(event).clientY

	card.rotationY = Utils.modulate delta.x, [0, card.midX], [0, -10]
	card.rotationX = Utils.modulate delta.y, [0, card.midY], [0, 10]
	
	bg.x = Utils.modulate delta.x, [0, card.midX], [0, 3]
	bg.y = Utils.modulate delta.y, [0, card.midY], [0, 3]
# 	print title.y

	sun.x = Utils.modulate delta.x, [0, card.midX], [250, 258]
	sun.y = Utils.modulate delta.y, [0, card.midY], [88, 95]
	sunGlow.x = Utils.modulate delta.x, [0, card.midX], [250, 255]
	sunGlow.y = Utils.modulate delta.y, [0, card.midY], [88, 93]

	earth.x = Utils.modulate delta.x, [0, card.midX], [194, 204]
	earth.y = Utils.modulate delta.y, [0, card.midY], [134, 144]
	
	title.x = Utils.modulate delta.x, [0, card.midX], [58, 78]
	title.y = Utils.modulate delta.y, [0, card.midY], [230, 250]
	reflection.x = Utils.modulate delta.x, [0, card.midX], [-200, 200]
	reflection.y = Utils.modulate delta.y, [0, card.midY], [-200, 100]
	reflection.opacity = Utils.modulate delta.x, [0, card.midX], [0.2, 0.5]

Events.wrap(window).addEventListener "resize", (event) ->
	card.x = Align.center
	card.y = Align.center
