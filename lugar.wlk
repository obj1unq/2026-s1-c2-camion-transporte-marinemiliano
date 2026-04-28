import camion.*
import cosas.*


object almacen {
  
  const property objetos = #{knightRider,residuosRadioactivos}

  method depositar(_objetos) {
    
    return self.objetos().addAll(_objetos)
  }


}
