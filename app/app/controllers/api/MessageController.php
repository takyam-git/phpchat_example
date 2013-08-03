<?php
class Api_MessageController extends BaseController
{
	protected $message = null;

	public function __construct(Message $message)
	{
		$this->message = $message;
	}

	public function store()
	{
		$inputs = Input::only(array('message'));
		if($this->message->validate($inputs)){
			$inputs['user_id'] = Session::get('user_id');
			$message = Message::create($inputs);

			$redis = Redis::connection();
			$redis->publish('chat', $message->toJson());

			return Response::json($message->toArray());
		}else{
			return Response::json($this->message->errors);
		}

	}
}