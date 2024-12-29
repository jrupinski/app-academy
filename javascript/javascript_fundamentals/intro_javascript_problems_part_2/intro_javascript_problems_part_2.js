// Phase I: Callbacks
function titleize(arr, callback_fn) {
	var mapped_arr = arr.map(el => `Mx. ${el} Jingleheimer Schmidt`);

	callback_fn(mapped_arr);
};


titleize(["Mary", "Joe", "Mama"], (names) => {
	names.forEach(name => console.log(name));
});

// Phase II: Constructors, Prototypes, and this
// Old school way
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

// New way
class Elephant {
	constructor(name, height, tricks) {
		this.name = name;
		this.height = height;
		this.tricks = tricks;
	}

	trumpet() {
		console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
	}
	grow() {
		this.height += 12;
	}
	addTrick(trick) {
		this.array_of_tricks << trick;
	}
	play() {
		random_trick = Math.floor(Math.random() * this.array_of_tricks.length);
		return this.array_of_tricks[random_trick];
	}
}

// Phase 3
// expected way
//Elephant.paradeHelper = function paradeHelper(elephant) {
//	console.log(`${elephant.name} is trotting by!`);
//}

// my way
function paradeHelper(elephant) {
	console.log(`${elephant.name} is trotting by!`);
}

Elephant.paradeHelper = paradeHelper

//> herd.forEach(paradeHelper);
//Ellie is trotting by!
//Charlie is trotting by!
//Kate is trotting by!
//Micah is trotting by!
//undefined

//> herd.forEach(function(el) {
//... paradeHelper(el);
//... });
//Ellie is trotting by!
//Charlie is trotting by!
//Kate is trotting by!
//Micah is trotting by!
//undefined

//> herd.forEach(elephant => {
//... paradeHelper(elephant);
//... });
//Ellie is trotting by!
//Charlie is trotting by!
//Kate is trotting by!
//Micah is trotting by!
//undefined

//> herd.forEach(el => paradeHelper(el));
//Ellie is trotting by!
//Charlie is trotting by!
//Kate is trotting by!
//Micah is trotting by!
//undefined
