function abrirMenu() {
    navbar.style.visibility = "visible";
    navbar.style.opacity = 1;
}

function fecharMenu() {
    navbar.style.visibility = "hidden";
    navbar.style.opacity = 1;
}

function voltarIndex(){
    window.location = "index.html";
}

window.addEventListener('resize', (event) => {
    if(window.innerWidth > 997){
        abrirMenu();
    }
    else{
        fecharMenu();
    }
});
