(function() {
  "use strict";
  function increment_value() {
    var number_value = parseInt(document.getElementById('number').innerHTML);
    var incremented_value = number_value + 1;
    document.getElementById('number').innerHTML = incremented_value;
  }
  var button_id = document.getElementById('increment-button');
  button_id.addEventListener("click",increment_value);
})();
(function() {
  "use strict";
  function show_alert() {
    var number_value = document.getElementById('number').innerHTML;
    alert(number_value);
  }
  var button_id = document.getElementById('alert-button');
  button_id.addEventListener("click",show_alert)
})();
(function() {
  function append() {
    var number_value = document.getElementById('number').innerHTML;
    var new_heading = document.createElement('p');
    new_heading.innerHTML = number_value;
    var boundry_element = document.getElementById('footer');
    boundry_element.appendChild(new_heading);
  }
  var button_id = document.getElementById('append-button');
  button_id.addEventListener("click",append)
})();
