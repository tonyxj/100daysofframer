
# Amount denotes to the number of vertical cards there are
amount = 6
# num denotes to the number of horizontal cards in each row
num = 4
# CardH is the vertical height of each card in pixel
cardH = 600
# Margin is the number pixel for the in between the cards
margin = 10
# AllCards is an array that 
allCards = []
allPages = []
colors = []

scroll = new ScrollComponent
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false

	
for i in [0...amount]
	card = new PageComponent
		width: scroll.width
		height: cardH
		scrollVertical: false
		x: 0
		y: (cardH + margin) * i
		superLayer: scroll.content
		backgroundColor: "black"
	card.animationOptions =
		 curve: "spring"
		curveOptions: {tension:900, friction:10, tolerance: 0.01} 
	allCards.push(card)

for cards in allCards	
	card.content.draggable.options =
		friction: 10, tension: 400, tolerance: 1
	for i in [0...num]
		colors[i] = Utils.randomColor(0.9)
		page = new Layer
			html: cards.id + ":"+ i
			width: scroll.width
			height: cardH
			x: scroll.width * i
# 			backgroundColor: Utils.randomColor(0.9)
			style: background:"-webkit-linear-gradient(110deg,"+colors[i]+" 0%, #433 98%)"
			superLayer: cards.content
		
		page.style =
			"color": "white"
			"font-size": "240px"
			"font-weight": 300
			"font-family": "Futura"
			"padding-top": "10rem"
			"padding-left": "2.3rem"
		
		allPages.push(page)

# Allow dragging only in one direction at a time 
scroll.content.draggable.directionLock = true

# Event handler for when the direction lock has been triggered
scroll.content.draggable.on Events.DirectionLockDidStart, (event)->
			# If lock on horizontal movement is true (meaning that the drag is vertical), then the card layers inside allCards array will be disabled from being dragged horizontally. This makes sense because when you're draggin the scroll content up and down, usually you dont want the list time to be draggable horizontally
	for card in allCards
		# if the x lock is on, then the horizontal lock is turned on
		if event.x then card.scrollHorizontal = false
		# if the y lock is on, then the horizontal lock is turned off
		if event.y then card.scrollHorizontal = true