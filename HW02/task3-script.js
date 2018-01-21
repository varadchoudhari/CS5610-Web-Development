(function() {
  function showhide(buttonid) {
    if(buttonid == "lorem-button") {
      document.getElementById("lorem").style.display = "block";
      document.getElementById("bottles").style.display = "none";
      document.getElementById("last").style.display = "none";
    }
    if(buttonid == "bottles-button") {
      document.getElementById("lorem").style.display = "none";
      document.getElementById("bottles").style.display = "block";
      document.getElementById("last").style.display = "none";
    }
    if(buttonid == "last-button") {
      document.getElementById("lorem").style.display = "none";
      document.getElementById("bottles").style.display = "none";
      document.getElementById("last").style.display = "block";
    }
  }
  var btn1 = document.getElementById("lorem-button");
  btn1.addEventListener("click", function() {
    showhide(this.id);
  });
  var btn2 = document.getElementById("bottles-button");
  btn2.addEventListener("click", function() {
    showhide(this.id);
  });
  var btn3 = document.getElementById("last-button");
  btn3.addEventListener("click", function() {
    showhide(this.id);
  });
})();
