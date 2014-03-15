#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # Listen for stand
    @get 'playerHand'
     .on 'stand', =>
      # Get player score
      console.log "stand"
      playerHand = @get 'playerHand'
      dealer = @get 'dealerHand'
      dealer.play(playerHand.scores()[0])

    @get 'playerHand'
      .on 'bust', ->
        console.log('bust');

    @get 'dealerHand'
      .on 'bust', ->
        console.log('dealer busts');

    @get 'dealerHand'
      .on 'win', =>
        console.log('win');

    @get 'dealerHand'
      .on 'loss', =>
        console.log('loss');

    @get 'dealerHand'
      .on 'tie', =>
        console.log('tie');
