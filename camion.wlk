import cosas.*
import lugar.*


object camion {

	const property cosas = #{}
	const property tara = 1000
	const property pesoMaximoAceptable = 2500
		
	method cargar(_unaCosa){
		
		// if (not self.estaCargado(_unaCosa)){
		  
		//   cosas.add(_unaCosa)
		// }

		self.validarCarga(_unaCosa)
	 	cosas.add(_unaCosa)
	 }

	method descargar(_unaCosa){
		
		// if (self.estaCargado(_unaCosa)) {
		  
		//   cosas.remove(_unaCosa)
		// }

		 self.validarDescarga(_unaCosa)
		 cosas.remove(_unaCosa)
	}

	method validarDescarga(_unaCosa) {
	  
	  if (not self.estaCargado(_unaCosa)){
		
		self.error("Error al descargar. El objeto no estaba cargado")
	  }
	}

	method validarCarga(_unaCosa) {
	  
	  if (self.estaCargado(_unaCosa)){
		
		self.error("Error al cargar. El objeto ya esta cargado")
	  }
	}

	method estaCargado(_unaCosa){
	  
	   return self.cosas().any({ c =>  c == _unaCosa})
	}


	//TODO PESO PAR

	method sonTodosPesosPares() {
	  
	  return self.cosas().all({c => self.esPesoPar(c)})
	}

	method esPesoPar(_unaCosa) {return _unaCosa.peso().even()}

	method hayAlgunoQuePesa_(_kilos) {
	  
	  return self.cosas().any({ c => c.peso() == _kilos})
	}

	//PESO Y EXCESO DE PESO
	method peso(){
	  
	  return self.tara() + self.carga()
	}

	method carga(){
	  
	  return self.cosas().sum({ c => c.peso() })
	}

	method estaExcedidoDePeso() {
	  
	  return self.peso() > self.pesoMaximoAceptable()
	}

	method cosaConPeligrosidadDe_(_numero) {
	  
	  return self.cosas().find({c => c.peligrosidad() == _numero})
	}

	method hayAlgunoConPeligroDe_(_numero) {
	  
	  return self.cosas().any({c => c.peligrosidad() == _numero})
	}

	//COSAS PELIGROSAS

	method cosasQueSuperanPeligrosidadDe_(_numeroPeligrosidad) {
	  
	  return self.cosas().filter({ c => self.esMasPeligrosoQue_(c,_numeroPeligrosidad)})
	}

	method esMasPeligrosoQue_(_unaCosa,_numeroPeligrosidad) {
	  
	  return _unaCosa.peligrosidad() > _numeroPeligrosidad
	}

	method cosasCargadasMasPeligrosasQue_(_unaCosa) {
	  
	  return self.cosasQueSuperanPeligrosidadDe_(_unaCosa.peligrosidad())
	}

	//PUEDE CIRCULAR EN RUTA

	method puedeCircularEnRutaConPeligrosidadDe_(_numeroPeligrosidad) {
	  
	  return not self.estaExcedidoDePeso() and self.sonTodosDeMenorPeligrosidadQue_(_numeroPeligrosidad)
	}

	method sonTodosDeMenorPeligrosidadQue_(_numeroPeligrosidad) {
	  
	  return self.cosas().all({c => self.esMenosPeligrosoQue_(c, _numeroPeligrosidad) })
	}

	method esMenosPeligrosoQue_(_unaCosa,_numeroPeligrosidad) {
	  
	  return not self.esMasPeligrosoQue_(_unaCosa, _numeroPeligrosidad)
	}

	method hayObjeto_Entre_YEntre_(_minimo,_maximo) {
	  
	  return self.cosas().any({ c => self.esObjeto_Entre_YEntre_(c,_minimo,_maximo) })
	}

	method esObjeto_Entre_YEntre_(c,_minimo,_maximo) {
	  
	  return c.peligrosidad().between(_minimo,_maximo)
	}

	//COSA MAS PESADA falto terminar no se como hacer cuando
	//esta vacio
	method cosaMasPesada() {
	  
	  self.validarSiEstaCargadoCon_(self.cosas())
	  return self.cosas().max({ c => c.peso() })
	}

	method validarSiEstaCargadoCon_(_cosas) {
	  
	  if (self.cosas().isEmpty()) {
		
		self.error("error, no existen elementos cargados en el camion")
	  }
	}


	method pesosDeLosObjetos() {
	  
	  return self.cosas().map({ c => c.peso()})
	}

	method cantBultosTotales() {
	  
	  return self.cosas().sum({ c => c.cantBultosAUsar() })
	}

	//ACCIDENTE
	method sufrirAccidente() {
	  
	  self.cosas().forEach({ c => c.sufrirAccidente()})
	}

	//TRANSPORTE
	method transportar(_viaje,_lugar) {

		_viaje.puedeTransportar(self)
		self.llevarCamionAl_(_lugar)
	}


	method llevarCamionAl_(_lugar) {

    	_lugar.depositar(self.cosas())
		self.vaciarCamion()
	}

	method vaciarCamion() {
	  
	  return self.cosas().removeAll(self.cosas())
	}

	method puedeTransportar() {

	  return self.puedeCircularEnRutaConPeligrosidadDe_(20)
	}


}


object contenedorPortuario {

    var property cosas = #{}

	method cargar(_unaCosa) {cosas.add(_unaCosa)}	

    method peso() {return 100 + self.sumaPesos() }
    
    method sumaPesos() {return cosas.sum({c => c.peso() })}
    
    method peligrosidad() {
        
        return if (cosas.isEmpty()) {
          
            0

        } else {
          
            self.peligrosidadObjetoMasPeligroso()         
        }
    }    
    

	method peligrosidadObjetoMasPeligroso() {
	  
	  return self.peligrosidadDelObjeto(self.objetoConMayorPeligrosidad())
	}

    method objetoConMayorPeligrosidad() {
      
      return cosas.max({c => c.peligrosidad()}) 
    }

	method peligrosidadDelObjeto(_unObjeto) {
	  
	  return _unObjeto.peligrosidad()
	}

    //method reaccionar() {cosas.forEach({c => c.reaccionar()})}
    method cantBultosAUsar() {return 1 + cosas.sum({c => c.cantBultosAUsar()})}

	method sufrirAccidente() {
	  
	  self.cosas().forEach({ c => c.sufrirAccidente()})
	}
}

object embalajeSeguridad {

    var objetoEmbalado = null

    method objetoEmbalado() {return objetoEmbalado}

    method embalar(_unaCosa) {objetoEmbalado = _unaCosa}

    method peso() {return self.objetoEmbalado().peso()}

    method peligrosidad() {return self.objetoEmbalado().peligrosidad() / 2}

    // method reaccionar() {}
	method cantBultosAUsar() {return 2}

	method sufrirAccidente() {
	  
	}
}
