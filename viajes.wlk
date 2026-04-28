import camion.*

object ruta_9 {
  
  const property nivelMaxPeligrosidad = 20

  method puedeTransportar(_vehiculo) {
    
    self.validarTransporte(_vehiculo)
  }

  method validarTransporte(_vehiculo) {
    
    if(not _vehiculo.puedeCircularEnRutaConPeligrosidadDe_(nivelMaxPeligrosidad))
    {
      self.error("error,vehiculo con alta peligrosidad,no puede circular")
    }
  }

}

object caminosVecinales {
  
  var property pesoMaximoPermitido = null 

  method puedeTransportar(_vehiculo) {
    
    self.validarTransporte(_vehiculo)
  }

  method validarTransporte(_vehiculo) {
    
    if (not self.estaPermitidoConPeso_(_vehiculo.peso())) {
      
        self.error("error no se puede transportar, el peso excede el maximo permitido")
    }    
  }

  method estaPermitidoConPeso_(_peso) {
    
      return _peso < self.pesoMaximoPermitido()
  }

}

