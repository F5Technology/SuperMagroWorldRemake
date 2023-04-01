/// @description Ferramentas para printar tela e exibir os prints

global.propriedadesPrint = {
	printPause: -1,
	resolucao : {
		altura: camera_get_view_height(view_camera[0]),
		largura: camera_get_view_width(view_camera[0])
	}
}

function reiniciarPropriedadesPrint() {
	global.propriedadesPrint = {
		printPause: -1,
		resolucao : {
			altura: camera_get_view_height(view_camera[0]),
			largura: camera_get_view_width(view_camera[0])
		}
	}
}

function printarTelaPause() {
	var printPause = global.propriedadesPrint.printPause;
	var altura = global.propriedadesPrint.resolucao.altura * 4;
	var largura = global.propriedadesPrint.resolucao.largura * 3.63;
	
	printPause = surface_create(largura, altura);
	surface_set_target(printPause);
	draw_surface(application_surface, 0, 0);
	surface_reset_target();
	
	//Ajuste na resolução de tela
	camera_set_view_size(view_camera[0], largura, altura);
	camera_set_view_pos(view_camera[0], 0, 0)
	
	global.propriedadesPrint.printPause = printPause;
}

function exibirTelaPause() {
	var pause = global.propriedadesJogo.pause;
	var printPause = global.propriedadesPrint.printPause;
	
	if (pause) {			
		if(surface_exists(printPause)) {		
			surface_set_target(application_surface);
			draw_surface(printPause, 0, 0);
			surface_reset_target();
		}	
		
		//global.propriedadesJogo.pause = pause;
		//global.propriedadesPrint.printPause = printPause;
	}
}

function apagarPrintPause() {
	var printPause = global.propriedadesPrint.printPause;
	
	//Apaga print da memoria interna			
	if(surface_exists(printPause)) {
		surface_free(printPause)
	}
	
	//Redefine resolução camera	
	var altura = global.propriedadesPrint.resolucao.altura;
	var largura = global.propriedadesPrint.resolucao.largura;
	
	camera_set_view_size(view_camera[0], largura, altura);
}