

layerW = 5
layerH = 50
numLayers = 50
margin = 10
ballR = 50

Layers = []

container = new Layer
	width: 0
	height: 100
	backgroundColor: null
	
for i in [0 .. numLayers]
	layer = new Layer
		width: layerW
		height: layerH
		borderRadius: layerW / 2
		x: i * (margin + layerW)
		superLayer: container
		backgroundColor: "rgba(90,150,220, 1)"
	Layers.push(layer)
	container.width += layerW + margin

container.centerX()
container.centerY(50)

dot = new Layer
	height: ballR
	width: ballR
	borderRadius: "50%"
	backgroundColor: "orange"
dot.centerX()
dot.centerY(120)

dot.draggable.enabled = true
dot.draggable.vertical = false

dot.draggable.constraints =
	y: Align.center
	x: 0
	height: 0
	width: Screen.width
dot.draggable.momentum = false

for layer in Layers
	layer.states.add
		highlight1: 
			y: -(layerH*1.5)
			height: layerH * 2
			backgroundColor: "orange"
		highlight2: 
			y: -(layerH*0.8)
			height: layerH * 1.3
			backgroundColor: "purple"
	layer.states.animationOptions = curve: "linear", time: 0.05
	if layer.x >= (dot.x + 12) and (layer.x + layerW) <= (dot.x + ballR + margin - 4)
		layer.states.switch("highlight1")
	else if (layer.x >= (dot.x - margin * 2 + 12) and layer.x < (dot.x + 12)) or (layer.x + layerW) > (dot.x + ballR + margin - 4) and ((layer.x + layerW) < (dot.x + ballR + 4 * margin - 4)) 
		layer.states.switch("highlight2")
	else
		layer.states.switch("default")
	

dot.onDrag ->
	for layer in Layers
		if layer.x >= (dot.x + 12) and (layer.x + layerW) <= (dot.x + ballR + margin - 4)
			layer.states.switch("highlight1")
		else if (layer.x >= (dot.x - margin * 2) and layer.x < (dot.x + 12)) or (layer.x + layerW) > (dot.x + ballR + margin - 4) and ((layer.x + layerW) < (dot.x + ballR + 4 * margin - 4)) 
			layer.states.switch("highlight2")
		else
			layer.states.switch("default")

	
			


