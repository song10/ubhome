$ ->
    socket = io.connect 'http://song10.mooo.com:8080/'
    socket.on 'distribute', (data) ->
        $('#results').append('<div>' + data.message + '</div>')

    $('#chatter').on 'submit', (e) ->
        e.preventDefault & e.preventDefault()
        message = $('#message').val()
        socket.emit 'send', {'message': message}
        $('#results').append('<div>' + message + '</div>')
