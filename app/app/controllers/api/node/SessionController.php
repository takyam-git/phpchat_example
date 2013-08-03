<?php
class Api_Node_SessionController extends BaseController
{
	public function session()
	{
		return Response::json(array('user_id' => Session::get('user_id')));
	}
}