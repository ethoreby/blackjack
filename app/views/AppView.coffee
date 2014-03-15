class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <span class="playerScore"></span> <span class="dealerScore"></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()

    @model.on 'change', => @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.playerScore').html 'Player Score: ' + @model.attributes.playerScore
    @$('.dealerScore').html 'Dealer Score: ' + @model.attributes.dealerScore
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
