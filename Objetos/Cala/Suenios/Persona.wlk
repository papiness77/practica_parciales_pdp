import Suenios.*
class Persona {
  var personalidad
  const sueniosPendientes = []
  const sueniosCumplidos = []
  const carrerasRecibidas = []
  const carrerasDeseadas = []
  const sueldoSoniado
  var tieneHijo = false
  var felicidad = 0
  
  method cumplirSuenio(){
    const suenio = self.elegirSuenio()
    suenio.cumplirse(self)
    sueniosPendientes.remove(suenio)
    sueniosCumplidos.add(suenio)
  }

  method elegirSuenio() = personalidad.elegirSuenio(sueniosPendientes)

  method aumentarFelicidad(cantidad) {
    felicidad += cantidad
  }

  method quiereEstudiar(carrera) = carrerasDeseadas.contains(carrera)

  method seRecibioEn(carrera) = carrerasRecibidas.contains(carrera)

  method deseoPlata() = sueldoSoniado

  method tieneHijo() = tieneHijo

  method recibirseDe(carrera) {
    carrerasRecibidas.add(carrera)
  }

  method tenerHijo() {
    tieneHijo = true
  }

  method suenioMasFeliz() = sueniosPendientes.max{ suenio => suenio.felicidad() }

  method esFeliz() = felicidad > self.felicidadPendiente()

  method felicidadPendiente() = sueniosPendientes.sum{ suenio => suenio.felicidad() }

  method esAmbiciosa() = self.sueniosFelices().length() > 3

  method sueniosFelices() = self.filtrarSueniosFelices(sueniosCumplidos).union(self.filtrarSueniosFelices(sueniosPendientes))

  method filtrarSueniosFelices(listaSuenios) = listaSuenios.filter{suenio => suenio.esFeliz() }
}

object realista {

  method elegirSuenio(persona) = persona.suenioMasFeliz()
}

object alocado {

  method elegirSuenio(persona) = persona.sueniosPendientes().anyOne()
}

object obsesivos {

  method elegirSuenio(persona) = persona.sueniosPendientes().first()
}