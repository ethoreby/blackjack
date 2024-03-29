// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Hand = (function(_super) {
    __extends(Hand, _super);

    function Hand() {
      return Hand.__super__.constructor.apply(this, arguments);
    }

    Hand.prototype.model = Card;

    Hand.prototype.initialize = function(array, deck, isDealer, startGame) {
      this.deck = deck;
      this.isDealer = isDealer;
      this.startGame = startGame != null ? startGame : false;
      return console.log(this);
    };

    Hand.prototype.hit = function() {
      var currScore;
      if (this.startGame === true) {
        this.add(this.deck.pop()).last();
        if (this.isDealer === void 0) {
          currScore = this.currentScore(this.scores());
          if (currScore > 21) {
            return this.bust();
          }
        }
      }
    };

    Hand.prototype.stand = function() {
      if (this.startGame === true) {
        return this.trigger('stand', this);
      }
    };

    Hand.prototype.play = function(playerScore) {
      var dealerScore;
      if (!this.at(0).attributes.revealed) {
        this.at(0).flip();
      }
      dealerScore = this.currentScore(this.scores());
      if (dealerScore > 21) {
        return this.bust();
      } else if (dealerScore < 17) {
        this.hit();
        return this.play(playerScore);
      } else {
        return this.evalScores(dealerScore, playerScore);
      }
    };

    Hand.prototype.currentScore = function(scores) {
      var output, score, _i, _len;
      output = scores[0];
      for (_i = 0, _len = scores.length; _i < _len; _i++) {
        score = scores[_i];
        if (score > output && score < 22) {
          output = score;
        }
      }
      return output;
    };

    Hand.prototype.bust = function() {
      return this.trigger('bust', this);
    };

    Hand.prototype.evalScores = function(dealerScore, playerScore) {
      if (playerScore > dealerScore) {
        return this.trigger('win', this);
      } else if (playerScore < dealerScore) {
        return this.trigger('loss', this);
      } else {
        return this.trigger('tie', this);
      }
    };

    Hand.prototype.scores = function() {
      var hasAce, score;
      hasAce = this.reduce(function(memo, card) {
        return memo || card.get('value') === 1;
      }, false);
      score = this.reduce(function(score, card) {
        return score + (card.get('revealed') ? card.get('value') : 0);
      }, 0);
      if (hasAce) {
        return [score, score + 10];
      } else {
        return [score];
      }
    };

    return Hand;

  })(Backbone.Collection);

}).call(this);

//# sourceMappingURL=Hand.map
