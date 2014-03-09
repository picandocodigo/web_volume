function loadXMLDoc(command){
  var xmlhttp;

  if(window.XMLHttpRequest){
    xmlhttp = new XMLHttpRequest();
  }

  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
      setVolume( JSON.parse(xmlhttp.responseText) );
    }
  }

  xmlhttp.open("GET", "/" + command, true);
  xmlhttp.send();
}

function setVolume(data){
  document.getElementById("volume").innerHTML = data.number;
  document.getElementById("state").innerHTML = (data.state == "off") ? "muted" : "unmuted";
}

document.getElementById("up").addEventListener("click", up);
document.getElementById("down").addEventListener("click", down);
document.getElementById("mute").addEventListener("click", mute);

function up(){
  loadXMLDoc("volup");
  return false;
}

function down(){
  loadXMLDoc("voldown");
  return false;
}

function mute(){
  loadXMLDoc("mute");
  return false;
}

window.setInterval(function(){
  loadXMLDoc("vol");
}, 500);
