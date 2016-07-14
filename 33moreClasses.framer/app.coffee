Screen.backgroundColor = "#fff"

cards = [
	"art"
	"architecture"
	"photography"
	"fashion"
	"design"
	null
]

blue = new Color ("blue")
cta = new Layer
	html: "Get Cards"
	style: 
		fontSize: "1.8rem"
		textAlign: "center"
		lineHeight: "100px"
		borderRadius: "200px"
	width: 300
	height: 100
	backgroundColor: blue.lighten(20)

cta.center()
cta.centerY(-500)

class Card extends Layer
	constructor: (options={}) ->
		@_label = options.label or "NEW"
		@_bgColor = new Color(options.bgColor) or "green"
		@_order = options.order or 0
		if @_order < 2
			@_y = 300
		else if @_order >= 2 && @_order < 4
			@_y = 700
		else 
			@_y = 1100
		thisCard = @
		
# 		options.backgroundColor ?= @_bgColor
		options.color ?= "white"
		
		super options
		
		@props = 
			width: 330
			height: 450
			borderRadius: "6px"
			html: @_label
			name: "#{@_label}"
			backgroundColor: @_bgColor
			shadowY: -5
			shadowBlur: 30
			shadowColor: "rgba(0,0,0,0.25)"
		
		@style = 
			fontSize: "2rem"
			textTransform: "uppercase"
			textAlign: "center"
			fontWeight: 600
			lineHeight: "190px"
			
		if @_order % 2 == 1
			@x = Screen.width/2 + 15
		else
			@x = 30
		
		@.states.add on: y: @_y
		@.states.animationOptions = 
			curve: "spring(140, 13, 0)"
			delay: 0.07 * @_order
		cta.onClick ->
			cta.states.next()
			thisCard.states.next()


for cardItem, i in cards
	card = new Card
		label: cardItem
		bgColor: Utils.randomColor().saturate(10).darken(30)
		order: i
		y: Screen.height + 100
	
	img = new Layer
		size: card.size
		superLayer: card
		opacity: 0.3
		image: Utils.randomImage()

	
	card.bringToFront()
	
	