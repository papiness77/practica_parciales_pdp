class Casa {
    var property patrimonio = 0
    var nombreCiudad = ""
    const property miembros = []

    method puedeCasarse(miembro, conyuge)

    method esRica() = self.patrimonio() > 1000

    method cantidadMiembros() = self.miembros().size()
    method patrimonioPorMiembro() = self.patrimonio()/self.cantidadMiembros()

    method miembroVivoYSoltero() = self.miembros().any({miembro => miembro.estaSoltero() && miembro.estaVivo()})

    method reducirPatrimonioProcentaje(porcentaje) { patrimonio -= patrimonio * porcentaje/100 } 
}

object lannister inherits Casa () {

    override method puedeCasarse(miembro, conyuge) = miembro.estaSoltero()
 
}

object stark inherits Casa () {

    override method puedeCasarse(miembro, conyuge) = miembro.casa() != conyuge.casa() 
 
}
object guardiaNoche inherits Casa () {
    override method puedeCasarse(miembro, conyuge) = false 
 
}


class Personaje {
    var property casa
    const property conyuges = #{}

    const property acompaniantes = #{}

    var personalidad

    var property estaVivo 

    method estaSoltero() = self.cantidadDeConyuges() == 0

    method cantidadDeConyuges() = self.conyuges().size() 

    method permiteMiCasaElCasamiento(conyuge) = self.casa().puedeCasarse(self, conyuge)

    method sePuedeCasar(otroPersonaje) = self.permiteMiCasaElCasamiento(otroPersonaje) && otroPersonaje.permiteMiCasaElCasamiento(self)

    method obtenerConyuge(conyuge) = self.conyuges().add(conyuge)

    method casarse(conyuge) {
        if(self.sePuedeCasar(conyuge)){
            self.obtenerConyuge(conyuge)
            conyuge.obtenerConyuge(self)
        }
        else {
            throw new Exception(message = "no se puede")
        }
    }

    method patrimonioPersonaje() = self.casa().patrimonioPorMiembro()

    method cantidadDeAcompaniantes() = self.acompaniantes().size()


    method estaSolo() = self.cantidadDeAcompaniantes() == 0

    method miembrosCasa() = self.casa().miembros()

    method aliados() = self.acompaniantes().union(self.conyuges()).union(self.miembrosCasa())

    method dineroAliados() = self.aliados().sum({aliado => aliado.patrimonioPersonaje()})

    method sumanDinero(cantidad) = self.dineroAliados() > cantidad

    method esDeCasaRica() = self.casa().esRica()

    method conyugesRicos() = self.conyuges().all({conyuge => conyuge.esDeCasaRica() })

    method estaAliadoConPeligroso() = self.aliados().any({aliado => aliado.esPeligroso()})

    method esPeligroso() = (self.estaAliadoConPeligroso() || self.conyugesRicos() || self.sumanDinero(10000)) && estaVivo

    method ejecutarConspiracion(objetivo) = personalidad.accion(objetivo)

}


class Lobo {
    var esHuargo
    method esPeligroso() = esHuargo 
    method patrimonioPersonaje() = 0
}

class Dragon {
    method esPeligroso() = true
    method patrimonioPersonaje() = 0
}


const casas = [lannister, stark, guardiaNoche]

const casaMasPobre = casas.min({casa => casa.patrimonio()})

class Conspiracion {
    const conspiradores = #{}
    const objetivo 

    var ejecutada = false


    method traidores() = conspiradores.intersection(objetivo.aliados())

    method cantidadTraidores() = self.traidores().size()

    method conspirar() = conspiradores.forEach({conspirador => conspirador.ejecutarConspiracion(objetivo)})
    
     


    
}

object sutil {
    method accion(personaje) {
        personaje.casarse(casaMasPobre.miembroVivoYSoltero())
    }
}

object asesino {
    method accion(personaje) {
        personaje.estaVivo(false)
    }
}

object asesinoPrecavido {
    method accion(personaje){
        if(personaje.estaSolo()) personaje.estaVivo(false)
    }
}

object disipado {
    const porcentaje = 10

    method accion(personaje) {
        personaje.casa().reducirPatrimonioPorcentaje(porcentaje)
    }
}

object miedoso {
    method accion() {}
}
