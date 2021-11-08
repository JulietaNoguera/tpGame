import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*
import marcador.*
import direcciones.*
import deposito.*
import consumibles.*
object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "fondo.png"))
		
		
		//DEPOSITO
		game.addVisual(new Deposito(image="luna01.png",position=game.at(7,12)))
		game.addVisual(new Deposito(image="luna02.png",position=game.at(8,12)))
		game.addVisual(new Deposito(image="luna03.png",position=game.at(7,11)))
		game.addVisual(new Deposito(image="luna04.png",position=game.at(8,11)))
		
		
		//CONSUMIBLES
		
		const hamburgesa = new Energia(position=game.at(3,2),image = 'hamburger.png',aporta = 10)
		const botiquin = new Salud(position=game.at(5,10),image = 'botiquin.png',aporta = 5)
		const hamburgesa1 = new Energia(position=game.at(7,4),image = 'hamburger.png',aporta = 10)
		const botiquin2 = new Salud(position=game.at(4,9),image = 'botiquin.png',aporta = 5)
		
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(new Estrella(image = "estrella.png", position=game.at(2,5)))
		game.addVisual(new Estrella(image = "estrella.png",position=game.at(7,3)))
		game.addVisual(new Estrella(image = "estrella.png", position=game.at(0,13)))
		game.addVisual(new Estrella(image = "estrella.png",position=game.at(8,1)))
		
		
		game.addVisual(hamburgesa)
		game.addVisual(botiquin)
		game.addVisual(hamburgesa1)
		game.addVisual(botiquin2)
		
		game.addVisual(salud)
		game.addVisual(saludNum)
		game.addVisual(energia)
		game.addVisual(energiaNum)
		game.addVisual(dinero)
		game.addVisual(dineroNum)
		
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		// Movimientos
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.space().onPressDo({ bubba.comer()})		
		

		// en este no hacen falta colisiones
		game.whenCollideDo(bubba, { elemento => bubba.empujar(elemento)})
		}
		
	method dibujar(dibujo) {
		game.addVisual(dibujo)
		return dibujo
	}

	method perder(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="gameover.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
			})
		})
	}
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondo.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}

