<?php
class Message extends Eloquent
{
	protected $table = 'messages';
	protected $guarded = array('id');
	protected $rules = array(
		'message' => 'required',
	);

	public $errors = null;

	/**
	 * バリデーションを実施して結果を返す
	 * エラーがある場合 $this->errors にエラーを格納
	 * @param array $data
	 * @return bool
	 */
	public function validate(array $data)
	{
		$validator = Validator::make($data, $this->rules);
		if($validator->fails()){
			$this->errors = $validator->errors;
			return false;
		}

		return true;
	}
}