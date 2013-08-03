config = require('config')
http = require('http')
io = require('socket.io').listen(3000)
cookie = require('cookie')
querystring = require('querystring')
redis = require('redis')

#キーにPHP側のユーザIDを、バリューにsocket持つオブジェクト
sockets = {}

#Redisのchatチャンネルをsubscribeする
pubsub = redis.createClient()
pubsub.subscribe('chat')
pubsub.on 'message', (channel, message)=>
  for user_id, socket of sockets
    socket.emit('message', JSON.parse(message))

#ユーザーからのWebsocketの接続を受けたらCookieを元にPHP側のユーザーIDを取得する
io.sockets.on 'connection', (socket)->
  return false unless socket?.handshake?.headers?.cookie?

  #Cookieをhandshakeから取得
  session_cookie = cookie.parse(socket.handshake.headers.cookie)[config.APP.cookie.session_key]

  #Cookieをquerystringに変換
  cookie_object = {}
  cookie_object[config.APP.cookie.session_key] = session_cookie
  request_cookie = querystring.stringify(cookie_object)

  #PHP側にユーザーIDをリクエスト
  api_response = ''
  req = http.request {
    host:    config.APP.api.host
    port:    config.APP.api.port
    path:    config.APP.api.path
    method:  'get'
    headers: {'Cookie': request_cookie}
  }, (res)=>
    res.setEncoding('utf-8')
    res.on('data', (chunk)=> api_response += chunk)
    res.on 'end', =>
      #PHPからのレスポンスJSONをパースしてユーザーIDを取得してsocketと関連付ける
      try
        json = JSON.parse(api_response)
      catch error
        console.log 'PHP RESPONSE JSON PARSE ERROR : ', error

      sockets[json.user_id] = socket if json?.user_id?
  req.end()