function getAjax(command){
  var xmlhttp;

  if(window.XMLHttpRequest){
    xmlhttp = new XMLHttpRequest();
  }

  xmlhttp.onreadystatechange = function(){
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
      setVolume( JSON.parse(xmlhttp.responseText) );
    }
  };

  xmlhttp.open("GET", "/" + command, true);
  xmlhttp.send();
}

function setVolume(data){
  if (data.state == "off"){
      document.getElementById('mute').innerHTML = '&#128263;';
  }else{
    var volume = parseInt(data.number);
    switch (true){
    case volume === 0:
      document.getElementById('mute').innerHTML = '&#128264;';
      break;
    case volume > 0 && volume < 50:
      document.getElementById('mute').innerHTML = '&#128265;';
      break;
    case volume > 50:
      document.getElementById('mute').innerHTML = '&#128266;';
    }
  }
  document.getElementById('volume').innerHTML = data.number;
}

function up(){
  getAjax("volup");
  return false;
}

function down(){
  getAjax("voldown");
  return false;
}

function mute(){
  getAjax("mute");
  return false;
}

window.setInterval(function(){
  getAjax("vol");
}, 500);

document.getElementById("up").addEventListener("click", up);
document.getElementById("down").addEventListener("click", down);
document.getElementById("mute").addEventListener("click", mute);
