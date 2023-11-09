class Cocinero {
	
	var property especialidad
	
	
	method degustar(unPlato) = especialidad.degustar(unPlato)
	
	
	method cocinar() = especialidad.cocinar(self)
	
}
class Repostero {
	
	var property dulzorDeseado
	method degustar(unPlato)  = ((5 * unPlato.cantidadAzucar())/dulzorDeseado).min(10)
	
	method cocinar(unCocinero) = new Postre(cocinero = unCocinero, cantDeColores = dulzorDeseado/50)
}

class Chef {
	
	var property cantCaloriasDeseadas
	
	method degustar(unPlato) = if(self.cumpleExpectativas(unPlato)) 10 else self.calificacionNegativa(unPlato)
	
	method calificacionNegativa(unPlato) = 0
	
	method cumpleExpectativas(unPlato) = unPlato.estaBienDecorado() && cantCaloriasDeseadas >= unPlato.cantCalorias()
	
	method cocinar(unCocinero) = new Principal(cocinero = unCocinero, estaBienDecorado = true, cantidadAzucar = cantCaloriasDeseadas)
	}

class GardeMange inherits Chef {
	
	override method calificacionNegativa(unPlato) {
		return (unPlato.cantCalorias()/100).min(6)
	}
	
	override method cocinar(unCocinero) = new Entrada(cocinero = unCocinero)
	
}

class Plato {
	
	const property baseCalorias = 100 
	var property cocinero
	method cantidadAzucar()
	
	
	
	method cantCalorias() = 3*self.cantidadAzucar() + baseCalorias
}
class Entrada inherits Plato {
	
	override method cantidadAzucar() = 0 
	method estaBienDecorado() = true
	
}
class Principal inherits Plato {
	var property estaBienDecorado
	var property cantidadAzucar
}


class Postre inherits Plato {
	var property cantDeColores

	method estaBienDecorado() = cantDeColores > 3
	
	override method cantidadAzucar() = 120
}

