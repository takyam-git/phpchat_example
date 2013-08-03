#underscore.string をmix-in
_.mixin(_.str.exports())

#Websocketの接続を開始
socket = io.connect("http://#{location.host}:3000/")

#チャットの発言のモデル
class MessageModel extends Backbone.Model
  urlRoot: '/api/message'
  defaults:
    id: null
    user_id: ''
    message: ''
    top: false
    created_at: null
    updated_at: null

#チャットの発言のコレクション
class MessagesCollection extends Backbone.Collection
  url: => "/api/messages/#{@length}"
  model: MessageModel

#チャットの発言ひとつひとつのView
class MessageView extends Backbone.View
  el: '<div class="row"></div>'
  model: null
  template: _.template '''
    <div class="col-2"><%= model.get('user_id') %></div>
    <div class="col-10"><p><%= model.get('message') %></p></div>
  '''
  initialize: =>
    @render()
  render: =>
    @$el.html(@template(model: @model))

#基本となるView
class ChatView extends Backbone.View
  el: '#main'
  events:
    'submit #form': 'sendMessage'

  #collection
  collection: null

  #DOM
  $container: null
  $form: null
  $input: null

  initialize: =>
    #set DOMs
    @$container = $('#container')
    @$form = $('#form')
    @$input = @$form.find('input')

    #コレクションの初期化
    @collection = new MessagesCollection()
    @collection.on('add', @renderMessage)
    @fetchMessages()

    #Websocket経由でメッセージ受信時のリスナーを追加
    socket.on 'message', @recievedMessage

  #メッセージを取得する
  fetchMessages: =>
    @collection.fetch
      update: true
      add: true
      remove: false

  #メッセージを描画する
  renderMessage: (messageModel)=>
    messageView = new MessageView(model: messageModel)
    method = if messageModel.get('top') then 'prepend' else 'append'
    @$container[method](messageView.$el)

  #入力メッセージを返す
  getInputMessage: =>
    return @$input.val()

  #入力をクリアする
  clearInputMessage: =>
    @$input.val('')
    return @

  #新しいメッセージモデルを返す
  getNewMessageModel: (message, id = null, user_id = null, top = false)=>
    return new MessageModel(id: id, message: message, user_id: user_id, top: top)

  #チャットメッセージを送信する
  sendMessage: =>
    #送信メッセージを取得
    message = _.trim(@getInputMessage())

    #未入力なら何もしない
    return false if message.length is 0

    #メッセージモデルを作成する
    model = @getNewMessageModel(message, null, null, true)

    #メッセージを削除する
    @clearInputMessage()

    #メッセージモデルをAPIリクエスト出して保存する
    model.save {},
      success: =>
        @collection.set(model)
    return false

  #Websocket経由でメッセージを受信した場合の処理
  recievedMessage: (messageData)=>
    @collection.set(@getNewMessageModel(messageData.message, messageData.id, messageData.user_id, true))

#実行
$ => new ChatView()