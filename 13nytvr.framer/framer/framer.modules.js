require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var GoogleFonts,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty,
  slice = [].slice;

GoogleFonts = (function(superClass) {
  extend(GoogleFonts, superClass);

  function GoogleFonts() {
    var args;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    Utils.domLoadScriptSync("//ajax.googleapis.com/ajax/libs/webfont/1/webfont.js");
    if (args.length) {
      this.load.apply(this, args);
    }
  }

  GoogleFonts.prototype.load = function() {
    var args, families, firstArg, weights;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    firstArg = args[0];
    families = [];
    if (typeof firstArg === "string") {
      weights = args.slice(1).join();
      families.push(firstArg + ":" + weights + ":latin");
    } else {
      (Array.isArray(firstArg) ? firstArg : [firstArg]).forEach(function(family) {
        weights = family.weights || [];
        return families.push(family.font + ":" + weights + ":latin");
      });
    }
    return window.WebFont.load({
      google: {
        families: families
      },
      classes: false,
      loading: (function(_this) {
        return function() {
          return _this.emit("loading");
        };
      })(this),
      active: (function(_this) {
        return function() {
          return _this.emit("active");
        };
      })(this),
      inactive: (function(_this) {
        return function() {
          return _this.emit("inactive");
        };
      })(this),
      fontloading: (function(_this) {
        return function(familyName, fvd) {
          return _this.emit("fontloading", familyName, fvd);
        };
      })(this),
      fontactive: (function(_this) {
        return function(familyName, fvd) {
          return _this.emit("fontactive", familyName, fvd);
        };
      })(this),
      fontinactive: (function(_this) {
        return function(familyName, fvd) {
          return _this.emit("fontinactive", familyName, fvd);
        };
      })(this)
    });
  };

  return GoogleFonts;

})(Framer.BaseClass);

if (typeof module !== "undefined" && module !== null) {
  module.exports = GoogleFonts;
}


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];

exports.GoogleFonts = require("framer-googlefonts");


},{"framer-googlefonts":1}],"placehold":[function(require,module,exports){
var applyStyle, createUrl, isInArr, randomStyle, styleArr;

styleArr = [
  {
    str: "simple",
    url: "http://placehold.it/",
    separator: "x"
  }, {
    str: "unsplash",
    url: "https://unsplash.it/",
    separator: "/"
  }, {
    str: "cage",
    url: "http://placecage.com/",
    separator: "/"
  }, {
    str: "crazy-cage",
    url: "http://placecage.com/c/",
    separator: "/"
  }, {
    str: "murray",
    url: "http://fillmurray.com/",
    separator: "/"
  }, {
    str: "starwars",
    url: "http://420placehold.it/starwars/",
    separator: "-"
  }, {
    str: "startrek",
    url: "http://420placehold.it/startrek/",
    separator: "-"
  }, {
    str: "space",
    url: "http://420placehold.it/space/",
    separator: "-"
  }, {
    str: "fatcats",
    url: "http://420placehold.it/fatcats/",
    separator: "-"
  }, {
    str: "familyphotos",
    url: "http://420placehold.it/familyphotos/",
    separator: "-"
  }
];

isInArr = function(styleStr) {
  var i, j, ref;
  for (i = j = 0, ref = styleArr.length - 1; j <= ref; i = j += 1) {
    if (styleArr[i].str === styleStr) {
      return styleArr[i];
    }
  }
  return false;
};

randomStyle = function(layer) {
  var style;
  style = styleArr[Math.floor(Math.random() * styleArr.length)].str;
  return applyStyle(layer, style);
};

createUrl = function(style, width, height) {
  var inArr, url;
  inArr = isInArr(style);
  if (inArr) {
    url = inArr.url + width + inArr.separator + height;
  } else {
    url = "https://unsplash.it/" + width + '/' + height;
  }
  return url;
};

applyStyle = function(layer, style) {
  var niceUrl;
  niceUrl = createUrl(style, layer.width, layer.height);
  return layer.image = niceUrl;
};

exports.placeHold = function(layer, style) {
  if (layer) {
    if (style !== "random") {
      return applyStyle(layer, style);
    } else {
      return randomStyle(layer, style);
    }
  }
};

exports.getUrl = function(style, width, height) {
  return createUrl(style, width, height);
};


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvVEovR29vZ2xlIERyaXZlL19EZXNpZ24vX0ZyYW1lci8xMDBkYXlzb2ZmcmFtZXIvMTNueXR2ci5mcmFtZXIvbm9kZV9tb2R1bGVzL2ZyYW1lci1nb29nbGVmb250cy9hcHAuY29mZmVlIiwiL1VzZXJzL1RKL0dvb2dsZSBEcml2ZS9fRGVzaWduL19GcmFtZXIvMTAwZGF5c29mZnJhbWVyLzEzbnl0dnIuZnJhbWVyL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIiwiL1VzZXJzL1RKL0dvb2dsZSBEcml2ZS9fRGVzaWduL19GcmFtZXIvMTAwZGF5c29mZnJhbWVyLzEzbnl0dnIuZnJhbWVyL21vZHVsZXMvcGxhY2Vob2xkLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtBQ0NBLElBQUEsV0FBQTtFQUFBOzs7O0FBQU07OztFQUNRLHFCQUFBO0FBQ1osUUFBQTtJQURhO0lBQ2IsS0FBSyxDQUFDLGlCQUFOLENBQXdCLHNEQUF4QjtJQUVBLElBQXVCLElBQUksQ0FBQyxNQUE1QjtNQUFBLElBQUMsQ0FBQSxJQUFJLENBQUMsS0FBTixDQUFZLElBQVosRUFBZSxJQUFmLEVBQUE7O0VBSFk7O3dCQUtiLElBQUEsR0FBTSxTQUFBO0FBQ0wsUUFBQTtJQURNO0lBQ04sUUFBQSxHQUFXLElBQUssQ0FBQSxDQUFBO0lBQ2hCLFFBQUEsR0FBVztJQUdYLElBQUcsT0FBTyxRQUFQLEtBQW1CLFFBQXRCO01BQ0MsT0FBQSxHQUFVLElBQUssU0FBSSxDQUFDLElBQVYsQ0FBQTtNQUNWLFFBQVEsQ0FBQyxJQUFULENBQWlCLFFBQUQsR0FBVSxHQUFWLEdBQWEsT0FBYixHQUFxQixRQUFyQyxFQUZEO0tBQUEsTUFBQTtNQUlDLENBQUksS0FBSyxDQUFDLE9BQU4sQ0FBYyxRQUFkLENBQUgsR0FBK0IsUUFBL0IsR0FBNkMsQ0FBQyxR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QWlCLEtBQUssQ0FBQyxLQUF2QixFQUE4QixLQUFLLENBQUMsTUFBcEM7U0FDVixLQUFLLENBQUMsS0FBTixHQUFjO0FBRkw7O0FBS2IsT0FBTyxDQUFDLFNBQVIsR0FBb0IsU0FBRSxLQUFGLEVBQVMsS0FBVDtFQUVoQixJQUFHLEtBQUg7SUFDSSxJQUFHLEtBQUEsS0FBUyxRQUFaO2FBQ0ksVUFBQSxDQUFZLEtBQVosRUFBbUIsS0FBbkIsRUFESjtLQUFBLE1BQUE7YUFHSSxXQUFBLENBQWEsS0FBYixFQUFvQixLQUFwQixFQUhKO0tBREo7O0FBRmdCOztBQVNwQixPQUFPLENBQUMsTUFBUixHQUFpQixTQUFFLEtBQUYsRUFBUyxLQUFULEVBQWdCLE1BQWhCO0FBQ2IsU0FBTyxTQUFBLENBQVcsS0FBWCxFQUFrQixLQUFsQixFQUF5QixNQUF6QjtBQURNIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIlxuY2xhc3MgR29vZ2xlRm9udHMgZXh0ZW5kcyBGcmFtZXIuQmFzZUNsYXNzXG5cdGNvbnN0cnVjdG9yOiAoYXJncy4uLikgLT5cblx0XHRVdGlscy5kb21Mb2FkU2NyaXB0U3luYyBcIi8vYWpheC5nb29nbGVhcGlzLmNvbS9hamF4L2xpYnMvd2ViZm9udC8xL3dlYmZvbnQuanNcIlxuXHRcdFx0XG5cdFx0QGxvYWQuYXBwbHkgQCwgYXJncyBpZiBhcmdzLmxlbmd0aFxuXG5cdGxvYWQ6IChhcmdzLi4uKSAtPlxuXHRcdGZpcnN0QXJnID0gYXJnc1swXVxuXHRcdGZhbWlsaWVzID0gW11cblx0XHRcblx0XHQjIGNyZWF0ZSBXZWJGb250Q29uZmlnIHN0cmluZ1xuXHRcdGlmIHR5cGVvZiBmaXJzdEFyZyBpcyBcInN0cmluZ1wiXG5cdFx0XHR3ZWlnaHRzID0gYXJnc1sxLi5dLmpvaW4oKVxuXHRcdFx0ZmFtaWxpZXMucHVzaCBcIiN7Zmlyc3RBcmd9OiN7d2VpZ2h0c306bGF0aW5cIlxuXHRcdGVsc2Vcblx0XHRcdChpZiBBcnJheS5pc0FycmF5IGZpcnN0QXJnIHRoZW4gZmlyc3RBcmcgZWxzZSBbZmlyc3RBcmddKVxuXHRcdFx0XHQuZm9yRWFjaCAoZmFtaWx5KSAtPlxuXHRcdFx0XHRcdHdlaWdodHMgPSBmYW1pbHkud2VpZ2h0cyBvciBbXVxuXHRcdFx0XHRcdGZhbWlsaWVzLnB1c2ggXCIje2ZhbWlseS5mb250fToje3dlaWdodHN9OmxhdGluXCJcblxuXHRcdHdpbmRvdy5XZWJGb250LmxvYWQgXG5cdFx0XHRnb29nbGU6IGZhbWlsaWVzOiBmYW1pbGllc1xuXHRcdFx0Y2xhc3NlczogZmFsc2Vcblx0XHRcdCMgRm9udCBsb2FkaW5nIGV2ZW50c1xuXHRcdFx0IyBodHRwczovL2dpdGh1Yi5jb20vdHlwZWtpdC93ZWJmb250bG9hZGVyI2V2ZW50c1xuXHRcdFx0bG9hZGluZzogPT4gQGVtaXQgXCJsb2FkaW5nXCJcblx0XHRcdGFjdGl2ZTogPT4gQGVtaXQgXCJhY3RpdmVcIlxuXHRcdFx0aW5hY3RpdmU6ID0+IEBlbWl0IFwiaW5hY3RpdmVcIlxuXHRcdFx0Zm9udGxvYWRpbmc6IChmYW1pbHlOYW1lLCBmdmQpID0+XG5cdFx0XHRcdEBlbWl0IFwiZm9udGxvYWRpbmdcIiwgZmFtaWx5TmFtZSwgZnZkXG5cdFx0XHRmb250YWN0aXZlOiAoZmFtaWx5TmFtZSwgZnZkKSA9PlxuXHRcdFx0XHRAZW1pdCBcImZvbnRhY3RpdmVcIiwgZmFtaWx5TmFtZSwgZnZkXG5cdFx0XHRmb250aW5hY3RpdmU6IChmYW1pbHlOYW1lLCBmdmQpID0+XG5cdFx0XHRcdEBlbWl0IFwiZm9udGluYWN0aXZlXCIsIGZhbWlseU5hbWUsIGZ2ZFxuXG5tb2R1bGU/LmV4cG9ydHMgPSBHb29nbGVGb250c1xuIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXVxuXG5leHBvcnRzLkdvb2dsZUZvbnRzID0gcmVxdWlyZSBcImZyYW1lci1nb29nbGVmb250c1wiXG4iLCJzdHlsZUFyciA9IFtcbiAgICB7XG4gICAgICAgIHN0cjogXCJzaW1wbGVcIixcbiAgICAgICAgdXJsOiBcImh0dHA6Ly9wbGFjZWhvbGQuaXQvXCIsXG4gICAgICAgIHNlcGFyYXRvcjogXCJ4XCIsXG4gICAgfSxcbiAgICB7XG4gICAgICAgIHN0cjogXCJ1bnNwbGFzaFwiLFxuICAgICAgICB1cmw6IFwiaHR0cHM6Ly91bnNwbGFzaC5pdC9cIixcbiAgICAgICAgc2VwYXJhdG9yOiBcIi9cIixcbiAgICB9LFxuICAgIHtcbiAgICAgICAgc3RyOiBcImNhZ2VcIixcbiAgICAgICAgdXJsOiBcImh0dHA6Ly9wbGFjZWNhZ2UuY29tL1wiLFxuICAgICAgICBzZXBhcmF0b3I6IFwiL1wiLFxuICAgIH0sXG4gICAge1xuICAgICAgICBzdHI6IFwiY3JhenktY2FnZVwiLFxuICAgICAgICB1cmw6IFwiaHR0cDovL3BsYWNlY2FnZS5jb20vYy9cIixcbiAgICAgICAgc2VwYXJhdG9yOiBcIi9cIixcbiAgICB9LFxuICAgIHtcbiAgICAgICAgc3RyOiBcIm11cnJheVwiLFxuICAgICAgICB1cmw6IFwiaHR0cDovL2ZpbGxtdXJyYXkuY29tL1wiLFxuICAgICAgICBzZXBhcmF0b3I6IFwiL1wiLFxuICAgIH0sXG4gICAge1xuICAgICAgICBzdHI6IFwic3RhcndhcnNcIixcbiAgICAgICAgdXJsOiBcImh0dHA6Ly80MjBwbGFjZWhvbGQuaXQvc3RhcndhcnMvXCIsXG4gICAgICAgIHNlcGFyYXRvcjogXCItXCIsXG4gICAgfSxcbiAgICB7XG4gICAgICAgIHN0cjogXCJzdGFydHJla1wiLFxuICAgICAgICB1cmw6IFwiaHR0cDovLzQyMHBsYWNlaG9sZC5pdC9zdGFydHJlay9cIixcbiAgICAgICAgc2VwYXJhdG9yOiBcIi1cIixcbiAgICB9LFxuICAgIHtcbiAgICAgICAgc3RyOiBcInNwYWNlXCIsXG4gICAgICAgIHVybDogXCJodHRwOi8vNDIwcGxhY2Vob2xkLml0L3NwYWNlL1wiLFxuICAgICAgICBzZXBhcmF0b3I6IFwiLVwiLFxuICAgIH0sXG4gICAge1xuICAgICAgICBzdHI6IFwiZmF0Y2F0c1wiLFxuICAgICAgICB1cmw6IFwiaHR0cDovLzQyMHBsYWNlaG9sZC5pdC9mYXRjYXRzL1wiLFxuICAgICAgICBzZXBhcmF0b3I6IFwiLVwiLFxuICAgIH0sXG4gICAge1xuICAgICAgICBzdHI6IFwiZmFtaWx5cGhvdG9zXCIsXG4gICAgICAgIHVybDogXCJodHRwOi8vNDIwcGxhY2Vob2xkLml0L2ZhbWlseXBob3Rvcy9cIixcbiAgICAgICAgc2VwYXJhdG9yOiBcIi1cIixcbiAgICB9XG5dXG5cblxuaXNJbkFyciA9ICggc3R5bGVTdHIgKSAtPiBcblxuICAgIGZvciBpIGluIFswLi5zdHlsZUFyci5sZW5ndGgtMV0gYnkgMVxuXG4gICAgICAgIGlmIHN0eWxlQXJyW2ldLnN0ciA9PSBzdHlsZVN0clxuICAgICAgICAgICAgcmV0dXJuIHN0eWxlQXJyW2ldXG5cbiAgICByZXR1cm4gZmFsc2VcblxuXG5yYW5kb21TdHlsZSA9ICggbGF5ZXIgKSAtPlxuXG4gICAgc3R5bGUgPSBzdHlsZUFycltNYXRoLmZsb29yKE1hdGgucmFuZG9tKCkgKiBzdHlsZUFyci5sZW5ndGgpXS5zdHJcbiAgICBhcHBseVN0eWxlKCBsYXllciwgc3R5bGUgKVxuXG5cbmNyZWF0ZVVybCA9IChzdHlsZSwgd2lkdGgsIGhlaWdodCkgLT5cblxuICAgIGluQXJyID0gaXNJbkFycihzdHlsZSlcblxuICAgIGlmIChpbkFycilcbiAgICAgICAgdXJsID0gaW5BcnIudXJsICsgd2lkdGggKyBpbkFyci5zZXBhcmF0b3IgKyBoZWlnaHRcbiAgICBlbHNlIFxuICAgICAgICB1cmwgPSBcImh0dHBzOi8vdW5zcGxhc2guaXQvXCIgKyB3aWR0aCArICcvJyArIGhlaWdodFxuXG4gICAgcmV0dXJuIHVybFxuXG5cbmFwcGx5U3R5bGUgPSAoIGxheWVyLCBzdHlsZSApIC0+XG4gICAgbmljZVVybCA9IGNyZWF0ZVVybChzdHlsZSwgbGF5ZXIud2lkdGgsIGxheWVyLmhlaWdodClcbiAgICBsYXllci5pbWFnZSA9IG5pY2VVcmxcblxuXG5leHBvcnRzLnBsYWNlSG9sZCA9ICggbGF5ZXIsIHN0eWxlICkgLT5cblxuICAgIGlmIGxheWVyXG4gICAgICAgIGlmIHN0eWxlICE9IFwicmFuZG9tXCJcbiAgICAgICAgICAgIGFwcGx5U3R5bGUoIGxheWVyLCBzdHlsZSApXG4gICAgICAgIGVsc2VcbiAgICAgICAgICAgIHJhbmRvbVN0eWxlKCBsYXllciwgc3R5bGUgKVxuXG5cbmV4cG9ydHMuZ2V0VXJsID0gKCBzdHlsZSwgd2lkdGgsIGhlaWdodCApIC0+IFxuICAgIHJldHVybiBjcmVhdGVVcmwoIHN0eWxlLCB3aWR0aCwgaGVpZ2h0ICkiXX0=
