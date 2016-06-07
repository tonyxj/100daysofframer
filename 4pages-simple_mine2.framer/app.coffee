amount = 4
margin = 80
marginHor = margin
marginVer = margin * 3
indicatorD = 14
allCards = []
allIndicators = []
allBg = []

page = new PageComponent
	width: Screen.width, height: Screen.height
	scrollVertical: false
	backgroundColor: "rgba(0,0,0,0.2)"

# Create a for loop for the number of new layers in the page component
for i in [0...amount]
	
	bg = new Layer
		width: page.width
		height: page.height
		x: 0
		y: 0
		index: 0
		opacity: 0
		backgroundColor: "none"
	
	bg.states.add(active: {opacity: 1})
	bg.states.animationOptions =  time: 0.3
	
	card = new Layer
		html: i
		backgroundColor: "#fff"
		borderRadius: 15
		width: page.width - (marginHor * 2)
		height:  page.height - (marginVer * 2)
		x: (page.width + marginHor) * (i + 1) 
		y: 150
		opacity: 0.7
		scale: 0.6
		shadowY: 10
		shadowBlur: 10
		shadowColor: "rgba(0,0,0,0.8)"
		# Very important these layers be added the "page" PageComponent
		superLayer: page.content
	
	card.style =
		"color": "black"
		"font-size": "33rem"
		"text-align": "center"
		"font-family": "Freight"
		"padding-top": "25rem"
	
	indicator = new Layer
		backgroundColor: "#eee", width: indicatorD, height: indicatorD
		y: 1120, x: marginHor/2 * i 
		borderRadius: "50%", opacity: 0.45
	
	indicator.x += (Screen.width / 2) - 16.5 * amount - (2 * amount)
	indicator.states.add(active: {opacity: 1, scale: 1.2})
	indicator.states.animationOptions = time: 0.2
	
	allCards.push(card)
	allIndicators.push(indicator)
	allBg.push(bg)
	
page.snapToPage(page.content.subLayers[0])

# For some reason, the last card do not snap to the right spots
# Doing the snapping below forces the last card to have the correct margins
page.content.subLayers[amount-1].x = page.content.subLayers[amount-1].x - marginHor 

allIndicators[0].opacity = 1
allBg[0].opacity = 1

# allBg[0].html =  "<img src = 'images/0.jpg' height = '100%' width = 'auto' text-align = 'center'>"

for i in [0...4]
	allBg[i].image = "images/" + i + ".jpg"


# Adding the cards state separately in a for loop
for card in allCards
	card.states.add
		normal:
			scale: 0.8
			shadowY: 10
			shadowBlur: 10
			shadowColor: "rgba(0,0,0,0.8)"
			opacity: 0.95
		active:
			shadowY: 50
			shadowBlur: 80
			shadowColor: "rgba(0,0,0,0.97)"
			opacity: 1
			scale: 1.1
		
	card.onClick ->
		this.states.next("active", "normal")
	card.states.animationOptions = curve: "spring(480, 22, 0)"
	
page.on "change:currentPage", ->
	current = page.horizontalPageIndex(page.currentPage)
	
	indicator.states.switch("default") for indicator in allIndicators
	allIndicators[current].states.switch("active")
	
	card.states.switch("default") for card in allCards
	allCards[current].states.switch("normal")
	
	bg.opacity = 0 for bg in allBg
	allBg[current].states.switch("active")

allCards[0].scale = 0.8
allCards[0].opacity = 0.95