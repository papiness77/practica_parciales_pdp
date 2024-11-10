object esclavoJarl {
 
  method puedeIr(vikingo) = vikingo.armas() == 0

  method puestoSuperior() = mediaKarl

}
object mediaKarl {
  method puestoSuperior() = nobleThrall
}

object nobleThrall {

}

class Vikingo {
  var casta 
}

class VikingoGranjero inherits Vikingo {
  var hectareas
  var hijos

  method esProductivo() = hectareas/hijos > 2 
}

class VikingoSoldado inherits Vikingo{
  var property armas 
  var vidasTomadas

  method esProductivo() = vidasTomadas > 20 && armas > 0

  method ascender(){
    casta = casta.puestoSuperior()
  

  }
}

class Expedicion {

}

class Capital {
  var defensores
  var factorDeRiqueza

  method defensoresDerrotados(cantidadVikingos) = cantidadVikingos.min(defensores)

  method botin(cantidadVikingos) = self.defensoresDerrotados(cantidadVikingos) * factorDeRiqueza

  method valeLaPena(cantidadVikingos) = self.botin(cantidadVikingos) / cantidadVikingos >= 3
}

class Aldea {

  var crucifijos
  
  method valeLaPena(cantidadVikingos) = crucifijos >= 15
}

class AldeaAmurallada inherits Aldea {
  var minimaVikingos

  override method valeLaPena(cantidadVikingos) = super(cantidadVikingos) && cantidadVikingos > minimaVikingos 
}
