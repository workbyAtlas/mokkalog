function myFunction() {
  document.getElementById("nav-bar").style.display = "flex";
  document.getElementById("nav-btn").style.display = "none";
}

function myFF(){
  document.getElementById("nav-bar").style.display= "none";
  document.getElementById("nav-btn").style.display = "block";
}

function hidediv(id){
  document.getElementById(id).style.display= "none";
}
function showdiv(id){
  document.getElementById(id).style.display= "block";

}
function copy(id,id2){
  var url = document.getElementById(id).innerHTML;
  navigator.clipboard.writeText(url);
  document.getElementById(id2).innerHTML = "Copied!";

}