/// @description Mecanicas da camera

global.propriedadesCamera = {
	tremer: false,
	x: camera_get_view_x(view_camera[0]),
	y: camera_get_view_y(view_camera[0])
}

function ajustarCamera() {
	if (room == rmChefe) {
		centrarSalaChefe();
	} else {
		var passandoFase = global.propriedadesJogo.passandoFase;
		
		if(passandoFase) {
			centrarPasseFase();
		} else {
			acompanharPlayer();
		}
	}
}

function acompanharPlayer(){
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var direcao = global.propriedadesPlayer.direcao;
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;		
		var posicaoHorizontal = direcao == DirecaoEnum.Direita ? player.x + 15 : player.x;
	
		y = lerp(y, player.y, 0.10);
		x = lerp(x, posicaoHorizontal, 0.10);
	}
}

function centrarPasseFase() {
	var posicaoVertical = objMastro.y;
	var posicaoHorizontal = objMastro.x + 80;
	
	y = lerp(y, posicaoVertical, 0.10);
	x = lerp(x, posicaoHorizontal, 0.10);
}

function centrarSalaChefe() {
	var posicaoX = global.propriedadesCamera.x;
	var posicaoY = global.propriedadesCamera.y;
	var tremerCamera = global.propriedadesCamera.tremer;
	
	if (tremerCamera) {
		var limiteVertical = random_range(-3, 3);
		var limiteHorizontal = random_range(-3, 3);
		
		camera_set_view_pos(view_camera[0], posicaoX+limiteHorizontal, posicaoY+limiteVertical);		
	} else {
		camera_set_view_pos(view_camera[0], posicaoX, posicaoY);
	}
}
	
function parallax() {
	if(room == rmFase1) {
		var posicaoCamera = x * -0.02;
		var nuvensLonge = layer_get_id("CloudsFar");
		var nuvensPerto = layer_get_id("CloudsClose");
		var montanhasLonge = layer_get_id("MontainsFar");
		var montanhasPerto = layer_get_id("MontainsClose");
		
		layer_x(nuvensLonge, lerp(0, camera_get_view_x(view_camera[0]), 0.7));
		layer_x(nuvensPerto, lerp(0, camera_get_view_x(view_camera[0]), 0.67));
		layer_x(montanhasLonge, lerp(0, camera_get_view_x(view_camera[0]), 0.8));
		layer_x(montanhasPerto, lerp(0, camera_get_view_x(view_camera[0]), 0.5));
	}
}