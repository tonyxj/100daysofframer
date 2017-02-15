amount = 3
margin = 80
marginHor = margin
marginVer = margin * 3
allCards = []

page = new PageComponent
	width: Screen.width, height: Screen.height
	scrollVertical: false
	backgroundColor: "#eee"

# Create a for loop for the number of new layers in the page component
for i in [0...amount]
	card = new Layer
		backgroundColor: "#fff"
		borderRadius: 15
		width: page.width - (marginHor * 2)
		height:  page.height - (marginVer * 2)
		x: (Screen.width + marginHor) * i 
		y: 150
		shadowY: 10
		shadowBlur: 10
		shadowColor: "rgba(0,0,0,0.1)"
		
		# Very important these layers be added the "page" PageComponent
		superLayer: page.content

	allCards.push(card)
	
page.snapToPage(page.content.subLayers[0])

# For some reason, the first card and last card do not snap to the right spots
# Doing the snapping below forces the first and last card to have the correct margins
page.content.subLayers[0].x = page.content.subLayers[0].x + marginHor 
page.content.subLayers[amount-1].x = page.content.subLayers[amount-1].x - marginHor 

# Adding the cards state separately in a for loop
for card in allCards
	card.states.add
		active:
			shadowY: 50
			shadowBlur: 80
			shadowColor: "rgba(0,0,0,0.2)"
			scale: 1.1

	card.on Events.TouchEnd, ->
		this.states.next()
	card.states.animationOptions = curve: "spring(900, 30, 0)"