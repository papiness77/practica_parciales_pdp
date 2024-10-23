
object reducirOxigeno {
  
  method serRealizado(nave){
    if(not nave.alguienTiene("tuboOxigeno")){
      nave.bajarNivelOxigeno(10)
      nave.chequearVictoriaImpostor()
    }
  }
}

class Impugnacion {
  var colorImpugnado
  

  method serRealizado(nave){
    nave.impugarnarA(colorImpugnado)
  }
}