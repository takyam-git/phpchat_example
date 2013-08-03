<?php
class Api_MessagesController extends BaseController
{
	public function index($offset = 0)
	{
		!is_numeric($offset) and $offset = 0;
		return Response::json(Message::take(20)->skip($offset)->orderBy('created_at', 'desc')->get()->toArray());
	}
}