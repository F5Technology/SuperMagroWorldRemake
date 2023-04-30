/// @description Exibição dos dados do jogo na HUD

function exibirHUD() {
	exibirVidas();
	exibirPontuacao();
	
	if(room != rmChefe) {
		exibirFaseAtual();
		exibirTempo();
		exibirMoedas();
	}
}

function exibirVidas(){
	var vertical = 130;
	var horizontal = 130;
	var numeroVidas = "x" + string(global.propriedadesJogo.vidas);
	
	draw_sprite_ext(sprRosto, 0, 20, 20, 4.5, 4.5, 0, c_white, 1);
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(horizontal, vertical, numeroVidas, c_black, 4);
	
	draw_set_color(c_white);
	draw_text(horizontal, vertical, numeroVidas);
}

function exibirPontuacao() {
	var pontuacao = "pontos =  " + string(global.propriedadesJogo.pontos);
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(180, 20, pontuacao, #000070, 4);
	
	draw_set_color(c_white);	
	draw_text(180, 20, pontuacao);
}
	
function exibirFaseAtual() {
	var vertical = 20;
	var horizontal = 490;
	var texto = "area";
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(horizontal, vertical, texto, #000070, 4);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
	
	var fase = string(global.propriedadesJogo.fase);
	var mundo = string(global.propriedadesJogo.mundo);
	
	vertical = 50;
	horizontal = 505;
	texto =  mundo + "- " + fase;
	
	inserirContornoTexto(horizontal, vertical, texto, #000070, 4);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
}

function exibirTempo() {
	var vertical = 20;
	var horizontal = 600;
	var texto = "tempo";
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(horizontal, vertical, texto, #050914, 4);
	
	draw_set_color(#d41e3c);	
	draw_text(horizontal, vertical, texto);
	
	vertical = 50;
	horizontal = 630;
	texto =  string(global.propriedadesJogo.tempo);
	
	inserirContornoTexto(horizontal, vertical, texto, #050914, 4);
	
	draw_set_color(#d41e3c);
	draw_text(horizontal, vertical, texto);
}

function exibirMoedas() {	
	var vertical = 60;
	var horizontal = 820;
	var moedas = " = " + string(global.propriedadesJogo.moedas);
	
	draw_sprite_ext(sprMoedaHUD, 0, 720, 20, 7, 7, 0, c_white, 1);
	
	draw_set_font(fntMoedaHUD);
	
	inserirContornoTexto(horizontal, vertical, moedas, c_black, 4);
	
	draw_set_color(c_white);
	draw_text(horizontal, vertical, moedas);
}
	
function exibirInfoTransicao() {
	exibirTransicaoFase();
	exibirTransicaoVidas();
}

function exibirTransicaoFase() {
	var vertical = y;
	var horizontal = x;
	var texto = "area";
	
	draw_set_font(fntTransicao);
	
	inserirContornoTexto(horizontal, vertical, texto, #000070, 6);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
	
	var fase = string(global.propriedadesJogo.fase);
	var mundo = string(global.propriedadesJogo.mundo);
	
	vertical += 70;
	horizontal += 40;
	texto =  mundo + " - " + fase;
	
	inserirContornoTexto(horizontal, vertical, texto, #000070, 6);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
}

function exibirTransicaoVidas() {
	var escalaIcone = 10;
	var vertical = y + 230;
	var horizontal = x - 100;
	var numeroVidas = "x" + string(global.propriedadesJogo.vidas);
	
	draw_sprite_ext(sprRosto, 0, horizontal, vertical, escalaIcone, escalaIcone, 0, c_white, 1);
	
	draw_set_font(fntTransicao);
	
	vertical += 230;
	horizontal += 260;
	inserirContornoTexto(horizontal, vertical, numeroVidas, #000070, 6);
	
	draw_set_color(c_white);
	draw_text(horizontal, vertical, numeroVidas);
}

function inserirContornoTexto(horizontal, vertical, texto, cor, espessura) {	
	draw_set_color(cor);  
	draw_text(horizontal+espessura, vertical+espessura, texto);  
	draw_text(horizontal-espessura, vertical-espessura, texto);  
	draw_text(horizontal,			vertical+espessura, texto);  
	draw_text(horizontal+espessura, vertical,			  texto);  
	draw_text(horizontal,			vertical-espessura, texto);  
	draw_text(horizontal-espessura, vertical,			  texto);  
	draw_text(horizontal-espessura, vertical+espessura, texto);  
	draw_text(horizontal+espessura, vertical-espessura, texto); 
}