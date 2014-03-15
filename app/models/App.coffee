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
    currChips = @get 'chips'
    raise = raise or currChips
    if currChips - raise >= 0
      @set 'pot', @get('pot') + raise
      @set 'chips', currChips - raise

  gameover: (playerVictory)=>
    if playerVictory is null
      @set 'chips', @get('chips') + @get('pot')
      alert 'tie'
    else if playerVictory is true
      @set 'playerScore', @get('playerScore') + 1
      @set 'chips', @get('chips') + @get('pot') * 2
      alert 'player wins!'
    else
      @set 'dealerScore', @get('dealerScore') + 1
      alert 'player loses!'

    if @get('chips') is 0
      $(".bankrupt").css("display", "block")
    else
      @newGame()
      @setListeners()

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'pot', 0

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

  setBet: =>
    @get('playerHand').at(0).flip()
    @get('playerHand').at(1).flip()
    # debugger;
    player = @get('playerHand')
    player.set 'startGame', true


