require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"SpeechSynth":[function(require,module,exports){
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.SpeechSynth = (function(superClass) {
  extend(SpeechSynth, superClass);

  function SpeechSynth(options) {
    var option;
    if (options == null) {
      options = {};
    }
    this._utterance = new SpeechSynthesisUtterance();
    this._voices = window.speechSynthesis.getVoices();
    if (options.voice) {
      options.voice = this._voices.filter(function(voice) {
        return voice.name === ("" + options.voice);
      })[0];
    }
    for (option in options) {
      this._utterance["" + option] = options["" + option];
    }
  }

  SpeechSynth.prototype.speak = function() {
    return window.speechSynthesis.speak(this._utterance);
  };

  SpeechSynth.prototype.cancel = function() {
    return window.speechSynthesis.cancel(this._utterance);
  };

  SpeechSynth.prototype.pause = function() {
    return window.speechSynthesis.pause(this._utterance);
  };

  SpeechSynth.prototype.resume = function() {
    return window.speechSynthesis.resume(this._utterance);
  };

  SpeechSynth.define("voices", {
    get: function() {
      var i, len, ref, voice, voices;
      voices = [];
      ref = this._voices;
      for (i = 0, len = ref.length; i < len; i++) {
        voice = ref[i];
        voices[_.indexOf(this._voices, voice)] = voice.name;
      }
      return voices;
    }
  });

  SpeechSynth.define("isPending", {
    get: function() {
      return window.speechSynthesis.pending;
    }
  });

  SpeechSynth.define("isSpeaking", {
    get: function() {
      return window.speechSynthesis.speaking;
    }
  });

  SpeechSynth.define("isPaused", {
    get: function() {
      return window.speechSynthesis.paused;
    }
  });

  SpeechSynth.define("text", {
    get: function() {
      return this._utterance.text;
    },
    set: function(value) {
      return this._utterance.text = value;
    }
  });

  SpeechSynth.define("lang", {
    get: function() {
      return this._utterance.lang;
    },
    set: function(value) {
      return this._utterance.lang = value;
    }
  });

  SpeechSynth.define("volume", {
    get: function() {
      return this._utterance.volume;
    },
    set: function(value) {
      return this._utterance.volume = value;
    }
  });

  SpeechSynth.define("rate", {
    get: function() {
      return this._utterance.rate;
    },
    set: function(value) {
      return this._utterance.rate = value;
    }
  });

  SpeechSynth.define("pitch", {
    get: function() {
      return this._utterance.pitch;
    },
    set: function(value) {
      return this._utterance.pitch = value;
    }
  });

  return SpeechSynth;

})(Framer.BaseClass);


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvVEovR29vZ2xlIERyaXZlL19EZXNpZ24vX0ZyYW1lci9wbGF5Z3JvdW5kLzY2c3BlZWNoLmZyYW1lci9tb2R1bGVzL1NwZWVjaFN5bnRoLmNvZmZlZSIsIi9Vc2Vycy9USi9Hb29nbGUgRHJpdmUvX0Rlc2lnbi9fRnJhbWVyL3BsYXlncm91bmQvNjZzcGVlY2guZnJhbWVyL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsSUFBQTs7O0FBQU0sT0FBTyxDQUFDOzs7RUFDQSxxQkFBQyxPQUFEO0FBQ1osUUFBQTs7TUFEYSxVQUFROztJQUNyQixJQUFDLENBQUEsVUFBRCxHQUFrQixJQUFBLHdCQUFBLENBQUE7SUFDbEIsSUFBQyxDQUFBLE9BQUQsR0FBVyxNQUFNLENBQUMsZUFBZSxDQUFDLFNBQXZCLENBQUE7SUFFWCxJQUFHLE9BQU8sQ0FBQyxLQUFYO01BQ0MsT0FBTyxDQUFDLEtBQVIsR0FBZ0IsSUFBQyxDQUFBLE9BQU8sQ0FBQyxNQUFULENBQWdCLFNBQUMsS0FBRDtlQUFXLEtBQUssQ0FBQyxJQUFOLEtBQWMsQ0FBQSxFQUFBLEdBQUcsT0FBTyxDQUFDLEtBQVg7TUFBekIsQ0FBaEIsQ0FBNkQsQ0FBQSxDQUFBLEVBRDlFOztBQUdBLFNBQUEsaUJBQUE7TUFDQyxJQUFDLENBQUEsVUFBVyxDQUFBLEVBQUEsR0FBRyxNQUFILENBQVosR0FBMkIsT0FBUSxDQUFBLEVBQUEsR0FBRyxNQUFIO0FBRHBDO0VBUFk7O3dCQVViLEtBQUEsR0FBTyxTQUFBO1dBQ04sTUFBTSxDQUFDLGVBQWUsQ0FBQyxLQUF2QixDQUE2QixJQUFDLENBQUEsVUFBOUI7RUFETTs7d0JBR1AsTUFBQSxHQUFRLFNBQUE7V0FDUCxNQUFNLENBQUMsZUFBZSxDQUFDLE1BQXZCLENBQThCLElBQUMsQ0FBQSxVQUEvQjtFQURPOzt3QkFHUixLQUFBLEdBQU8sU0FBQTtXQUNOLE1BQU0sQ0FBQyxlQUFlLENBQUMsS0FBdkIsQ0FBNkIsSUFBQyxDQUFBLFVBQTlCO0VBRE07O3dCQUdQLE1BQUEsR0FBUSxTQUFBO1dBQ1AsTUFBTSxDQUFDLGVBQWUsQ0FBQyxNQUF2QixDQUE4QixJQUFDLENBQUEsVUFBL0I7RUFETzs7RUFHUixXQUFDLENBQUEsTUFBRCxDQUFRLFFBQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO0FBQ0osVUFBQTtNQUFBLE1BQUEsR0FBUztBQUVUO0FBQUEsV0FBQSxxQ0FBQTs7UUFDQyxNQUFPLENBQUEsQ0FBQyxDQUFDLE9BQUYsQ0FBVSxJQUFDLENBQUEsT0FBWCxFQUFvQixLQUFwQixDQUFBLENBQVAsR0FBcUMsS0FBSyxDQUFDO0FBRDVDO0FBR0EsYUFBTztJQU5ILENBQUw7R0FERDs7RUFTQSxXQUFDLENBQUEsTUFBRCxDQUFRLFdBQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsTUFBTSxDQUFDLGVBQWUsQ0FBQztJQUExQixDQUFMO0dBREQ7O0VBRUEsV0FBQyxDQUFBLE1BQUQsQ0FBUSxZQUFSLEVBQ0M7SUFBQSxHQUFBLEVBQUssU0FBQTthQUFHLE1BQU0sQ0FBQyxlQUFlLENBQUM7SUFBMUIsQ0FBTDtHQUREOztFQUVBLFdBQUMsQ0FBQSxNQUFELENBQVEsVUFBUixFQUNDO0lBQUEsR0FBQSxFQUFLLFNBQUE7YUFBRyxNQUFNLENBQUMsZUFBZSxDQUFDO0lBQTFCLENBQUw7R0FERDs7RUFFQSxXQUFDLENBQUEsTUFBRCxDQUFRLE1BQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBLFVBQVUsQ0FBQztJQUFmLENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQVcsSUFBQyxDQUFBLFVBQVUsQ0FBQyxJQUFaLEdBQW1CO0lBQTlCLENBREw7R0FERDs7RUFHQSxXQUFDLENBQUEsTUFBRCxDQUFRLE1BQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBLFVBQVUsQ0FBQztJQUFmLENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQVcsSUFBQyxDQUFBLFVBQVUsQ0FBQyxJQUFaLEdBQW1CO0lBQTlCLENBREw7R0FERDs7RUFHQSxXQUFDLENBQUEsTUFBRCxDQUFRLFFBQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBLFVBQVUsQ0FBQztJQUFmLENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQVcsSUFBQyxDQUFBLFVBQVUsQ0FBQyxNQUFaLEdBQXFCO0lBQWhDLENBREw7R0FERDs7RUFHQSxXQUFDLENBQUEsTUFBRCxDQUFRLE1BQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBLFVBQVUsQ0FBQztJQUFmLENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQVcsSUFBQyxDQUFBLFVBQVUsQ0FBQyxJQUFaLEdBQW1CO0lBQTlCLENBREw7R0FERDs7RUFHQSxXQUFDLENBQUEsTUFBRCxDQUFRLE9BQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO2FBQUcsSUFBQyxDQUFBLFVBQVUsQ0FBQztJQUFmLENBQUw7SUFDQSxHQUFBLEVBQUssU0FBQyxLQUFEO2FBQVcsSUFBQyxDQUFBLFVBQVUsQ0FBQyxLQUFaLEdBQW9CO0lBQS9CLENBREw7R0FERDs7OztHQWxEaUMsTUFBTSxDQUFDOzs7O0FDSXpDLE9BQU8sQ0FBQyxLQUFSLEdBQWdCOztBQUVoQixPQUFPLENBQUMsVUFBUixHQUFxQixTQUFBO1NBQ3BCLEtBQUEsQ0FBTSx1QkFBTjtBQURvQjs7QUFHckIsT0FBTyxDQUFDLE9BQVIsR0FBa0IsQ0FBQyxDQUFELEVBQUksQ0FBSixFQUFPLENBQVAiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiY2xhc3MgZXhwb3J0cy5TcGVlY2hTeW50aCBleHRlbmRzIEZyYW1lci5CYXNlQ2xhc3Ncblx0Y29uc3RydWN0b3I6IChvcHRpb25zPXt9KSAtPlxuXHRcdEBfdXR0ZXJhbmNlID0gbmV3IFNwZWVjaFN5bnRoZXNpc1V0dGVyYW5jZSgpXG5cdFx0QF92b2ljZXMgPSB3aW5kb3cuc3BlZWNoU3ludGhlc2lzLmdldFZvaWNlcygpXG5cblx0XHRpZiBvcHRpb25zLnZvaWNlXG5cdFx0XHRvcHRpb25zLnZvaWNlID0gQF92b2ljZXMuZmlsdGVyKCh2b2ljZSkgLT4gdm9pY2UubmFtZSA9PSBcIiN7b3B0aW9ucy52b2ljZX1cIilbMF1cblxuXHRcdGZvciBvcHRpb24gb2Ygb3B0aW9uc1xuXHRcdFx0QF91dHRlcmFuY2VbXCIje29wdGlvbn1cIl0gPSBvcHRpb25zW1wiI3tvcHRpb259XCJdXG5cblx0c3BlYWs6IC0+XG5cdFx0d2luZG93LnNwZWVjaFN5bnRoZXNpcy5zcGVhayhAX3V0dGVyYW5jZSlcblxuXHRjYW5jZWw6IC0+XG5cdFx0d2luZG93LnNwZWVjaFN5bnRoZXNpcy5jYW5jZWwoQF91dHRlcmFuY2UpXG5cblx0cGF1c2U6IC0+XG5cdFx0d2luZG93LnNwZWVjaFN5bnRoZXNpcy5wYXVzZShAX3V0dGVyYW5jZSlcblxuXHRyZXN1bWU6IC0+XG5cdFx0d2luZG93LnNwZWVjaFN5bnRoZXNpcy5yZXN1bWUoQF91dHRlcmFuY2UpXG5cblx0QGRlZmluZSBcInZvaWNlc1wiLFxuXHRcdGdldDogLT4gXG5cdFx0XHR2b2ljZXMgPSBbXVxuXHRcdFx0XG5cdFx0XHRmb3Igdm9pY2UgaW4gQF92b2ljZXNcblx0XHRcdFx0dm9pY2VzW18uaW5kZXhPZihAX3ZvaWNlcywgdm9pY2UpXSA9IHZvaWNlLm5hbWUgXG5cblx0XHRcdHJldHVybiB2b2ljZXNcblxuXHRAZGVmaW5lIFwiaXNQZW5kaW5nXCIsXG5cdFx0Z2V0OiAtPiB3aW5kb3cuc3BlZWNoU3ludGhlc2lzLnBlbmRpbmdcblx0QGRlZmluZSBcImlzU3BlYWtpbmdcIixcblx0XHRnZXQ6IC0+IHdpbmRvdy5zcGVlY2hTeW50aGVzaXMuc3BlYWtpbmdcblx0QGRlZmluZSBcImlzUGF1c2VkXCIsIFxuXHRcdGdldDogLT4gd2luZG93LnNwZWVjaFN5bnRoZXNpcy5wYXVzZWRcblx0QGRlZmluZSBcInRleHRcIixcblx0XHRnZXQ6IC0+IEBfdXR0ZXJhbmNlLnRleHRcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQF91dHRlcmFuY2UudGV4dCA9IHZhbHVlXG5cdEBkZWZpbmUgXCJsYW5nXCIsXG5cdFx0Z2V0OiAtPiBAX3V0dGVyYW5jZS5sYW5nXG5cdFx0c2V0OiAodmFsdWUpIC0+IEBfdXR0ZXJhbmNlLmxhbmcgPSB2YWx1ZVxuXHRAZGVmaW5lIFwidm9sdW1lXCIsXG5cdFx0Z2V0OiAtPiBAX3V0dGVyYW5jZS52b2x1bWVcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQF91dHRlcmFuY2Uudm9sdW1lID0gdmFsdWVcblx0QGRlZmluZSBcInJhdGVcIixcblx0XHRnZXQ6IC0+IEBfdXR0ZXJhbmNlLnJhdGVcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQF91dHRlcmFuY2UucmF0ZSA9IHZhbHVlXG5cdEBkZWZpbmUgXCJwaXRjaFwiLFxuXHRcdGdldDogLT4gQF91dHRlcmFuY2UucGl0Y2hcblx0XHRzZXQ6ICh2YWx1ZSkgLT4gQF91dHRlcmFuY2UucGl0Y2ggPSB2YWx1ZVxuIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
