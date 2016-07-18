require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"Button":[function(require,module,exports){
var Button,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Button = (function(superClass) {
  extend(Button, superClass);

  function Button(options) {
    var _padding, _size, thisButton;
    if (options == null) {
      options = {};
    }
    thisButton = this;
    this._cta = options.cta || "NO TEXT";
    this._x = options.x || 0;
    this._bgColor = new Color(options.bgColor || "05cd89");
    this._fontSize = options.ctaSize || 48;
    this._y = options.y || 0;
    Button.__super__.constructor.call(this, options);
    this.props = {
      backgroundColor: this._bgColor,
      borderRadius: options.borderRadius || this.height / 2,
      html: this._cta,
      x: this._x,
      y: this._y,
      shadowY: 30,
      shadowBlur: 60,
      shadowColor: "rgba(0,0,0,0.2)",
      name: "button: " + this._cta
    };
    this.style = {
      textAlign: "center",
      letterSpacing: "1px",
      fontSize: this._fontSize + "px"
    };
    _size = Utils.textSize(this.html, this.style);
    _padding = this._fontSize;
    this.height = _size.height + _padding * 2.2;
    this.width = _size.width + 400;
    this.style.lineHeight = this.height + "px";
    this.states.add({
      on: {
        backgroundColor: this._bgColor.darken(5),
        y: this.y + 12,
        shadowY: 18,
        shadowBlur: 20
      }
    });
    this.states.animationOptions = {
      curve: "linear",
      time: 0.03
    };
    this.onTouchStart(function() {
      return this.states["switch"]("on");
    });
    this.onTouchMove(function() {
      return this.states["switch"]("default");
    });
    this.onTouchEnd(function() {
      return this.states["switch"]("default");
    });
    this.onClick(function() {
      return Utils.delay(0.06, function() {
        return thisButton.states["switch"]("default");
      });
    });
  }

  return Button;

})(Layer);

exports.Button = Button;


},{}],"User":[function(require,module,exports){
var User,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

User = (function(superClass) {
  extend(User, superClass);

  function User(options) {
    var _height, _padding, thisUser;
    if (options == null) {
      options = {};
    }
    thisUser = this;
    this._idNum = options.idNum || "NO ID";
    this._name = options.name || "NO NAME";
    this._email = options.email || "NO EMAIL";
    this._phone = options.phone || "NO PHONE NUMBER";
    this._company = options.company || "NO COMPANY";
    this._city = options.city || "NO CITY";
    this._website = options.website || "NO WEBSITE";
    this._y = options.y || 100;
    User.__super__.constructor.call(this, options);
    this.html = "<b>Customer ID:</b> 509309" + this._idNum + "<br>\n<b>Name:</b> " + this._name + "<br>\n<b>Email:</b> " + this._email + "<br>\n<b>Phone:</b> " + this._phone + "<br>\n<b>Company:</b> " + this._company + "<br>\n<b>City:</b> " + this._city + "<br>\n<b>Website:</b> " + this._website + "<br>";
    _padding = 32;
    _height = 470;
    this.props = {
      x: _padding,
      y: this._y,
      parent: this._parent,
      width: Screen.width - _padding * 2,
      color: "#112",
      height: _height,
      backgroundColor: null
    };
    this.style = {
      fontSize: "39px",
      lineHeight: "60px"
    };
  }

  return User;

})(Layer);

exports.User = User;


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvVEovRG93bmxvYWRzLzM2bW9kdWxlcy5mcmFtZXIvbW9kdWxlcy9CdXR0b24uY29mZmVlIiwiL1VzZXJzL1RKL0Rvd25sb2Fkcy8zNm1vZHVsZXMuZnJhbWVyL21vZHVsZXMvVXNlci5jb2ZmZWUiLCIvVXNlcnMvVEovRG93bmxvYWRzLzM2bW9kdWxlcy5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQSxJQUFBLE1BQUE7RUFBQTs7O0FBQU07OztFQUNRLGdCQUFDLE9BQUQ7QUFDWixRQUFBOztNQURhLFVBQVE7O0lBQ3JCLFVBQUEsR0FBYTtJQUNiLElBQUMsQ0FBQSxJQUFELEdBQVEsT0FBTyxDQUFDLEdBQVIsSUFBZTtJQUN2QixJQUFDLENBQUEsRUFBRCxHQUFNLE9BQU8sQ0FBQyxDQUFSLElBQWE7SUFDbkIsSUFBQyxDQUFBLFFBQUQsR0FBZ0IsSUFBQSxLQUFBLENBQU0sT0FBTyxDQUFDLE9BQVIsSUFBbUIsUUFBekI7SUFDaEIsSUFBQyxDQUFBLFNBQUQsR0FBYSxPQUFPLENBQUMsT0FBUixJQUFtQjtJQUNoQyxJQUFDLENBQUEsRUFBRCxHQUFNLE9BQU8sQ0FBQyxDQUFSLElBQWE7SUFFbkIsd0NBQU0sT0FBTjtJQUVBLElBQUMsQ0FBQyxLQUFGLEdBQ0M7TUFBQSxlQUFBLEVBQWlCLElBQUMsQ0FBQSxRQUFsQjtNQUNBLFlBQUEsRUFBYyxPQUFPLENBQUMsWUFBUixJQUF3QixJQUFDLENBQUEsTUFBRCxHQUFRLENBRDlDO01BRUEsSUFBQSxFQUFNLElBQUMsQ0FBQSxJQUZQO01BR0EsQ0FBQSxFQUFHLElBQUMsQ0FBQSxFQUhKO01BSUEsQ0FBQSxFQUFHLElBQUMsQ0FBQSxFQUpKO01BS0EsT0FBQSxFQUFTLEVBTFQ7TUFNQSxVQUFBLEVBQVksRUFOWjtNQU9BLFdBQUEsRUFBYSxpQkFQYjtN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R0FLc0IscUJBTHRCLEdBTVMsSUFBQyxDQUFBLEtBTlYsR0FNZ0Isd0JBTmhCLEdBT1ksSUFBQyxDQUFBLFFBUGIsR0FPc0I7SUFFOUIsUUFBQSxHQUFXO0lBQ1gsT0FBQSxHQUFVO0lBRVYsSUFBQyxDQUFBLEtBQUQsR0FDRTtNQUFBLENBQUEsRUFBRyxRQUFIO01BQ0EsQ0FBQSxFQUFHLElBQUMsQ0FBQSxFQURKO01BRUEsTUFBQSxFQUFRLElBQUMsQ0FBQSxPQUZUO01BR0EsS0FBQSxFQUFPLE1BQU0sQ0FBQyxLQUFQLEdBQWUsUUFBQSxHQUFXLENBSGpDO01BSUEsS0FBQSxFQUFPLE1BSlA7TUFLQSxNQUFBLEVBQVEsT0FMUjtNQU1BLGVBQUEsRUFBaUIsSUFOakI7O0lBUUYsSUFBQyxDQUFBLEtBQUQsR0FDRTtNQUFBLFFBQUEsRUFBVSxNQUFWO01BQ0EsVUFBQSxFQUFZLE1BRFo7O0VBbkNTOzs7O0dBREk7O0FBd0NuQixPQUFPLENBQUMsSUFBUixHQUFlOzs7O0FDdENmLE9BQU8sQ0FBQyxLQUFSLEdBQWdCOztBQUVoQixPQUFPLENBQUMsVUFBUixHQUFxQixTQUFBO1NBQ3BCLEtBQUEsQ0FBTSx1QkFBTjtBQURvQjs7QUFHckIsT0FBTyxDQUFDLE9BQVIsR0FBa0IsQ0FBQyxDQUFELEVBQUksQ0FBSixFQUFPLENBQVAiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiY2xhc3MgQnV0dG9uIGV4dGVuZHMgTGF5ZXJcblx0Y29uc3RydWN0b3I6IChvcHRpb25zPXt9KSAtPlxuXHRcdHRoaXNCdXR0b24gPSBAXG5cdFx0QF9jdGEgPSBvcHRpb25zLmN0YSBvciBcIk5PIFRFWFRcIlxuXHRcdEBfeCA9IG9wdGlvbnMueCBvciAwXG5cdFx0QF9iZ0NvbG9yID0gbmV3IENvbG9yKG9wdGlvbnMuYmdDb2xvciBvciBcIjA1Y2Q4OVwiKVxuXHRcdEBfZm9udFNpemUgPSBvcHRpb25zLmN0YVNpemUgb3IgNDhcblx0XHRAX3kgPSBvcHRpb25zLnkgb3IgMFxuXHRcdFxuXHRcdHN1cGVyIG9wdGlvbnNcblx0XHRcblx0XHRALnByb3BzID0gXG5cdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IEBfYmdDb2xvclxuXHRcdFx0Ym9yZGVyUmFkaXVzOiBvcHRpb25zLmJvcmRlclJhZGl1cyBvciBAaGVpZ2h0LzJcblx0XHRcdGh0bWw6IEBfY3RhXG5cdFx0XHR4OiBAX3hcblx0XHRcdHk6IEBfeVxuXHRcdFx0c2hhZG93WTogMzBcblx0XHRcdHNoYWRvd0JsdXI6IDYwXG5cdFx0XHRzaGFkb3dDb2xvcjogXCJyZ2JhKDAsMCwwLDAuMilcIlxuXHRcdFx0bmFtZTogXCJidXR0b246ICN7QF9jdGF9XCJcblx0XHRcdFxuXHRcdEBzdHlsZSA9XG5cdFx0XHR0ZXh0QWxpZ246IFwiY2VudGVyXCJcblx0XHRcdGxldHRlclNwYWNpbmc6IFwiMXB4XCJcblx0XHRcdGZvbnRTaXplOiBcIiN7QF9mb250U2l6ZX1weFwiXG5cdFx0XHRcblx0XHRfc2l6ZSA9IFV0aWxzLnRleHRTaXplIEBodG1sLCBAc3R5bGVcblx0XHRfcGFkZGluZyA9IEBfZm9udFNpemVcblx0XHRcblx0XHRAaGVpZ2h0ID0gX3NpemUuaGVpZ2h0ICsgX3BhZGRpbmcgKiAyLjJcblx0XHRAd2lkdGggPSBfc2l6ZS53aWR0aCArIDQwMFxuXHRcdEBzdHlsZS5saW5lSGVpZ2h0ID0gXCIje0BoZWlnaHR9cHhcIlxuXHRcdFxuXHRcdEAuc3RhdGVzLmFkZCBvbjogYmFja2dyb3VuZENvbG9yOiBAX2JnQ29sb3IuZGFya2VuKDUpLCB5OiBAeSArIDEyLCBzaGFkb3dZOiAxOCwgc2hhZG93Qmx1cjogMjBcblx0XHRALnN0YXRlcy5hbmltYXRpb25PcHRpb25zID0gY3VydmU6IFwibGluZWFyXCIsIHRpbWU6IDAuMDNcblx0XHRcblx0XHRALm9uVG91Y2hTdGFydCAtPlxuXHRcdFx0QC5zdGF0ZXMuc3dpdGNoKFwib25cIilcblx0XHRALm9uVG91Y2hNb3ZlIC0+XG5cdFx0XHRALnN0YXRlcy5zd2l0Y2goXCJkZWZhdWx0XCIpXG5cdFx0QC5vblRvdWNoRW5kIC0+XG5cdFx0XHRALnN0YXRlcy5zd2l0Y2goXCJkZWZhdWx0XCIpXG5cdFx0XG5cdFx0QC5vbkNsaWNrIC0+XG5cdFx0XHRVdGlscy5kZWxheSAwLjA2LCAtPlxuXHRcdFx0XHR0aGlzQnV0dG9uLnN0YXRlcy5zd2l0Y2goXCJkZWZhdWx0XCIpXG5cbmV4cG9ydHMuQnV0dG9uID0gQnV0dG9uIiwiXG5cbmNsYXNzIFVzZXIgZXh0ZW5kcyBMYXllclxuICBjb25zdHJ1Y3RvcjogKG9wdGlvbnM9e30pIC0+XG4gICAgdGhpc1VzZXIgPSBAXG4gICAgQF9pZE51bSA9IG9wdGlvbnMuaWROdW0gb3IgXCJOTyBJRFwiXG4gICAgQF9uYW1lID0gb3B0aW9ucy5uYW1lIG9yIFwiTk8gTkFNRVwiXG4gICAgQF9lbWFpbCA9IG9wdGlvbnMuZW1haWwgb3IgXCJOTyBFTUFJTFwiXG4gICAgQF9waG9uZSA9IG9wdGlvbnMucGhvbmUgb3IgXCJOTyBQSE9ORSBOVU1CRVJcIlxuICAgIEBfY29tcGFueSA9IG9wdGlvbnMuY29tcGFueSBvciBcIk5PIENPTVBBTllcIlxuICAgIEBfY2l0eSA9IG9wdGlvbnMuY2l0eSBvciBcIk5PIENJVFlcIlxuICAgIEBfd2Vic2l0ZSA9IG9wdGlvbnMud2Vic2l0ZSBvciBcIk5PIFdFQlNJVEVcIlxuICAgIEBfeSA9IG9wdGlvbnMueSBvciAxMDBcbiAgICBcbiAgICBzdXBlciBvcHRpb25zXG4gICAgXG4gICAgQGh0bWwgPSBcIlwiXCJcbiAgICAgIDxiPkN1c3RvbWVyIElEOjwvYj4gNTA5MzA5I3tAX2lkTnVtfTxicj5cbiAgICAgIDxiPk5hbWU6PC9iPiAje0BfbmFtZX08YnI+XG4gICAgICA8Yj5FbWFpbDo8L2I+ICN7QF9lbWFpbH08YnI+XG4gICAgICA8Yj5QaG9uZTo8L2I+ICN7QF9waG9uZX08YnI+XG4gICAgICA8Yj5Db21wYW55OjwvYj4gI3tAX2NvbXBhbnl9PGJyPlxuICAgICAgPGI+Q2l0eTo8L2I+ICN7QF9jaXR5fTxicj5cbiAgICAgIDxiPldlYnNpdGU6PC9iPiAje0Bfd2Vic2l0ZX08YnI+XG4gICAgICBcIlwiXCJcbiAgICBfcGFkZGluZyA9IDMyXG4gICAgX2hlaWdodCA9IDQ3MFxuXG4gICAgQHByb3BzID0gXG4gICAgICB4OiBfcGFkZGluZ1xuICAgICAgeTogQF95XG4gICAgICBwYXJlbnQ6IEBfcGFyZW50XG4gICAgICB3aWR0aDogU2NyZWVuLndpZHRoIC0gX3BhZGRpbmcgKiAyXG4gICAgICBjb2xvcjogXCIjMTEyXCJcbiAgICAgIGhlaWdodDogX2hlaWdodFxuICAgICAgYmFja2dyb3VuZENvbG9yOiBudWxsXG4gICAgXG4gICAgQHN0eWxlID1cbiAgICAgIGZvbnRTaXplOiBcIjM5cHhcIlxuICAgICAgbGluZUhlaWdodDogXCI2MHB4XCJcbiAgICBcblxuZXhwb3J0cy5Vc2VyID0gVXNlclxuIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
