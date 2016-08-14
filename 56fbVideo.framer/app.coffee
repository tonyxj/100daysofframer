# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Facebook Feed Video Pop"
	author: "Tony"
	twitter: "TonyJing"
	description: ""


# Setup
# Import file "fb-video"
sketch = Framer.Importer.load("imported/fb-video@1x")
Utils.globalLayers(sketch)
Framer.Defaults.Animation = curve: "spring(200, 16, 0)"

# Var
shrinkScale = 0.93

# Layers
scroll = new ScrollComponent
	width: Screen.width, height: Screen.height - 87 - 40
	y: 40, scrollHorizontal: false
	
feed.props = parent: scroll.content, y: 0
baseUI.bringToFront()

foil = new VideoLayer
	width: Screen.width, height: 360 * Screen.width / 640
	video: "images/foil.mp4"

vidContainer = new Layer
	size: foil, scale: shrinkScale
	y: 1341
vidContainer.addChild(foil)
vidContainer.placeBehind(baseUI)

vidBg = new Layer
	size: Screen, backgroundColor: "#000", opacity: 0
vidBg.placeBehind(vidContainer)

# Functions
popUp = (vid) ->
	if vid.open is true
		closeVideo(vid)
	else 
		openVideo(vid)
		runDragging(vid)

openVideo = (vid) ->
	scroll.content.animateStop()
	scroll.scrollVertical = false
	scroll.animate properties: scale: shrinkScale
	baseUI.animate properties: scale: shrinkScale, opacity: 0
	vidBg.animate 
		properties: opacity: 1
		curve: "ease", time: 0.35
	vid.animate properties:
		scale: 1, y: Align.center
	vid.open = true

closeVideo = (vid) ->
	scroll.scrollVertical = true
	scroll.animate properties: scale: 1
	baseUI.animate properties: scale: 1, opacity: 1
	vid.placeBehind(baseUI)
	scrAmt = scroll.scrollY
	vidBg.animate 
		properties: opacity: 0
		curve: "ease", time: 0.35
	vid.animate properties: 
		scale: shrinkScale, y: 1303 - scrAmt + 38, x: Align.center
	vid.onAnimationEnd ->
		vid.open = false
		vid.draggable.enabled = false
		

runDragging = (vid) ->
	vid.draggable.enabled = true
	vid.bringToFront()
	vid.onDrag ->
		x = vid.draggable.offset.x
		y = vid.draggable.offset.y
		dist = Math.sqrt(x*x + y*y)
		vidBg.opacity = Utils.modulate(dist, [0, 650], [1, 0], true)
		baseUI.opacity = Utils.modulate(dist, [0, 650], [0, 1], true)
	vid.onDragEnd ->
		closeVideo(vid)


# Events
scroll.onMove ->
	scrAmt = scroll.scrollY
	vidContainer.y = 1303 - scrAmt + 38
	
	foil.player.volume = 0
	if scrAmt >= 400 and scrAmt <= 1400
		foil.player.play() 
	else 
		foil.player.pause()

vidContainer.onClick ->
	popUp(@)

