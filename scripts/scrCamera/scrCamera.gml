/// @description Mecanicas da camera

function acompanharPlayer(){
	var posicaoHorizontal = global.direcao == DirecaoEnum.Direita ? 
	objSeuMadruga.x + 15 : 
	objSeuMadruga.x;
	
	y = lerp(y, objSeuMadruga.y, 0.10);
	x = lerp(x, posicaoHorizontal, 0.10);
}