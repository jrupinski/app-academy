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

// Phase II: Constructors, Prototypes, and this
function Elephant(name, height, array_of_tricks) {
	this.name = name;
	this.heigth = height;
	this.array_of_tricks = array_of_tricks;
}

Elephant.prototype.trumpet = function() {
	console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
}
Elephant.prototype.grow = function() {
	this.heigth += 12;
}
Elephant.prototype.addTrick = function(trick) {
	this.array_of_tricks << trick;
}
Elephant.prototype.play = function() {
	random_trick = Math.floor(Math.random() * this.array_of_tricks.length);
	return this.array_of_tricks[random_trick];
}

