
class Comensal {
  var criterioElemento
  var criterioComida
  const elementos = []
  const comidas = []
  var property posicion 
  
  method pedirElementoA(otroComensal, elemento) {
    if(otroComensal.tieneElemento(elemento)) {
      otroComensal.pasarElemento(self, elemento)
    }
  }

  method pasarElemento(otroComensal, elemento) {
    criterioElemento.pasarElemento(self, otroComensal, elemento)
  }
  
  method recibirElemento(elemento) {
    elementos.add(elemento)
  }

  method primerElemento() = elementos.first()

  method elementos() = elementos

  method cambiarPosicionCon(otroComensal) {
    const posicionVieja = self.posicion()
    self.posicion(otroComensal.posicion())
    otroComensal.posicion(posicionVieja)
  } 

  method comer(unaComida) {
    if (self.decidirComer(unaComida)){
      comidas.add(unaComida)
    }
  }

  method decidirComer(unaComida) = criterioComida.tomarDecision(unaComida)

  method estaPipon() = comidas.any{ comida => comida.esPipona()}

  method estaPasandolaBien() = !comidas.isEmpty()

  method comioCarne() = comidas.any{ comida => comida.esCarne() }
}

object osky inherits Comensal (criterioComida = "", criterioElemento = "", posicion = ""){
  
}

object moni inherits Comensal (criterioComida = "", criterioElemento = "", posicion = ""){
  override method estaPasandolaBien() = self.posicion() == "1@1"
}

object facu inherits Comensal (criterioComida = "", criterioElemento = "", posicion = ""){
  override method estaPasandolaBien() = self.comioCarne()
}

object vero inherits Comensal (criterioComida = "", criterioElemento = "", posicion = ""){
  override method estaPasandolaBien() = elementos.size() <= 3
}