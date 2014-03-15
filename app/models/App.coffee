#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', 0
    @set 'dealerScore', 0
    @set 'chips', 1000000
    @set 'pot', 0

    @setListeners()

  bet: (raise) =>
    @set 'pot', @get('pot') + raise
    @set 'chips', @get('chips') - raise

  gameover: (playerVictory)=>
    if playerVictory is null
      alert 'tie'
    else if playerVictory is true
      @set 'playerScore', @get('playerScore') + 1
      alert 'player wins!'
    else
      @set 'dealerScore', @get('dealerScore') + 1
      alert 'player loses!'
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @setListeners()

  setListeners: () ->
    @get 'playerHand'
     .on 'stand', =>
      # Get player score
      playerHand = @get 'playerHand'
      dealer = @get 'dealerHand'
      dealer.play(playerHand.scores()[0])

    @get 'playerHand'
      .on 'bust', =>
        @gameover(false)

    @get 'dealerHand'
      .on 'bust', =>
        @gameover(true)

    @get 'dealerHand'
      .on 'win', =>
        @gameover(true)

    @get 'dealerHand'
      .on 'loss', =>
        @gameover(false)

    @get 'dealerHand'
      .on 'tie', =>
        @gameover(null)

