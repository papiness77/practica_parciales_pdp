class Expedicion {
  const comitiva = []
  const objetivos = []
  
  method subir(vikingo) {
    if(vikingo.puedeIrAExpedicion()){
      comitiva.add(vikingo)
    }
    else{
      throw new DomainException(message = "No puede subir a la expedición")
    }
  }

  method valeLaPena() = objetivos.all{ objetivo => objetivo.valeLaPena(self) }

  method cantidadVikingos() = comitiva.size()

  method serRealizada() {
    objetivos.forEach{ objetivo => objetivo.serAtacado(self) }
  }

  method aumentarKills() {
    comitiva.forEach{ vikingo => vikingo.aumentarKills() }
  }

  method ganarBotin(cantidad) {
    const cantidadPorVikingo = cantidad / self.cantidadVikingos()
    comitiva.forEach{ vikingo => vikingo.ganarBotin(cantidadPorVikingo) }
  }
}

class Vikingo {
  var property casta
  var kills = 0
  var monedas = 0
  
  method puedeIrAExpedicion() = self.esProductivo()

  method ascender() {
    casta.ascender(self)
  }

  method esProductivo()

  method obtenerMejoras()

  method aumentarKills() {
    kills += 1
  }

  method ganarBotin(cantidad) {
    monedas += cantidad
  }
}

class Soldado inherits Vikingo {
  
  var armas = 0

  override method puedeIrAExpedicion() = super() && casta.puedeIrAExpedicion(self)
  
  override method esProductivo() = kills > 20 && self.tieneArmas()

  override method obtenerMejoras() {
    armas += 10
  }

  method tieneArmas() = armas != 0
}

class Granjero inherits Vikingo {
  var cantidadHectareas
  var cantidadHijos
  
  override method esProductivo() = cantidadHectareas >= cantidadHijos * 2

  override method obtenerMejoras() {
    cantidadHectareas += 2
    cantidadHijos += 2
  }
}
// 10 defensores 15 vikingos = 15 - 5
// 10 defensores 9 vikingos = 9 - 0
// 10 defensores 10 vikingos = 10 - 0

class Capital {
  const factorRiqueza
  var defensores
  
  method valeLaPena(expedicion) = self.botin(expedicion.cantidadVikingos()) * 3 > expedicion.cantidadVikingos()

  method defensoresDerrotados(cantidadEnemigos) = cantidadEnemigos - 0.max(cantidadEnemigos - defensores)

  method botin(cantidadEnemigos) = self.defensoresDerrotados(cantidadEnemigos) * factorRiqueza

  method serAtacado(expedicion) {
    const botin = self.botin(expedicion.cantidadVikingos())
    defensores = 0.max(defensores - expedicion.cantidadVikingos())
    expedicion.aumentarKills()
    expedicion.ganarBotin(botin)
  }
}

class Aldea {
  const sedDeSaqueos = 15
  var cantidadCrucifijos 

  method valeLaPena(expedicion) = self.botin(0) >= sedDeSaqueos

  method botin(_) = cantidadCrucifijos

  method serAtacado(expedicion) {
    const botin = self.botin(expedicion.cantidadVikingos())
    cantidadCrucifijos = 0
    expedicion.ganarBotin(botin)
  } 
}

class AldeaAmurallada inherits Aldea {
  const minimoVikingos

  override method valeLaPena(expedicion) = super(expedicion) && expedicion.cantidadVikingos() >= minimoVikingos
}

object jarl {
  
  method puedeIrAExpedicion(vikingo) = !vikingo.tieneArmas()

  method ascender(vikingo) {
    vikingo.casta(karl)
    vikingo.obtenerMejoras() 
  }
}

object karl {
  method ascender(vikingo) {
    vikingo.casta(thrall) 
  }
  
  method puedeIrAExpedicion(vikingo) = true 
}

object thrall {
  
  method puedeIrAExpedicion(vikingo) = true 
}