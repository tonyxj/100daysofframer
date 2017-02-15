# Import file "scroll-n-click"
sketch = Framer.Importer.load("imported/scroll-n-click@1x")

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height - 128 - 98
	y: 128, superLayer: sketch.content
	scrollHorizontal: false
	contentInset: {top: 32, bottom: 32}
	
scroll.content.draggable.options =
	friction: 40, tension: 500, tolerance: 1
	
height = 400
margin = 32

allLayers = []


for i in [0...10]
	layer = new Layer
		backgroundColor: "#fff", borderRadius: 8
		superLayer: scroll.content
		width: scroll.width - 48, height: height
		x: 24, y: (height + margin)*i
		
	layer.style.boxShadow = "0 12px 15px rgba(0,0,0,0.2)"
		
	allLayers.push(layer)

# Q: Not sure what these directionLocks do
# A: Allow dragging only in one direction at a time 
scroll.content.draggable.directionLock = true
# A: The x and y values represent the distance you can drag in a certain direction before it starts locking.
scroll.content.draggable.directionLockThreshold = {x: 25, y: 25}

scroll.content.draggable.on Events.DirectionLockDidStart, (event)->
	for layer in allLayers
		if event.x then layer.draggable.enabled = false
		if event.y then layer.draggable.enabled = true
	

# Initial setup for layers in all layers		
for i in allLayers 
	i.draggable.vertical = false
	remove = endAnimation = false
	directionFactor = 1
	
	i.on Events.DragMove, ->
		if Math.abs(this.x) > 300 or Math.abs(this.draggable.velocity.x) > 3
			remove = true
			if this.draggable.direction is "left" 
				directionFactor = -1
			if this.draggable.direction is "right" then directionFactor = 1
	
	i.on Events.DragEnd, ->
		# Create a boolean to see if the bottom has been reached
		# Thought this calculation below is not entirely acurate, but it doesn't have to be
		bottomOfPage = scroll.scrollY > (scroll.content.height - Screen.height)
		# Use the bottomOfPage boolean to change the endAnimation boolean
		endAnimation = if bottomOfPage then true else false
		
		# when the drag indicates of a removal
		if remove is true 
			this.animate 
				properties: {x: Screen.width * directionFactor}
				time: 0.15
			Utils.delay 0.15, => this.destroy()
			
			for i in allLayers
				# When we know that removing the last layer at page bottom is happening ...
				if endAnimation
					# We wait 0.15 seconds for the animation to finish
					Utils.delay 0.12, ->
						# and scroll the scroll.content component 
						scroll.scrollToPoint
							# The point here is that scrollY is the number of pixels that the component has been scrolled up, past the top of the page. Minus the height of the card and its one margin, you'd reach the bottom
							x: 0, y: scroll.scrollY - height - margin, true
							curve: "spring"
							curveOptions: {tension: 400, friction: 30, tolerance: 0.01}
						
						scroll.content.on Events.AnimationEnd, ->
							# Call it to update the size of your ScrollComponent accordingly.
							scroll.updateContent()
							
# 				print i.index + " " + this.index
				# layer.index returns the index number for all the layers in the array allLayers, where as this.index indicates the active one (the one being dragged on).
				# The if statement below is a good measure to find the layers after the current layer. 
				if i.index > this.index
					i.animate
						properties: {y: i.y - height - margin}
						delay: 0.13
						curve: "spring"
						curveOptions: {tension:400, friction:30, tolerance: 0.01}
						
					unless endAnimation
						i.on Events.AnimationEnd, -> 
							scroll.updateContent()
						
			return remove = false
		
		else
			this.animate
				properties: {x: 24}
				curve: "spring(200, 40, 0)"