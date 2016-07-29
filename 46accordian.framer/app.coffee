margin = 15
listItemH = 150
numOfListItems = 15
listExpandFactor = 6
clicked = false

gradientsJSON = JSON.parse Utils.domLoadDataSync "https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json"

colorPairs = []

for color in gradientsJSON
	colorPairs.push(color.colors.join(","))

scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false

updateScrollLayer = new Layer
	height: 1
	backgroundColor: null
	parent: scroll.content
	y: numOfListItems * (listItemH + margin) + (listExpandFactor - 1)  * listItemH

for i in [0 ... numOfListItems]
	randomColorPairs = Utils.randomChoice(colorPairs)
	listItem = new Layer
		width: Screen.width - margin * 2
		height: listItemH
		x: margin
		y: i * (listItemH + margin) + margin
		borderRadius: margin / 3
		parent: scroll.content
		html: "item #{i+1}"
		style:
			fontSize: "3rem"
			lineHeight: "9rem"
			fontFamily: "Helvetica Neue"
			paddingLeft: "2rem"
			background: "linear-gradient(to bottom right, #{randomColorPairs})"
	
	listItem.originalY = i * (listItemH + margin)
	listItem.expandedY = 
		i * (listItemH + margin) + listItemH * (listExpandFactor - 1)
		
	listItem.states.add
		expanded:
			height: listItemH * listExpandFactor
		movedDown:
			y: i * (listItemH + margin) + listItemH * (listExpandFactor - 1) + margin
	listItem.states.animationOptions = 
		curve: "spring(150, 18, 0)"	
	
	listItem.onClick ->
		if clicked == false 
			clicked = true
		else
			clicked = false
		
		for lItem, t in scroll.content.subLayers
			lItem.states.switch('default')
			
			if lItem.id == @id && clicked is true
				lItem.states.switch("expanded")
				scroll.scrollToPoint(y: lItem.y - margin)
			if lItem.id > @id && clicked is true
				lItem.states.switch("movedDown")
				
		
		
		
		
		
		
		
		