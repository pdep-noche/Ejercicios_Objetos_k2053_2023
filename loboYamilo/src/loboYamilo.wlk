object yamilo {
	var calorias = 120
	
	method calorias(cantCalorias) {
		calorias = cantCalorias
	}
	
	method calorias() {
		return calorias
	}
	
	
	method comerA(unChanchito) {
		calorias += (unChanchito.peso()/10)
	}
	
	method tieneSobrepeso() = calorias > 200
	
	method estaSaludable() = calorias.between(20, 150)
	
	method correr(cantMinutos) {
		calorias -= cantMinutos *2
	}
}

object chanchitoCasaDePaja {
	var peso = 100
	
	method peso() = peso
	
}
