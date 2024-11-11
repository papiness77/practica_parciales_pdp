class Filosofo {
    var edad
    var nombre
    const honorificos = #{}
    const actividades = []
    var property iluminacion
    var diasVividos

    method presentarse() = nombre + honorificos.join(",")
    
    method estaEnLoCorrecto() = iluminacion > 1000

    method aumentarIluminacion(unidades) { iluminacion += unidades } 
    method disminuirIluminacion(unidades) { iluminacion -= unidades } 
    
    method agregarHonorifico(nuevoHonorifico) = honorificos.add(nuevoHonorifico)

    method rejuvenecer(diasARejuvenecer) { diasVividos -= diasARejuvenecer}

    method realizarActividades() = actividades.forEach({actividad => actividad.apply(self)})
    
    method cumplirAnios() {
        edad += 1
        diasVividos = 0
        self.aumentarIluminacion(10)

        if(edad == 60) self.agregarHonorifico("el sabio")
    }

    method vivirUnDia() {
        self.realizarActividades()
        diasVividos += 1

        if(diasVividos == 365) self.cumplirAnios()
        
    }
}

object tomarVino{
    method apply(filosofo) {
        filosofo.disminuirIluminacion(10)
        filosofo.agregarHonorifico("el borracho")
    }
}
class JuntarseEnElAgora {
    const otroFilosofo
    method apply(filosofo) {
        filosofo.aumentarIluminacion(otroFilosofo.iluminacion() / 10)
    }
}

object admirarPaisaje{
    method apply() {
    }
}

class MeditarBajoCascada {
    const altura
    method apply(filosofo){
        filosofo.aumentarIluminacion(10*altura)
    }
}

class Deporte {
    const property diasArejuvenecer
    method apply(filosofo){
        filosofo.rejuvenecer(diasArejuvenecer)
    }
}

object futbol inherits Deporte (diasArejuvenecer = 1) {}
object polo inherits Deporte (diasArejuvenecer = 2) {}
object waterpolo inherits Deporte (diasArejuvenecer = polo.diasArejuvenecer()*2) {} 


class Argumento {
    var descripcion
    var naturaleza 


    method esArgumentoEnriquecedor() = naturaleza.enriquecedor(self)
    method cantidadPalabras() = descripcion.words()
    method esPregunta() = descripcion.endsWith("?")
} 

object naturalezaEstoica {
    method enriquecedor(argumento) = true
}
object naturalezaMoralista {
    method enriquecedor(argumento) = argumento.cantidadPalabras() >= 10 
} 

object naturalezaEsceptica {
    method enriquecedor(argumento) = argumento.esPregunta()
}

class naturalezaMultiple {
    const naturalezas
    method enriquecedor(argumento) = naturalezas.all({naturaleza => naturaleza.enriquecedor(argumento)})
}

class Discusion {
  const partido1
  const partido2

  method esBuena() = partido1.esBueno() && partido2.esBueno()
}

class Partido {
  const filosofo
  const argumentos = []

  method esBueno() = filosofo.estaEnLoCorrecto() && self.tieneBuenosArgumentos()

  method tieneBuenosArgumentos() =
    self.cantidadArgumentosEnriquecedores() > self.cantidadArgumentos() / 2

  method cantidadArgumentos() = argumentos.size()

  method cantidadArgumentosEnriquecedores() = argumentos.count {
    argumento => argumento.esArgumentoEnriquecedor()
  }
}