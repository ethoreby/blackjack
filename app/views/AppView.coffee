class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <span class="playerScore"></span>
    <span class="dealerScore"></span><br/>
    <span class="chips"></span>
    <button class="bet10k">Bet 10,000</button>
    <button class="bet50k">Bet 50,000</button>
    <button class="bet100k">Bet 100,000</button>
    <button class="betAll">All In</button>
    <span class="pot"></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .bet10k": -> @model.bet(10000)
    "click .bet50k": -> @model.bet(50000)
    "click .bet100k": -> @model.bet(100000)
    "click .betAll": -> @model.bet()

  initialize: ->
    @render()
    @model.on 'change', => @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.chips').html 'Chips: ' + @model.attributes.chips
    @$('.pot').html 'Pot: ' + @model.attributes.pot
    @$('.playerScore').html 'Player Score: ' + @model.attributes.playerScore
    @$('.dealerScore').html 'Dealer Score: ' + @model.attributes.dealerScore
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
