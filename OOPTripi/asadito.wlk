class Comida {
    const property nombre
    const property calorias
    const property carne //booleano

    method esPesada() = calorias > 500
}


class Persona {
    var property  posicion
    const property elementosCercanos = []
    var property criterio 

    const property registroComidas = []
    var property criterioComida

    method tieneElElemento(elemento) = elementosCercanos.contains(elemento)

    method primerElemento() = elementosCercanos.first()

    method obtenerElemento(elemento) = elementosCercanos.add(elemento) 

    method quitarElemento(elemento) = elementosCercanos.remove(elemento)

    method quitarTodosLosElementos() = elementosCercanos.clear()

    method estaPipon() = registroComidas.any({comida => comida.esPesada()})

    method como(comida){
        if(criterio.decideComer(comida)) registroComidas.add(comida)
    }

    method realizarCambioElemento(elemento, receptor){
        receptor.obtenerElemento(elemento)
        self.quitarElemento(elemento)   
    } 

    method pedir(elemento, otraPersona){
        if(otraPersona.tieneElElemento(elemento)){
            otraPersona.criterio().pasar(elemento, self, otraPersona)
        }
    }
}

object sordo {
    method pasar(elemento, receptor, dador){
        dador.realizarCambioElemento(dador.primerElemento(), receptor)
    } 
}

object molesto {
    method pasar(elemento, persona, otraPersona){
        persona.elementosCercanos().forEach({elemento => otraPersona.obtenerElemento(elemento)})
        persona.quitarTodosLosElementos()
    }
}

object cambiante {
    method pasar(elemento, persona, otraPersona){
        var posicionVieja = persona.posicion()
        persona.posicion(otraPersona.posicion())
        otraPersona.posicion(posicionVieja)
    }
}

object loHaceBien {
    method pasar(elemento, receptor, dador){
        dador.realizarCambioElemento(elemento, receptor)
    }
}

object vegetariano {
    method decideComer(comida) = not(comida.carne()) 
}
object dietetico {
    var caloriasOMS = 500

    method decideComer(comida) = comida.calorias() < caloriasOMS
}
object alternado {
    var eleccionPrevia = true

    method decideComer(comida){
        eleccionPrevia = !eleccionPrevia

        return eleccionPrevia
    }
}

object combinado {
    const combinacion = []

    method decideComer(comida) = combinacion.all({criterio => criterio.decideComer(comida)})
}
