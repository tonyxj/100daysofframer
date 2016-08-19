require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"SVGLayer":[function(require,module,exports){
"SVGLayer class\n\nproperties\n- linecap <string> (\"round\" || \"square\" || \"butt\")\n- fill <string> (css color)\n- stroke <string> (css color)\n- strokeWidth <number>\n- dashOffset <number> (from -1 to 1, defaults to 0)";
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.SVGLayer = (function(superClass) {
  extend(SVGLayer, superClass);

  function SVGLayer(options) {
    var cName, d, footer, header, path, t;
    if (options == null) {
      options = {};
    }
    options = _.defaults(options, {
      dashOffset: 1,
      strokeWidth: 2,
      stroke: "#28affa",
      backgroundColor: null,
      clip: false,
      fill: "transparent",
      linecap: "round"
    });
    SVGLayer.__super__.constructor.call(this, options);
    if (options.fill === null) {
      this.fill = null;
    }
    this.width += options.strokeWidth / 2;
    this.height += options.strokeWidth / 2;
    d = new Date();
    t = d.getTime();
    cName = "c" + t;
    header = "<svg class='" + cName + "' x='0px' y='0px' width='" + this.width + "' height='" + this.height + "' viewBox='-" + (this.strokeWidth / 2) + " -" + (this.strokeWidth / 2) + " " + (this.width + this.strokeWidth / 2) + " " + (this.height + this.strokeWidth / 2) + "'>";
    path = options.path;
    footer = "</svg>";
    this.html = header + path + footer;
    Utils.domComplete((function(_this) {
      return function() {
        var domPath;
        domPath = document.querySelector('.' + cName + ' path');
        _this._pathLength = domPath.getTotalLength();
        _this.style = {
          "stroke-dasharray": _this.pathLength
        };
        return _this.dashOffset = options.dashOffset;
      };
    })(this));
  }

  SVGLayer.define("pathLength", {
    get: function() {
      return this._pathLength;
    },
    set: function(value) {
      return print("SVGLayer.pathLength is readonly");
    }
  });

  SVGLayer.define("linecap", {
    get: function() {
      return this.style.strokeLinecap;
    },
    set: function(value) {
      return this.style.strokeLinecap = value;
    }
  });

  SVGLayer.define("strokeLinecap", {
    get: function() {
      return this.style.strokeLinecap;
    },
    set: function(value) {
      return this.style.strokeLinecap = value;
    }
  });

  SVGLayer.define("fill", {
    get: function() {
      return this.style.fill;
    },
    set: function(value) {
      if (value === null) {
        value = "transparent";
      }
      return this.style.fill = value;
    }
  });

  SVGLayer.define("stroke", {
    get: function() {
      return this.style.stroke;
    },
    set: function(value) {
      return this.style.stroke = value;
    }
  });

  SVGLayer.define("strokeColor", {
    get: function() {
      return this.style.stroke;
    },
    set: function(value) {
      return this.style.stroke = value;
    }
  });

  SVGLayer.define("strokeWidth", {
    get: function() {
      return Number(this.style.strokeWidth.replace(/[^\d.-]/g, ''));
    },
    set: function(value) {
      return this.style.strokeWidth = value;
    }
  });

  SVGLayer.define("dashOffset", {
    get: function() {
      return this._dashOffset;
    },
    set: function(value) {
      var dashOffset;
      this._dashOffset = value;
      if (this.pathLength != null) {
        dashOffset = Utils.modulate(value, [0, 1], [this.pathLength, 0]);
        return this.style.strokeDashoffset = dashOffset;
      }
    }
  });

  return SVGLayer;

})(Layer);


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvVEovR29vZ2xlIERyaXZlL19EZXNpZ24vX0ZyYW1lci9wbGF5Z3JvdW5kLzYyc25hcC5mcmFtZXIvbW9kdWxlcy9TVkdMYXllci5jb2ZmZWUiLCIvVXNlcnMvVEovR29vZ2xlIERyaXZlL19EZXNpZ24vX0ZyYW1lci9wbGF5Z3JvdW5kLzYyc25hcC5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQTtBQUFBLElBQUE7OztBQVdNLE9BQU8sQ0FBQzs7O0VBRUEsa0JBQUMsT0FBRDtBQUNaLFFBQUE7O01BRGEsVUFBVTs7SUFDdkIsT0FBQSxHQUFVLENBQUMsQ0FBQyxRQUFGLENBQVcsT0FBWCxFQUNUO01BQUEsVUFBQSxFQUFZLENBQVo7TUFDQSxXQUFBLEVBQWEsQ0FEYjtNQUVBLE1BQUEsRUFBUSxTQUZSO01BR0EsZUFBQSxFQUFpQixJQUhqQjtNQUlBLElBQUEsRUFBTSxLQUpOO01BS0EsSUFBQSxFQUFNLGFBTE47TUFNQSxPQUFBLEVBQVMsT0FOVDtLQURTO0lBUVYsMENBQU0sT0FBTjtJQUVBLElBQUcsT0FBTyxDQUFDLElBQVIsS0FBZ0IsSUFBbkI7TUFDQyxJQUFDLENBQUEsSUFBRCxHQUFRLEtBRFQ7O0lBR0EsSUFBQyxDQUFBLEtBQUQsSUFBVSxPQUFPLENBQUMsV0FBUixHQUFzQjtJQUNoQyxJQUFDLENBQUEsTUFBRCxJQUFXLE9BQU8sQ0FBQyxXQUFSLEdBQXNCO0lBR2pDLENBQUEsR0FBUSxJQUFBLElBQUEsQ0FBQTtJQUNSLENBQUEsR0FBSSxDQUFDLENBQUMsT0FBRixDQUFBO0lBQ0osS0FBQSxHQUFRLEdBQUEsR0FBTTtJQUNkLE1BQUEsR0FBUyxjQUFBLEdBQWUsS0FBZixHQUFxQiwyQkFBckIsR0FBZ0QsSUFBQyxDQUFBLEtBQWpELEdBQXVELFlBQXZELEdBQW1FLElBQUMsQ0FBQSxN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QixVQUEzQixFQUF1QyxFQUF2QyxDQUFQO0lBQUgsQ0FBTDtJQUNBLEdBQUEsRUFBSyxTQUFDLEtBQUQ7YUFDSixJQUFDLENBQUEsS0FBSyxDQUFDLFdBQVAsR0FBcUI7SUFEakIsQ0FETDtHQUREOztFQUtBLFFBQUMsQ0FBQSxNQUFELENBQVEsWUFBUixFQUNDO0lBQUEsR0FBQSxFQUFLLFNBQUE7YUFBRyxJQUFDLENBQUE7SUFBSixDQUFMO0lBQ0EsR0FBQSxFQUFLLFNBQUMsS0FBRDtBQUNKLFVBQUE7TUFBQSxJQUFDLENBQUEsV0FBRCxHQUFlO01BQ2YsSUFBRyx1QkFBSDtRQUNDLFVBQUEsR0FBYSxLQUFLLENBQUMsUUFBTixDQUFlLEtBQWYsRUFBc0IsQ0FBQyxDQUFELEVBQUksQ0FBSixDQUF0QixFQUE4QixDQUFDLElBQUMsQ0FBQSxVQUFGLEVBQWMsQ0FBZCxDQUE5QjtlQUNiLElBQUMsQ0FBQSxLQUFLLENBQUMsZ0JBQVAsR0FBMEIsV0FGM0I7O0lBRkksQ0FETDtHQUREOzs7O0dBckU4Qjs7OztBQ1AvQixPQUFPLENBQUMsS0FBUixHQUFnQjs7QUFFaEIsT0FBTyxDQUFDLFVBQVIsR0FBcUIsU0FBQTtTQUNwQixLQUFBLENBQU0sdUJBQU47QUFEb0I7O0FBR3JCLE9BQU8sQ0FBQyxPQUFSLEdBQWtCLENBQUMsQ0FBRCxFQUFJLENBQUosRUFBTyxDQUFQIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIlwiXCJcIlxuU1ZHTGF5ZXIgY2xhc3NcblxucHJvcGVydGllc1xuLSBsaW5lY2FwIDxzdHJpbmc+IChcInJvdW5kXCIgfHwgXCJzcXVhcmVcIiB8fCBcImJ1dHRcIilcbi0gZmlsbCA8c3RyaW5nPiAoY3NzIGNvbG9yKVxuLSBzdHJva2UgPHN0cmluZz4gKGNzcyBjb2xvcilcbi0gc3Ryb2tlV2lkdGggPG51bWJlcj5cbi0gZGFzaE9mZnNldCA8bnVtYmVyPiAoZnJvbSAtMSB0byAxLCBkZWZhdWx0cyB0byAwKVxuXCJcIlwiXG5cbmNsYXNzIGV4cG9ydHMuU1ZHTGF5ZXIgZXh0ZW5kcyBMYXllclxuXG5cdGNvbnN0cnVjdG9yOiAob3B0aW9ucyA9IHt9KSAtPlxuXHRcdG9wdGlvbnMgPSBfLmRlZmF1bHRzIG9wdGlvbnMsXG5cdFx0XHRkYXNoT2Zmc2V0OiAxXG5cdFx0XHRzdHJva2VXaWR0aDogMlxuXHRcdFx0c3Ryb2tlOiBcIiMyOGFmZmFcIlxuXHRcdFx0YmFja2dyb3VuZENvbG9yOiBudWxsXG5cdFx0XHRjbGlwOiBmYWxzZVxuXHRcdFx0ZmlsbDogXCJ0cmFuc3BhcmVudFwiXG5cdFx0XHRsaW5lY2FwOiBcInJvdW5kXCJcblx0XHRzdXBlciBvcHRpb25zXG5cblx0XHRpZiBvcHRpb25zLmZpbGwgPT0gbnVsbFxuXHRcdFx0QGZpbGwgPSBudWxsXG5cblx0XHRAd2lkdGggKz0gb3B0aW9ucy5zdHJva2VXaWR0aCAvIDJcblx0XHRAaGVpZ2h0ICs9IG9wdGlvbnMuc3Ryb2tlV2lkdGggLyAyXG5cblx0XHQjIEhUTUwgZm9yIHRoZSBTVkcgRE9NIGVsZW1lbnQsIG5lZWQgdW5pcXVlIGNsYXNzIG5hbWVzXG5cdFx0ZCA9IG5ldyBEYXRlKClcblx0XHR0ID0gZC5nZXRUaW1lKClcblx0XHRjTmFtZSA9IFwiY1wiICsgdFxuXHRcdGhlYWRlciA9IFwiPHN2ZyBjbGFzcz0nI3tjTmFtZX0nIHg9JzBweCcgeT0nMHB4JyB3aWR0aD0nI3tAd2lkdGh9JyBoZWlnaHQ9JyN7QGhlaWdodH0nIHZpZXdCb3g9Jy0je0BzdHJva2VXaWR0aC8yfSAtI3tAc3Ryb2tlV2lkdGgvMn0gI3tAd2lkdGggKyBAc3Ryb2tlV2lkdGgvMn0gI3tAaGVpZ2h0ICsgQHN0cm9rZVdpZHRoLzJ9Jz5cIlxuXHRcdHBhdGggPSBvcHRpb25zLnBhdGhcblx0XHRmb290ZXIgPSBcIjwvc3ZnPlwiXG5cdFx0QGh0bWwgPSBoZWFkZXIgKyBwYXRoICsgZm9vdGVyXG5cblx0XHQjIHdhaXQgd2l0aCBxdWVyeWluZyBwYXRobGVuZ3RoIGZvciB3aGVuIGRvbSBpcyBmaW5pc2hlZFxuXHRcdFV0aWxzLmRvbUNvbXBsZXRlID0+XG5cdFx0XHRkb21QYXRoID0gZG9jdW1lbnQucXVlcnlTZWxlY3RvcignLicrY05hbWUrJyBwYXRoJylcblx0XHRcdEBfcGF0aExlbmd0aCA9IGRvbVBhdGguZ2V0VG90YWxMZW5ndGgoKVxuXHRcdFx0QHN0eWxlID0ge1wic3Ryb2tlLWRhc2hhcnJheVwiOkBwYXRoTGVuZ3RoO31cblx0XHRcdEBkYXNoT2Zmc2V0ID0gb3B0aW9ucy5kYXNoT2Zmc2V0XG5cblx0QGRlZmluZSBcInBhdGhMZW5ndGhcIixcblx0XHRnZXQ6IC0+IEBfcGF0aExlbmd0aFxuXHRcdHNldDogKHZhbHVlKSAtPiBwcmludCBcIlNWR0xheWVyLnBhdGhMZW5ndGggaXMgcmVhZG9ubHlcIlxuXG5cdEBkZWZpbmUgXCJsaW5lY2FwXCIsXG5cdFx0Z2V0OiAtPiBAc3R5bGUuc3Ryb2tlTGluZWNhcFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QHN0eWxlLnN0cm9rZUxpbmVjYXAgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJzdHJva2VMaW5lY2FwXCIsXG5cdFx0Z2V0OiAtPiBAc3R5bGUuc3Ryb2tlTGluZWNhcFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QHN0eWxlLnN0cm9rZUxpbmVjYXAgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJmaWxsXCIsXG5cdFx0Z2V0OiAtPiBAc3R5bGUuZmlsbFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0aWYgdmFsdWUgPT0gbnVsbFxuXHRcdFx0XHR2YWx1ZSA9IFwidHJhbnNwYXJlbnRcIlxuXHRcdFx0QHN0eWxlLmZpbGwgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJzdHJva2VcIixcblx0XHRnZXQ6IC0+IEBzdHlsZS5zdHJva2Vcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQHN0eWxlLnN0cm9rZSA9IHZhbHVlXG5cblx0QGRlZmluZSBcInN0cm9rZUNvbG9yXCIsXG5cdFx0Z2V0OiAtPiBAc3R5bGUuc3Ryb2tlXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBzdHlsZS5zdHJva2UgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJzdHJva2VXaWR0aFwiLFxuXHRcdGdldDogLT4gTnVtYmVyKEBzdHlsZS5zdHJva2VXaWR0aC5yZXBsYWNlKC9bXlxcZC4tXS9nLCAnJykpXG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRAc3R5bGUuc3Ryb2tlV2lkdGggPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJkYXNoT2Zmc2V0XCIsXG5cdFx0Z2V0OiAtPiBAX2Rhc2hPZmZzZXRcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBfZGFzaE9mZnNldCA9IHZhbHVlXG5cdFx0XHRpZiBAcGF0aExlbmd0aD9cblx0XHRcdFx0ZGFzaE9mZnNldCA9IFV0aWxzLm1vZHVsYXRlKHZhbHVlLCBbMCwgMV0sIFtAcGF0aExlbmd0aCwgMF0pXG5cdFx0XHRcdEBzdHlsZS5zdHJva2VEYXNob2Zmc2V0ID0gZGFzaE9mZnNldFxuIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
