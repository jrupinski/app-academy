// phase 1

// mystery scoping


function madLib(w1, w2, w3) {
  console.log(`We shall ${w1.toUpperCase()} the ${w2.toUpperCase()} ${w3.toUpperCase()}.`)
}

function isSubstring(searchString, subString) {
  return searchString.includes(subString);
}

// phase 2

// Fizzbuzz
function fizzBuzz(array) {
  var nums = [];

  array.forEach(function(el) {
    if ((el % 3 === 0 && el % 5 != 0) || (el % 3 != 0 && el % 5 === 0)) {
      nums.push(el);
    }
  })

  return nums;
}

// Is prime
function isPrime(num) {
  if (num <= 2) {
    return true;
  }

  for (i = 2; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }

  return true
}

// Old implementation

// isSubstring
//function isSubstring(searchString, substring) {
//  return searchString.include(substring);
//}

// madLib
//function madLib(word1, word2, word3) {
//  console.log(`We shall ${word1.toUpperCase()} the ${word2.toUpperCase()} ${word3.toUpperCase()}.`);
//}

//function fizzBuzz(array) {
//  let fizz = [];
//
//  array.forEach(function(el) {
//    if (el % 3 == 0 && el % 5 != 0) {
//      fizz.push(el);
//    } else if (el % 5 == 0 && el % 3 != 0) {
//      fizz.push(el);
//    }
//  });
//  return fizz;
//}

//// isPrime
//function isPrime(integer) {
//  for (let i = 1; i > integer; i++) {
//    if integer % i == 0 {
//      return false;
//    }
//  }
//}
//

