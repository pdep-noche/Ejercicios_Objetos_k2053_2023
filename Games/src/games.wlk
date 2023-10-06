class Jugador {
	
	var property antiguedad
	var property cantTorneosInternacionales
	var property nivelCansancio = 0
	
	method esTitular() = antiguedad > 3
	
	method tieneExperiencia() = cantTorneosInternacionales > 2
	
	method puedeJugar() = self.esTitular() && self.tieneExperiencia()
	
	method tomarEnergizante(cantidad) {
		nivelCansancio = 0.max(nivelCansancio - (10*cantidad))
	}
	
	method habilidad() = (antiguedad * 2) + (cantTorneosInternacionales*3) - nivelCansancio
		
	
	
	
	method jugar() {
		nivelCansancio += 20
	}
}
 
object faker {
	var property estaTilteado = false
	var property cantHabilidad = 0
	
	
	method tomarTecito() {
		estaTilteado = false
	}
	
	method puedeJugar() = estaTilteado.negate()
	
	method jugar() {
		cantHabilidad += 50
	}
	
	method habilidad() {
		if (estaTilteado) {
			return 0
		}
		return cantHabilidad
	}

 }
 
 class Partida {
 	
 	const property participantes = []
 	
 	method agregarParticipante(unParticipante) {
 		participantes.add(unParticipante)
 	}

	method comenzar() {
		
		participantes.forEach({unParticipante => unParticipante.jugar()})
	} 
	
	method ganador() = participantes.max({unParticipante => unParticipante.habilidad()})
 }
 
class Equipo {
	const property jugadores = []
	
	method contratar(unJugador) {
		jugadores.add(unJugador)
	}
	
	method jugar() {
		self.jugadoresDiponibles().forEach({unJugador => unJugador.jugar()})
	}
	
	method jugadoresDiponibles() {
		return jugadores.filter({unJugador => unJugador.puedeJugar()})
	}
	
	method habilidad() = jugadores.sum({unJugador => unJugador.habilidad()})
}
