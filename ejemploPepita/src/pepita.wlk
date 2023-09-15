object pepita {
	var energia = 100
	
	method energia() {
		return energia
   }
	
	method volar(metros) {
		energia -= metros
	}
	
	method comer(cantGramos){
		energia += cantGramos * 2
	}
}
