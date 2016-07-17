atime = 0.5

button = new Layer
	width: 250
	height: 100
	borderRadius: 7
	backgroundColor: "#2389ec"
	html: "save"
	style: 
		fontSize: "2.9rem"
		textAlign: "center"
		lineHeight: "95px"
button.center()

bg = new Layer
	width: Screen.width
	height: Screen.height
	opacity: 0
	backgroundColor: "black"

full = new Layer
	width: 152
	height: 152
	image: "images/full.png"
	parent: bg
	opacity: 0
full.center()
full.states.add on: opacity: 1
full.states.animationOptions = time: atime

spin = new Layer
	width: 153
	height: 153
	image: "images/spin.png"
	parent: bg
	opacity: 0
spin.center()
spin.states.add on: rotation: 720, opacity: 1
spin.states.animationOptions = curve: "ease", time: atime*2

check = new Layer
	width: 67
	height: 54
	image: "images/check.png"
	parent: bg
	scale: 0
	opacity: 0
check.center()
check.states.add on: scale: 0.9, opacity: 1
check.states.animationOptions = curve: "spring(200, 10, 0)"

text = new Layer
	html: "Successfully saved."
	backgroundColor: null
	width: 400
	parent: bg
	x: Align.center
	y: 480
	opacity: 0
	style:
		textAlign: "center"
		fontSize: "2.5rem"
		fontWeight: 300
text.states.add on: y: 515, opacity: 1
text.states.animationOptions = curve: "spring(200, 11, 0)"

fadeIn = (layer, del) ->
	layer.animate properties: (opacity: 1), time: atime, delay: del

fadeOut = (layer, del) ->
	layer.animate properties: (opacity: 0), time: atime, delay: del	
spinning = () ->
	fadeOut(button)
	fadeIn(bg)
	Utils.delay atime*1.5, ->
		spin.states.next()
		Utils.delay atime, ->
			full.states.next()
			Utils.delay atime/2, ->
				check.states.next()
				Utils.delay atime, ->
					text.states.next()
					fadeOut(bg, atime * 3) 
					fadeIn(button, atime * 4)
					Utils.delay atime * 4, ->
						spin.states.switchInstant("default")
						full.states.switchInstant("default")
						check.states.switchInstant("default")
						text.states.switchInstant("default")

button.onClick ->
	spinning()
