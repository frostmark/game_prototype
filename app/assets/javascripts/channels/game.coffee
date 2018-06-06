App.web_notifications = App.cable.subscriptions.create "GameChannel",
  connected: ->

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
