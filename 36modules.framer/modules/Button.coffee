class Button extends Layer
	constructor: (options={}) ->
		thisButton = @
		@_cta = options.cta or "NO TEXT"
		@_x = options.x or 0
		@_bgColor = new Color(options.bgColor or "05cd89")
		@_fontSize = options.ctaSize or 48
		@_y = options.y or 0
		
		super options
		
		@.props = 
			backgroundColor: @_bgColor
			borderRadius: options.borderRadius or @height/2
			html: @_cta
			x: @_x
			y: @_y
			shadowY: 30
			shadowBlur: 60
			shadowColor: "rgba(0,0,0,0.2)"
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
		@.states.animationOptions = curve: "linear", time: 0.03
		
		@.onTouchStart ->
			@.states.switch("on")
		@.onTouchMove ->
			@.states.switch("default")
		@.onTouchEnd ->
			@.states.switch("default")
		
		@.onClick ->
			Utils.delay 0.06, ->
				thisButton.states.switch("default")

exports.Button = Button