class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if @isDealer is undefined
      currScore = @currentScore(@scores())
      if currScore > 21
        @bust()


  stand: -> @trigger('stand', @)

  play: (playerScore)->
    @at(0).flip() if !@at(0).attributes.revealed
    dealerScore = @currentScore(@scores())
    if dealerScore > 21 then return @bust()
    else if dealerScore < 17
      @hit()
      @play(playerScore)
    else
      @evalScores(dealerScore, playerScore)

  currentScore: (scores) ->
    output = scores[0]
    for score in scores
      output = score if score > output and score < 22
    output

  bust: -> @trigger('bust', @)

  evalScores: (dealerScore, playerScore)->
    if playerScore > dealerScore then @trigger('win', @)
    else if playerScore < dealerScore then @trigger('loss', @)
    else @trigger('tie', @)

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
