<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Web Socket Demo</title>
<script type="text/javascript" src="resources/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="resources/sockjs-0.3.js"></script>
<script type="text/javascript" src="resources/stomp.js"></script>
</head>
<body>
	<h4>Stock Price</h4>
	<table>
		<thead>
			<tr>
				<th>Code</th>
				<th>Price</th>
				<th>Time</th>
			</tr>
		</thead>
		<tbody id="price"></tbody>
	</table>
	<p class="new">
		Code: <input type="text" class="code" /> Price: <input type="text"
			class="price" />
		<button class="add">Add</button>
		<button class="remove-all">Remove All</button>
	</p>
	<script>
		var socket = new SockJS("/websocketdemo/ws");
		var stompClient = Stomp.over(socket);
		// Callback function to be called when stomp client is connected to server
		var connectCallback = function() {
			stompClient.subscribe('/topic/price', renderPrice);
		};

		// Callback function to be called when stomp client could not connect to server
		var errorCallback = function(error) {
			alert(error.headers.message);
		};

		// Connect to server via websocket
		stompClient.connect("guest", "guest", connectCallback, errorCallback);

		function renderPrice(frame) {
			var prices = JSON.parse(frame.body);
			$('#price').empty();
			for ( var i in prices) {
				var price = prices[i];
				$('#price').append(
						$('<tr>').append($('<td>').html(price.code),
								$('<td>').html(price.price.toFixed(2)),
								$('<td>').html(price.timeStr)));
			}
		}

		$(document).ready(function() {
			$('.add').click(function(e) {
				e.preventDefault();
				var code = $('.new .code').val();
				var price = Number($('.new .price').val());
				var jsonstr = JSON.stringify({
					'code' : code,
					'price' : price
				});
				stompClient.send("/app/addStock", {}, jsonstr);
				return false;
			});
		});

		// Register handler for remove all button
		$(document).ready(function() {
			$('.remove-all').click(function(e) {
				e.preventDefault();
				stompClient.send("/app/removeAllStocks");
				return false;
			});
		});
	</script>
</body>
</html>