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
	
	inserirContornoTexto(horizontal, vertical, numeroVidas, c_black);
	
	draw_set_color(c_white);
	draw_text(horizontal, vertical, numeroVidas);
}

function exibirPontuacao() {
	var pontuacao = "pontos =  " + string(global.propriedadesJogo.pontos);
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(180, 20, pontuacao, #000070);
	
	draw_set_color(c_white);	
	draw_text(180, 20, pontuacao);
}
	
function exibirFaseAtual() {
	var vertical = 20;
	var horizontal = 490;
	var texto = "area";
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(horizontal, vertical, texto, #000070);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
	
	var fase = string(global.propriedadesJogo.fase);
	var mundo = string(global.propriedadesJogo.mundo);
	
	vertical = 50;
	horizontal = 505;
	texto =  mundo + "- " + fase;
	
	inserirContornoTexto(horizontal, vertical, texto, #000070);
	
	draw_set_color(c_white);	
	draw_text(horizontal, vertical, texto);
}

function exibirTempo() {
	var vertical = 20;
	var horizontal = 600;
	var texto = "tempo";
	
	draw_set_font(fntHUD);
	
	inserirContornoTexto(horizontal, vertical, texto, #050914);
	
	draw_set_color(#d41e3c);	
	draw_text(horizontal, vertical, texto);
	
	vertical = 50;
	horizontal = 630;
	texto =  string(global.propriedadesJogo.tempo);
	
	inserirContornoTexto(horizontal, vertical, texto, #050914);
	
	draw_set_color(#d41e3c);
	draw_text(horizontal, vertical, texto);
}

function exibirMoedas() {	
	var vertical = 60;
	var horizontal = 820;
	var moedas = " = " + string(global.propriedadesJogo.moedas);
	
	draw_sprite_ext(sprMoedaHUD, 0, 720, 20, 7, 7, 0, c_white, 1);
	
	draw_set_font(fntMoedaHUD);
	
	inserirContornoTexto(horizontal, vertical, moedas, c_black);
	
	draw_set_color(c_white);
	draw_text(horizontal, vertical, moedas);
}

function inserirContornoTexto(horizontal, vertical, texto, cor) {
	var espessura = 4;
	
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