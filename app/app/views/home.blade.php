@section('content')
<form class="form-inline" id="form">
	<div class="row">
		<div class="col-10">
			<input type="text" class="form-control" placeholder="{{$user_id}}">
		</div>
		<div class="col-2">
			<button type="submit" class="btn btn-default btn-block">Send</button>
		</div>
	</div>
</form>
<div class="row">
	<div class="col-12" id="container"></div>
</div>
@endsection