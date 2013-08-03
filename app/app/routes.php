<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/
Route::filter('user', function(){
	is_null(Session::get('user_id', null)) and  Session::put('user_id', uniqid('user_id_'));
});
Route::when('*', 'user');

Route::get('/', 'HomeController@index');
Route::get('/api/node/session', 'Api_Node_SessionController@session');
Route::get('/api/messages/{offset?}', 'Api_MessagesController@index');
Route::resource('/api/message', 'Api_MessageController', array('only' => array('store')));