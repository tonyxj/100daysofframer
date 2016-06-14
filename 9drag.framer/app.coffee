Framer.Device.background.backgroundColor = "#e1efe2"

bg = new BackgroundLayer
	backgroundColor: "#eee"
	width: Screen.width
	height: Screen.height
	
layerH = 170
margin = 20
totalH = layerH + margin
Layers = []
tempLayers = []
animateTime = 0.18


assignIndexHtml = (arr, currentIndex, targetIndex) ->
	arr[currentIndex].index = targetIndex 
	arr[currentIndex].html = targetIndex

# arr = ["a", "b", "c", "d"]
# print "original: " + arr 
# print "o1: " + arr[0]

Array.prototype.move = (from, to) ->
	this.splice(to, 0, this.splice(from, 1)[0])

swapElement = (indexA, indexB) ->
  tmp = Layers[indexA]
  Layers[indexA] = Layers[indexB]
  Layers[indexB] = tmp
  return
 
arraymove = (arr, fromIndex, toIndex) ->
    element = arr[fromIndex]
    arr.splice(fromIndex, 1)
    arr.splice(toIndex, 0, element)

# arr.move(0,3);
# print "moved: " + arr 
# print "m1: " + arr[0]
newLayers = []
movingY = 0
originalY = 0

createLayers = () ->
	for i in [0..3]
		layer = new Layer
			width: 630
			height: layerH
			x: Align.center
			y: totalH * (i+1)
			backgroundColor: "white"
			borderRadius: 10
			shadowY: 2
			shadowBlur: 4
			shadowColor: "rgba(0,0,0, 0.2)"
			style: 
				color: "#888"
				fontSize: "50px"
				boxSizing: "border-box"
				paddingTop: "10%"
				paddingLeft: "7%"
			
		layer.html = "Sequence #"
		layer.draggable.enabled = true
		layer.draggable.speedX = 0.2
		
		Layers.push(layer)
	# 	Layers[i].onClick ->
	# 		this.backgroundColor = "orange"
	# 		print this
createLayers()

checkDrag = () ->
			
	Layers[0].onDrag ->
		this.z = 5
		movingY = this.y
		if movingY < totalH * 1.5 
			Layers[1].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
		if movingY >= totalH * 1.5 and movingY < totalH * 2.5
			Layers[1].animate {properties: (y: totalH * 1), curve: "linear", time: animateTime}
			Layers[2].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
		if movingY >= totalH * 2.5 and movingY < totalH * 3.5
			Layers[2].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[3].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 3.5
			Layers[3].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
			
	Layers[1].onDrag ->
		this.z = 5
		movingY = this.y
		if movingY < totalH * 1.5 
			Layers[0].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
		if movingY >= totalH * 1.5 and movingY < totalH * 2.5
			Layers[0].animate {properties: (y: totalH * 1), curve: "linear", time: animateTime}
			Layers[2].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
		if movingY >= totalH * 2.5 and movingY < totalH * 3.5
			Layers[2].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[3].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 3.5
			Layers[3].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
	
	Layers[2].onDrag ->
		this.z = 5
		movingY = this.y
		if movingY < totalH * 1.5 
			Layers[0].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[1].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
		if movingY >= totalH * 1.5 and movingY < totalH * 2.5
			Layers[0].animate {properties: (y: totalH * 1), curve: "linear", time: animateTime}
			Layers[1].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
		if movingY >= totalH * 2.5 and movingY < totalH * 3.5
			Layers[1].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[3].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 3.5
			Layers[3].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
	
	Layers[3].onDrag ->
		this.z = 5
		movingY = this.y
		if movingY < totalH * 1.5 
			Layers[0].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[1].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
			Layers[2].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 1.5 and movingY < totalH * 2.5
			Layers[0].animate {properties: (y: totalH * 1), curve: "linear", time: animateTime}
			Layers[1].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
			Layers[2].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 2.5 and movingY < totalH * 3.5
			Layers[1].animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
			Layers[2].animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
		if movingY >= totalH * 3.5
			Layers[2].animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}

	for i in [0..3]
		Layers[i].onDragStart ->
			this.animate 
				properties: 
					scale: 1.1 
					shadowY: 15
					shadowBlur: 40
				curve: "spring(300, 22, 0)"
		Layers[i].onMove ->
			if movingY < totalH * 1.5 
				this.html = "Sequence " + 1
			if movingY >= totalH * 1.5 and movingY < totalH * 2.5
				this.html = "Sequence " + 2
			if movingY >= totalH * 2.5 and movingY < totalH * 3.5
				this.html = "Sequence " + 3
			if movingY >= totalH * 3.5
				this.html = "Sequence " + 4
				
		Layers[i].onDragEnd ->
			this.animate 
				properties: 
					x: Align.center
					scale: 1
					shadowY: 2
					shadowBlur: 4
				curve: "linear", time: animateTime
			
			if movingY < totalH * 1.5
				this.animate {properties: (y: totalH * 1), curve: "linear", time: animateTime}
				
			if movingY >= totalH * 1.5 and movingY < totalH * 2.5
				this.animate {properties: (y: totalH * 2), curve: "linear", time: animateTime}
				
			if movingY >= totalH * 2.5 and movingY < totalH * 3.5
				this.animate {properties: (y: totalH * 3), curve: "linear", time: animateTime}
				
			if movingY >= totalH * 3.5
				this.animate {properties: (y: totalH * 4), curve: "linear", time: animateTime}
			
			Utils.delay animateTime * 1.1, ->
				for j in [0..3]
					tempLayers.push(Layers[j])
					Layers[j].destroy()
				Layers = []	
				createLayers()
				checkDrag()

checkDrag()	

