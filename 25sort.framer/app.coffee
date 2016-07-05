defaultSpring = "spring(500, 50, 10)"
Framer.Defaults.Animation = curve: defaultSpring

bgColor = new Color('03AC87').lighten(10)
bg = new BackgroundLayer backgroundColor: bgColor
heightVal = 150
padding = 30
tiles = []
startIndex = null


# This function sorts and animates tiles into new positions.
sortVertically = (array) ->
	# Go through the array by looping through two variables, bo and t, bo will the actually objects in the array while t will be the index numbers
	for bo, t in array	
		# Chill out on animating.
		bo.animateStop()
		# As long as it's not the dragging element, we ...
		if bo.draggable.isDragging is false
			# Animate it into place
			bo.animate properties:
				y: (heightVal + padding) * t + 200


# This is the crucial functions that makes it all work.
# In this function, the index number of each tile is compared and updated, according to its midY value.
updateIndex = (layer, array) ->
	# Make a new array of all midY values.
	midYs = array.map (i) -> i.midY
	
	# Going higher up the list
	# Since the items in this array are all number, it makes it super easy to compare them. And since this function is fired constantly (onDrag), the midY values are constantly being updated, making it possible to detect change in y position.
	if midYs[startIndex] <= midYs[startIndex-1]
		array.splice(startIndex,1)
		array.splice(startIndex-1, 0, layer)
		startIndex = array.indexOf(layer)
		sortVertically(array)
	
	# Going lower down the list
	else if midYs[startIndex] >= midYs[startIndex+1]
		array.splice(startIndex,1)
		array.splice(startIndex+1, 0, layer)
		startIndex = array.indexOf(layer)
		sortVertically(array)


# Loop to create layers and interactions
for tile in [0..4]
	tile = new Layer
		width: 536
		height: heightVal
		borderRadius: 4
		color: "#bbb"
		backgroundColor: "white"
		html: tile + 1
		style: 
			fontSize: "5rem"
			paddingTop: "58px"
			paddingLeft: "30px"
		borderRadius: 7
		x: 100
		y: (heightVal + padding) * tile + 200
		shadowY: 3
		shadowBlur: 6
		shadowColor: "rgba(0,0,0,.16)"
	tiles.push(tile)
	
	tile.draggable.enabled = true
	
	tile.on Events.TouchStart, (event, layer) ->
		# Bring it to the front of all layers.
		@.bringToFront()
		
		# Record the starting index
		startIndex = tiles.indexOf(@)
		# Animate to a dragging state!
		@.animate
			properties:
				scale: 1.1
				shadowY: 4
				shadowBlur: 15
				shadowColor: "rgba(0,0,0,.2)"
	
	tile.on Events.DragMove, (event, layer) ->
		updateIndex(layer, tiles)
		sortVertically(tiles)
		
		
	tile.on Events.DragEnd, (event, layer) ->
		# Animate the dragged layer back into place
		@.animate properties:
			y: (heightVal + padding) * (tiles.indexOf(@)) + 200
			x: 100
			scale: 1
			shadowY: 4
			shadowBlur: 15
			shadowColor: "rgba(0,0,0,.2)"
		
		for newTile in [0..tiles.length-1]
			tiles[newTile].html = newTile + 1
	
	tile.on Events.TouchEnd, (event, layer) ->
# 		Animate the dragged layer back into place
		@.animate properties:
			y: (heightVal + padding) * (tiles.indexOf(@)) + 200
			x: 100
			scale: 1
			shadowY: 4
			shadowBlur: 15
			shadowColor: "rgba(0,0,0,.2)"

		
		
		
	