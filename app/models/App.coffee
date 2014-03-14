#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # Listen for stand
    @get 'playerHand'
     .on 'stand', =>
      dealer = @get 'dealerHand'
      dealer.play()
