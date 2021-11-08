import direcciones.*
import wollok.game.*
class Enemigo{
	var property position
	var property image
	var property nivelDanio
	method puedeRecibirDanio() = false
	method movete(dir){}
	method desplazarse(){
		position = new Position(x=0.randomUpTo(game.width()).truncate(0),y= 0.randomUpTo(game.height()-2).truncate(0))
	}
	method hacerDanio(player){
		if(player.puedeRecibirDanio()){
			player.salud(player.salud()-nivelDanio)
			game.say(player,"-"+nivelDanio)
		}
		
	}
	
}