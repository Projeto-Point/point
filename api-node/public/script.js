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

/*Dropdown Menu*/
$('.dropdown').click(function () {
    $(this).attr('tabindex', 1).focus();
    $(this).toggleClass('active');
    $(this).find('.dropdown-menu').slideToggle(300);
});
$('.dropdown').focusout(function () {
    $(this).removeClass('active');
    $(this).find('.dropdown-menu').slideUp(300);
});
$('.dropdown .dropdown-menu li').click(function () {
    $(this).parents('.dropdown').find('span').text($(this).text());
    $(this).parents('.dropdown').find('input').attr('value', $(this).attr('id'));
});

import variables from './dashboard/css/styleDash.scss';
module.exports = {
    // ...
    module: {
     rules: [
      {
       test: /\.scss$/,
       use: ["style-loader", "css-loader", "sass-loader"]
      },
      // ...
     ]
    }
   };

document.getElementById("app").style.padding = variables.padding;
