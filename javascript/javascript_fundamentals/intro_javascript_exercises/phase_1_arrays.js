Array.prototype.uniq = function() {
  let array = [];

  self.forEach((element) {
    if array.includes(element) {
            return;
    }

    array.push(element);
  })
}
