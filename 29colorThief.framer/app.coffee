{ColorThief} = require "colorThief"
colorThief = new ColorThief

page = new PageComponent width: Screen.width, height: Screen.height, scrollVertical: false

color = "black"
Layers = []
Overlays = []
Colors = []

for i in [0..4]
	layer = new Layer
		superLayer: page.content
		width: Screen.width
		height: Screen.height
		x: i * Screen.width
		backgroundColor: Color.random()
		image: Utils.randomImage()
	Layers.push(layer)
	overlay = new Layer
		superLayer: page.content
		width: Screen.width
		height: Screen.height
		x: i * Screen.width
		html: "IMAGE #{i+1}"
		style: 
			textAlign: "center"
			fontSize: "3.5rem"
			paddingTop: "1190px"
			fontWeight: 300
			letterSpacing: "3px"
			fontFamily: "Futura, Source Sans Pro, Roboto, Helvetica"
	Overlays.push(overlay)


colorThief.getColor Layers[0].image, (color) ->
	Overlays[0].style = background: "linear-gradient(190deg, rgba(0,0,0, 0) 10%, #{color} 90%)"
	Overlays[0].html = color

colorThief.getColor Layers[1].image, (color) ->
	Overlays[1].style = background: "linear-gradient(190deg, rgba(0,0,0, 0) 10%, #{color} 90%)"
	Overlays[1].html = color

colorThief.getColor Layers[2].image, (color) ->
	Overlays[2].style = background: "linear-gradient(190deg, rgba(0,0,0, 0) 10%, #{color} 90%)"
	Overlays[2].html = color

colorThief.getColor Layers[3].image, (color) ->
	Overlays[3].style = background: "linear-gradient(190deg, rgba(0,0,0, 0) 10%, #{color} 90%)"
	Overlays[3].html = color
		
colorThief.getColor Layers[4].image, (color) ->
	Overlays[4].style = background: "linear-gradient(190deg, rgba(0,0,0, 0) 10%, #{color} 90%)"
	Overlays[4].html = color




