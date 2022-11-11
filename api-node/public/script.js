function abrirMenu() {
    navbar.style.visibility = "visible";
    navbar.style.opacity = 1;
}

function fecharMenu(aba) {

    if(aba == 'contato'){

        if(window.innerWidth < 997){
            navbar.style.visibility = "hidden";
            navbar.style.opacity = 0;
        }

    }
    
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
