class Suenio {
  const felocidonios
  
  method cumplirse(persona) {
    if(self.puedeCumplirse(persona)){
      self.tenerEfectos(persona)
    } else {
      throw new DomainException(message = "No se pudo cumplir el suenio")
    }
  }

  method felicidad() = felocidonios

  method puedeCumplirse(persona) = true
  method tenerEfectos(persona) {
    persona.aumentarFelicidad(felocidonios)
  }

  method esFeliz() = felocidonios > 100
}

class SuenioMultiple inherits Suenio {
  const suenios

  override method puedeCumplirse(persona) = suenios.all{ suenio => suenio.puedeCumplirse(persona)} 

  override method tenerEfectos(persona) {
    suenios.all{ suenio => suenio.tenerEfectos(persona)}
  }
}

class SuenioCarrera inherits Suenio {
  const carrera
  
  override method puedeCumplirse(persona) = persona.quiereEstudiar(carrera) && !persona.seRecibioEn(carrera)

  override method cumplirse(persona) {
    persona.recibirseDe(carrera)
  }
}

class ConseguirTrabajo inherits Suenio {
  const sueldo 

  override method puedeCumplirse(persona) = persona.deseoPlata() < sueldo 
}

class TenerHijo inherits Suenio {
  
  override method cumplirse(persona) {
    persona.tenerHijo()
  }
}

class AdoptarHijo inherits Suenio {
  
  override method puedeCumplirse(persona) = !persona.tieneHijo()

  override method cumplirse(persona) {
    persona.tenerHijo()
  }
}

class ViajarA inherits Suenio {
  
}

