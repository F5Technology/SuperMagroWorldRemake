/// @description Enums

enum DirecaoEnum {
	Esquerda = -1,
	Direita = 1
}

enum ElevacaoEnum {
	Subir = -1,
	Descer = 1
}

enum TipoColisaoEnum {
	Vertical = 1,
	Horizontal = 2
}

enum SpriteEnum {
	Parado = 1,
	Andando = 2,
	Correndo = 3,
	Abaixado = 4,
	Pulando = 5,
	Caindo = 6,
	Derrapando = 7,
	LancarProjetil = 8,
	Morrendo = 9,
	Aparecendo = 10,
	Escondendo = 11,
	CoolDown = 12
}

enum ValorEnum {
	Vida = 1,
	Ponto10 = 10,
	Ponto200 = 200,
	Ponto400 = 400,
	Ponto1000 = 1000
}

enum SituacaoChefeEnum {
	Ativo = 1,
	Aterrissando = 2,
	SumonandoInimigos = 3,
	CoolDown = 4
}