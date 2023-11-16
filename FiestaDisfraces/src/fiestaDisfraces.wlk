
class Fiesta {
	
	var property fecha
	var property lugar
	const property invitados = new List()
	
	method esBodrio() {
		return invitados.all({unInvitado => unInvitado.estaDisconforme(self)})
	}
	
	method mejorDisfraz()  = self.invitadoConMejorDisfraz().disfraz()
	
	method invitadoConMejorDisfraz() {
		return invitados.max({unInvitado => unInvitado.puntajeDisfraz(self)})
	}
	
	method puedeIntercambiarTrajes(unInvitado, otroInvitado) {
		return self.estanEnFiesta(unInvitado, otroInvitado) && self.algunoDisconforme(unInvitado, otroInvitado) && self.conformeConDisfrazDelOtro(unInvitado, otroInvitado)
	}
	
	method estanEnFiesta(unInvitado, otroInvitado) {
		self.validarQueEsten(unInvitado, otroInvitado)
		return true		
	}
	
	method validarQueEsten(unInvitado, otroInvitado) {
		if (!self.estaEnFiesta(unInvitado) || !self.estaEnFiesta(otroInvitado)) {
			throw new DomainException(message = "hay una persona que no esta en la fiesta")
		}
		
	}
	
	method estaEnFiesta(unInvitado) = invitados.contain(unInvitado)
	
	method algunoDisconforme(unInvitado, otroInvitado) {
		return unInvitado.estaDisconforme(self) || otroInvitado.estaDisconforme(self)
	}
	
	method conformeConDisfrazDelOtro(unInvitado, otroInvitado) {
		var disfrazInvitado = unInvitado.disfraz()
		unInvitado.cambiarDisfraz(otroInvitado.disfraz())
		otroInvitado.cambiarDisfraz(disfrazInvitado)
		return unInvitado.estaConforme(self) && otroInvitado.estaConforme(self)
		
	}
	
	method agregarAsistente(unAsistente) {
		self.validarAsistente(unAsistente)
		invitados.add(unAsistente)
	}
	
	method validarAsistente(unAsistente) {
		if( self.estaEnFiesta(unAsistente) || !unAsistente.tieneDisfraz()) {
			throw new DomainException(message = "no se puede agregar asistente")
		}
		
	}
	
	method esInolvidable() {
		return invitados.all({unInvitado => self.cumpleCondiciones(unInvitado)})
		
	}
	
	method cumpleCondiciones(unInvitado) {
		return unInvitado.esSexy() && unInvitado.estaConforme(self)
	}
}

class Invitado {
	
	var property disfraz
	var property edad
	var property personalidad
	
	method puntajeDisfraz(fiesta) = disfraz.puntaje(fiesta, self)
	method esSexy() = personalidad.esSexy(self)
	method estaDisconforme(unaFiesta) = !self.estaConforme(unaFiesta)
	
	method estaConforme(unaFiesta) = disfraz.puntaje(unaFiesta, self) > 10 && self.cumpleCondiciones(unaFiesta) 

	method cumpleCondiciones(_)
	
	method cambiarDisfraz(otroDisfraz) {
		disfraz = otroDisfraz		
	}
	
	method tieneDisfraz() = disfraz != null
}

class Disfraz {
	
	var property nombre
	var property fechaDeFabricacion
	const property caracteristicas = []
	
	method puntaje(unaFiesta, unaPersona) {
		return caracteristicas.sum({unaCaracteristica => unaCaracteristica.puntos(unaPersona, unaFiesta) })
	}
}

class Gracioso {
	
	var property nivelDeGracia
	
	method puntos(persona, unaFiesta) {
		if (persona.edad() > 50)  {
			return nivelDeGracia *3
		}
		return nivelDeGracia
	}
}

class Tobara {
	var property fechaDeCompra 
	
	method puntos(persona, fiesta) {
		if (self.cantDiasDeLaCompra(fiesta.fecha()) > 2) {
			return 5
		}
		return 3
	}
	
	method cantDiasDeLaCompra(fechaDeLaFiesta) {
		return fechaDeLaFiesta - fechaDeCompra
	}
}

class Careta  {
	var property personajeCareta
	
	method puntos(persona, fiesta) {
		return personajeCareta.valor()
	}
}

class Personaje {
	var property nombre
	var property valor
	
}

object sexy {
	
	method puntos(persona, fiesta) {
		if (persona.esSexy()) {
			return 15
		}
		return 2
	}
}

object alegre {
	method esSexy(_)= false 
}

object taciturna {
	method esSexy(persona) = persona.edad() < 30 
}

class Cambiante {
	var property personalidad 
	
	method esSexy(persona) = personalidad.esSexy(persona)
}

class Caprichoso inherits Invitado {
	override method cumpleCondiciones(_) = self.cantidadDeLetras().even()

	method cantidadDeLetras() = disfraz.nombre().size()
}

class Pretencioso inherits Invitado {
	
	override method cumpleCondiciones(_) = self.cantDeDiasDelDisfraz() < 30
	
	method cantDeDiasDelDisfraz() {
		return new Date() - disfraz.fechaDeFabricacion()
	}
}

class Numerologo inherits Invitado {
	
	var property cifra
	override method cumpleCondiciones(unaFiesta) = disfraz.puntos(unaFiesta, self) == cifra
}

