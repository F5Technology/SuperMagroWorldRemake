/// @description Mecanicas relacionados a bandeira

function subirBandeira() {
	if(subir) {
		y -= 1;
		
		if(y <= 48) {
			subir = false;
		}
	}
}

function descerBandeira() {
	if(descer) {
		y += 1;
		
		if(y >= 224) {
			instance_destroy();
		}
	}
}