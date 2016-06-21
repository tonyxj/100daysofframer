# Import file "screen"
sketch = Framer.Importer.load("imported/screen@1x")
# Import file "screen"
layerH = 500
layers = []

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	backgroundColor: "black"
scroll.scrollHorizontal = false

videos = []

_0 = new VideoLayer
	x: - Screen.width * 0.35
	width: Screen.width * 1.7
	height: layerH
	video: "images/0.mp4"
videos.push(_0)

_1 = new VideoLayer
	x: - Screen.width * 0.15
	width: Screen.width * 1.3
	height: layerH
	video: "images/1.mp4"
videos.push(_1)

_2 = new VideoLayer
	x: - Screen.width * 0.15
	width: Screen.width * 1.3
	height: layerH
	video: "images/2.mp4"
videos.push(_2)

_3 = new VideoLayer
	x: - Screen.width * 0.15
	width: Screen.width * 1.3
	height: layerH
	video: "images/3.mp4"
videos.push(_3)

_4 = new VideoLayer
	x: - Screen.width * 0.15
	width: Screen.width * 1.3
	height: layerH
	video: "images/4.mp4"
videos.push(_4)

for i in [0 ... 5]
	layer = new Layer
		width: Screen.width
		height: layerH
		backgroundColor: Color.random()
		y: i * layerH + 750
		superLayer: scroll.content
		clip: true
	layers.push(layer)
	
	videos[i].superLayer = layers[i]
	sketch["$#{i}"].superLayer = layer
	sketch["$#{i}"].center()
	sketch["$#{i}"].states.add
		play:
			opacity: 0
	sketch["$#{i}"].states.animationOptions =
		curve: "ease"
		time: 0.3
	sketch["t#{i+1}"].superLayer = layer
	sketch["t#{i+1}"].x = Align.left(35)
	sketch["t#{i+1}"].y = Align.bottom(-110)
	sketch["t#{i+1}"].states.add
		play:
			opacity: 0
	sketch["t#{i+1}"].states.animationOptions =
		curve: "ease"
		time: 0.3

# sketch.arrivals.superLayer = scroll.content
sketch.arrivals.y = 60
sketch.arrivals.x = 35
sketch.arrivals.bringToFront()

bottomPadding = new Layer
	width: Screen.width
	height: layerH
	backgroundColor: null
	superLayer: scroll.content
	y: 6 * layerH + 750

scroll.onMove ->
	scrAmt = scroll.scrollY
	contentY = scrAmt / 5
	sketch.arrivals.opacity = 1 - contentY / 60
	sketch.arrivals.y = 60 - contentY
	
	if scrAmt >= 200 and scrAmt < (200 + layerH)
		sketch.$0.states.switch("play")
		sketch.t1.states.switch("play")
		_0.player.play()
		_1.player.pause()
		sketch.$1.states.switch("default")
		sketch.t2.states.switch("default")
		
	else if scrAmt >= (200 + layerH) and scrAmt < (200 + layerH * 2)
		sketch.$0.states.switch("default")
		sketch.t1.states.switch("default")
		sketch.$1.states.switch("play")
		sketch.t2.states.switch("play")
		_0.player.pause()
		_1.player.play()
		_2.player.pause()
		sketch.$2.states.switch("default")
		sketch.t3.states.switch("default")
		
	else if scrAmt >= (200 + layerH * 2) and scrAmt < (200 + layerH * 3)
		sketch.$1.states.switch("default")
		sketch.t2.states.switch("default")
		sketch.$2.states.switch("play")
		sketch.t3.states.switch("play")
		_1.player.pause()
		_2.player.play()
		_3.player.pause()
		sketch.$3.states.switch("default")
		sketch.t4.states.switch("default")
	
	else if scrAmt >= (200 + layerH * 3) and scrAmt < (200 + layerH * 4)
		sketch.$2.states.switch("default")
		sketch.t3.states.switch("default")
		sketch.$3.states.switch("play")
		sketch.t4.states.switch("play")
		_2.player.pause()
		_3.player.play()
		_4.player.pause()
		sketch.$4.states.switch("default")
		sketch.t5.states.switch("default")
		
	else if scrAmt >= (200 + layerH * 4)
		sketch.$3.states.switch("default")
		sketch.t4.states.switch("default")
		sketch.$4.states.switch("play")
		sketch.t5.states.switch("play")
		_3.player.pause()
		_4.player.play()
		
	else
		sketch.$0.states.switch("default")
		sketch.t1.states.switch("default")
		_0.player.pause()
		
