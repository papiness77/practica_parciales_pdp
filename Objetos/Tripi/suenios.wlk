class Persona {
    var edad
    var felicidad

    var property personalidad

    const property carrerasQueQuiereEstudiar = []
    var property plataQueQuiereGanar 
    const lugaresPorViajar = []

    const property hijos = []

    const property carrerasDeLasQueSeRecibio = []

    const property sueniosPorCumplir = []
    const property sueniosCumplidos = []

    method cantidadHijos() = hijos.size()

    method quiereEstudiar(carrera) = carrerasQueQuiereEstudiar.contains(carrera)

    method seRecibioDe(carrera) = carrerasDeLasQueSeRecibio.contains(carrera)

    method tieneSuenio(suenio) = self.sueniosPorCumplir().contains(suenio)

    method aumentarFelicidad(cantidadAumentar) { felicidad += cantidadAumentar }

    method suenioMayorFelicidad() = sueniosPorCumplir.max({suenio => suenio.felicidonios()})

    method primerSuenio() = sueniosPorCumplir.head()

    method suenioAlAzar() = sueniosPorCumplir.anyOne()

    method cumplirSuenio(suenio) {
        if(self.tieneSuenio(suenio) && suenio.puedeCumplir(self)){
            self.sueniosPorCumplir().remove(suenio)
            self.sueniosCumplidos().add(suenio)

            self.aumentarFelicidad(suenio.felicidonios())

        }
    }
    
    method cumplirSuenioMasPreciado() {
        self.cumplirSuenio(self.personalidad().suenioMasPreciado(self))

    }

    method felicidoniosSueniosPendientes() = sueniosPorCumplir.sum({suenio => suenio.felicidonios()})

    method esFeliz() = felicidad > self.felicidoniosSueniosPendientes()

    method sueniosConFelicidadMayorA(cantidad) = sueniosPorCumplir.filter({suenio => suenio.felicidonios() > cantidad})

    method esAmbicioso() = self.sueniosConFelicidadMayorA(100).size() > 3
}

class Suenio {
    var property felicidonios

}
class RecibirseDeUnaCarrera inherits Suenio {
    const carrera

    method puedeCumplir(persona) = persona.quiereEstudiar(carrera) && not(persona.seRecibioDe(carrera))

}

class TenerHijo inherits Suenio {

    method puedeCumplir(persona) = true
    
}
class AdoptarHijos inherits Suenio {
    const cantidad

    method puedeCumplir(persona) = persona.cantidadHijos() == 0
}
class ViajarA inherits Suenio {
    const lugar

    method puedeCumplir(persona) = true
}
class ConseguirLaburo inherits Suenio {
    const sueldo

    method puedeCumplir(persona) = sueldo > persona.plataQueQuiereGanar()

}

class SuenioMultiple {
    const suenios = []

    method puedeCumplir(persona) = suenios.all({suenio => suenio.puedeCumplir(persona)})
}

object realista {
    method suenioMasPreciado(persona) = persona.suenioMayorFelicidad()
}
object alocado {
    method suenioMasPreciado(persona) = persona.suenioAlAzar()
}
object obsesivo {
    method suenioMasPreciado(persona) = persona.primerSuenio()
}
