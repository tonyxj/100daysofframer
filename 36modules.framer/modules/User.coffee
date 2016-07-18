

class User extends Layer
  constructor: (options={}) ->
    thisUser = @
    @_idNum = options.idNum or "NO ID"
    @_name = options.name or "NO NAME"
    @_email = options.email or "NO EMAIL"
    @_phone = options.phone or "NO PHONE NUMBER"
    @_company = options.company or "NO COMPANY"
    @_city = options.city or "NO CITY"
    @_website = options.website or "NO WEBSITE"
    @_y = options.y or 100
    
    super options
    
    @html = """
      <b>Customer ID:</b> 509309#{@_idNum}<br>
      <b>Name:</b> #{@_name}<br>
      <b>Email:</b> #{@_email}<br>
      <b>Phone:</b> #{@_phone}<br>
      <b>Company:</b> #{@_company}<br>
      <b>City:</b> #{@_city}<br>
      <b>Website:</b> #{@_website}<br>
      """
    _padding = 32
    _height = 470

    @props = 
      x: _padding
      y: @_y
      parent: @_parent
      width: Screen.width - _padding * 2
      color: "#112"
      height: _height
      backgroundColor: null
    
    @style =
      fontSize: "39px"
      lineHeight: "60px"
    

exports.User = User
