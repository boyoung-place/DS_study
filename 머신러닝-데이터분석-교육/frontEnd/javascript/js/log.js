function log(msg){
    var debug = document.getElementById("debugConsole")

    if(debug !=null){
        debug.innerHTML += msg + "<br>";
    }
}