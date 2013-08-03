<!DOCTYPE html>
<html>
<head>
	<title>Bootstrap 101 Template</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="/assets/css/master.css" rel="stylesheet" media="screen">
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#">PHPCHAT</a>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-12" id="main">
				@yield('content')
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/assets/js/underscore-min.js"></script>
	<script type="text/javascript" src="/assets/js/underscore.string.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="/assets/js/backbone-min.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="http://{{Request::server('HTTP_HOST')}}:3000/socket.io/socket.io.js"></script>
	<script type="text/javascript" src="/assets/js/main.js"></script>
</body>
</html>