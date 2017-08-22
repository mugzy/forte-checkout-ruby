window.logForteCheckoutEvent = (e) ->
  data     = JSON.parse(e.data)
  messages = ['<li><ul>']

  for key, value of data
    messages.push("<li>#{key} : #{value}</li>")
  messages.push('</ul></li>')

  $('#forte-callback-messages').append messages.join('')
