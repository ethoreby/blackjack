class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  stand: -> @trigger('stand', @)

  play: (playerScore)->
    @at(0).flip() if !@at(0).attributes.revealed
    console.log @at(0).attributes.revealed
    dealerScore = @currentScore(@scores())
    console.log dealerScore
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
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
