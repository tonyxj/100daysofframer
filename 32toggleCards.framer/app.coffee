Screen.backgroundColor = "#fff"

cards = [
	"art"
	"architecture"
	"photography"
	"fashion"
	"design"
	null
]

# Card Class
class Card extends Layer
	constructor: (options={}) ->
		@_toggled = options.toggled or false
		@_label 	= options.label or "ADD NEW"
		@_keyColor = new Color(options.keyColor or "black")
		@_fontSize = options.labelSize or 32
		
		options.backgroundColor ?= "transparent"
		options.color ?= @_keyColor
		
		super options
		
		@.props = 
			borderRadius: options.borderRadius or @height/2
			borderWidth: options.borderWidth or 5
			borderColor: @_keyColor 
			html: @_label
			name: "CARD: #{@_label}"
		
		@style = 
			fontWeight: "bold"
			textAlign: "center"
			fontSize: "#{@_fontSize}px"
		
		# Size and position
		_size = Utils.textSize @html, @style
		_padding = 32
		_borderW = @borderWidth * 2
		
# 		@height = _size.height + _borderW + _padding * 2
		@height = 280
# 		@width = _size.width + _borderW + _padding * 4
		@width = 315
		@style.lineHeight = "#{@height - _borderW}px"
		@midX = options.midX
		
		# States
		@.states.add on: backgroundColor: @_keyColor, color: "white", opacity: 1
		@.states.animationOptions = time: .25
		@.states.switchInstant "on" if @_toggled
		
		@onClick ->
			@.states.next()
# 			print @.html, @.states.current
			
# Create Cards
for cardItem, i in cards
	card = new Card
		label: cardItem
		y: (i * 150) + 100
		clip: true
		keyColor: Utils.randomColor().darken(30)
		x: 50
		toggled: true
		borderRadius: 10
	
	if i % 2 == 1
		card.x = Screen.width / 2 + 10
		card.y -= 150
		
	cardBg = new Layer
		image: Utils.randomImage()
		opacity: 0.22
		size: card.size
		superLayer: card
# 	cardBg.screenFrame = card.screenFrame
# 	if i % 2 == 0
# 		cardBg.x += 50
# 	cardBg.sendToBack(0)

