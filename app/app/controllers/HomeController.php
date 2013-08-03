<?php
class HomeController extends BaseController {
	public function index()
	{
		$this->layout->content = View::make('home', array(
			'user_id' => Session::get('user_id'),
		));
	}
}