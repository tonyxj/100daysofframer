
scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false
	backgroundColor: null

layerH = 500
Layers = []
LayersBack = []
Headers = []
HeadersBack = []

for i in [0..8]
	layerBack = new Layer
		width: Screen.width
		height: layerH
		backgroundColor: "white"
		borderColor: "gray"
		borderWidth: 2
		x: 0
		y: 0
		opacity:  0
		html: "Layer #{i + 1}"
		style:
			padding: "18rem"
			fontSize: "3rem"
			color: "black"
	LayersBack.push(layerBack)
	
	headerBack = new Layer
		width: Screen.width
		height: 100
		backgroundColor: "rgb(#{i}9,#{i}5,#{i}e)"
		y: 0
		opacity: 0
		html: i + 1
		borderColor: "white"
		borderWidth: 4
		style: 
			padding: "32px"
			fontSize: "50px"
	HeadersBack.push(headerBack)

for i in [0..8]
	layer = new Layer
		width: Screen.width
		height: layerH
		backgroundColor: "white"
		borderColor: "lightgray"
		borderWidth: 2
		x: 0
		y: i * layerH
		html: "Layer #{i + 1}"
		style:
			padding: "18rem"
			fontSize: "3rem"
			color: "black"
		superLayer: scroll.content
	Layers.push(layer)
	
	header = new Layer
		width: Screen.width
		height: 100
		backgroundColor: "rgb(#{i}9,#{i}5,#{i}e)"
		y: layer.y
		superLayer: scroll.content
		borderColor: "white"
		borderWidth: 4
		html: i + 1
		style: 
			padding: "32px"
			fontSize: "50px"
	Headers.push(header)

addedLayer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "lightgray"
	superLayer: scroll.content
	y: 500 * 9

scroll.bringToFront() 
scroll.onMove ->
# 	if Layers[1].screenFrame.y <= 0
# 		Headers[1].superLayer = scroll
# 		Headers[1].y = 0
# 	else
# 		Headers[1].superLayer = scroll.content
# 		Headers[1].y = Layers[1].y
	for i in [0..8]
		if Layers[i].screenFrame.y <= 0
			Layers[i].opacity = 0
			Headers[i].opacity = 0
			LayersBack[i].opacity = 1
			HeadersBack[i].opacity = 1
		else
			Layers[i].opacity = 1
			Headers[i].opacity = 1
			LayersBack[i].opacity = 0
			HeadersBack[i].opacity = 0
	

		
		