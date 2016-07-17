Screen.backgroundColor = "#fff"
mainColor = "05ac70"

class Button extends Layer
	constructor: (options={}) ->
		thisButton = @
		@_cta = options.cta or "NO TEXT"
		@_bgColor = new Color(options.bgColor or mainColor)
		@_fontSize = options.ctaSize or 48
		@_y = options.y or 0
		
		super options
		
		@.props = 
			backgroundColor: @_bgColor
			borderRadius: options.borderRadius or @height/2
			html: @_cta
			y: @_y
			shadowY: 30
			shadowBlur: 60
			shadowColor: "rgba(0,0,0,0.3)"
			name: "button: #{@_cta}"
			
		@style =
			textAlign: "center"
			letterSpacing: "1px"
			fontSize: "#{@_fontSize}px"
			
		_size = Utils.textSize @html, @style
		_padding = @_fontSize
		
		@height = _size.height + _padding * 2.2
		@width = _size.width + 400
		@style.lineHeight = "#{@height}px"
		
		@.states.add on: backgroundColor: @_bgColor.darken(5), y: @y + 12, shadowY: 18, shadowBlur: 20
		@.states.animationOptions = curve: "linear", time: 0.05
		
		@.onTouchStart ->
			@.states.switch("on")
		@.onTouchMove ->
			@.states.switch("default")
		@.onTouchEnd ->
			@.states.switch("default")
		
		@.onClick ->
			Utils.delay 0.1, ->
				thisButton.states.switch("default")

button = new Button
	cta: "Contact Us"
	ctaSize: 50
	x: 100
	y: 900


