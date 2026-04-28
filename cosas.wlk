import camion.*


object knightRider {

    method peso() {return 500}

    method peligrosidad() {return 10}

    method cantBultosAUsar() {return 1}

    method sufrirAccidente() {
      
    }

}

object arenaGranel {

    var peso = 0

    method peso() {return peso}

    method actualizarPeso(cantidad) {peso = cantidad}

    method peligrosidad() {return 1}

    method cantBultosAUsar() {return 1}

    method sufrirAccidente() {
      
      self.actualizarPeso(self.peso() + 20)
    }
}


object bumblebee {

    var property transformadoEn_ = null

    method peso() {return 800}

    method peligrosidad() {return transformadoEn_.peligrosidad()}

    method cantBultosAUsar() {return 2}

    method sufrirAccidente() {
      
      if (self.transformadoEn_() == robot) {
        
        self.transformadoEn_(auto)

      } else {
        
        self.transformadoEn_(robot)
      }
    }
}

object auto {
  
  method peligrosidad() {return 15}
}
object robot {
  
  method peligrosidad() {return 30}
}


object paqueteLadrillos {

    const property pesoLadrillo = 2
	var ladrillos = 0 

	method peso() {
	  
	  return self.pesoLadrillo() * self.ladrillosPorPaquete_()
	}

    method ladrillosPorPaquete_() {return ladrillos}

    method ladrillosPorPaquete_(_cantidad) 
	{
	  ladrillos = _cantidad  
	}

    method peligrosidad() {return 2}
	
    method cantBultosAUsar() {
        
    return if(self.ladrillosPorPaquete_().between(1, 100)) {
      
            1

        }else if(self.ladrillosPorPaquete_().between(101,300))
        {
            2
        }
        else{
            
            3
        }    
    }

    method sufrirAccidente() {
        
        if (self.ladrillosPorPaquete_().between(0, 11) ) {
          
            self.ladrillosPorPaquete_(0)

        } else {

            self.ladrillosPorPaquete_(self.ladrillosPorPaquete_() - 12)
        }
    }
    
}

object bateríaAntiaérea {

    var peso = 200
	var misiles = null

	method peso() {return peso}

    method actualizarPeso() {
        
		if (self.tieneMisiles()) {peso = 300}

        else{self.peso()}
    }

    method peligrosidad() {
		
		return if(self.tieneMisiles()) {
		   
		    100
		}
		else
		{
			0
		}
	}

	method actualizarEstadoMisiles(_condicion) {
	  
	  misiles = _condicion
	}

    method tieneMisiles() {return misiles}

    method cantBultosAUsar() {
      
      return if(not self.tieneMisiles()) {
        
        1

      } else {
        
        2
      }
    }


    method sufrirAccidente() {
      
      self.actualizarEstadoMisiles(false)
    }

}

object residuosRadioactivos {

    var peso = 0

    method actualizarPeso(_nuevoPeso) {peso = _nuevoPeso}

    method peso() {return peso}

    method peligrosidad() {return 200}

    method cantBultosAUsar() {return 1}

    method sufrirAccidente() {
      
      self.actualizarPeso(self.peso() + 15)
    }

}


