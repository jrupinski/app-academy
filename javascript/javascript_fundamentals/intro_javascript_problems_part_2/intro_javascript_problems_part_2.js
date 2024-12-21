// Phase I: Callbacks
function titleize(arr, callback_fn) {
	var mapped_arr = arr.map(function(el) {
		return `Mx. ${el} Jingleheimer Schmidt`;
	});

	callback_fn(mapped_arr);
}

function printCallback(arr) {
	arr.forEach(function(el) {
		console.log(el);
	})
}
