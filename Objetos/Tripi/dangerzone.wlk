
class Empleado {
    const property habilidades = #{}
    var property salud
    var property puesto

    method estaIncapacitado() = self.salud() < self.puesto().saludCritica()

    method poseeHabilidad(habilidad) = self.habilidades().contains(habilidad)

    method puedeUsarHabilidad(habilidad) = not(self.estaIncapacitado()) && self.poseeHabilidad(habilidad) 

    method recibirDanio(danio) { salud -= danio }

    method cumplir(mision) = self.puesto().cumplirMisionPuesto(self, mision)

    method aprenderHabilidades(habilidadesaAprender) = habilidadesaAprender.forEach({habilidad => self.aprenderHabilidad(habilidad)})

    method aprenderHabilidad(habilidad) = self.habilidades().add(habilidad)
    
    method ascenderAEspia() { puesto = espia }


}

class Jefe inherits Empleado {
    const property subordinados = []

    method subordinadoPuedeUsarHabilidad(habilidad) = self.subordinados().any({subordinado => subordinado. puedeUsarHabilidad(habilidad)}) 

    override method puedeUsarHabilidad(habilidad) = super(habilidad) || self.subordinadoPuedeUsarHabilidad(habilidad)
}

object espia {
    const property saludCritica = 15

    method cumplirMisionPuesto(persona, mision) {
        persona.aprenderHabilidades(mision.habilidadesRequeridas())
    } 
    
}

class Oficinista {
    var estrellas = 0
    
    method saludCritica() = 40 - 5 * estrellas 

    method cumplirMisionPuesto(persona, mision) { 
        estrellas += 1 
        if(estrellas == 3) {
            persona.ascenderAEspia()
        }
    }

}

class Mision {
    const equipo = []
    const property habilidadesRequeridas = []
    var peligrosidad

    method puedenCumplirMision() = self.habilidadesRequeridas().all({habilidad => equipo.any({miembro => miembro.puedeUsarHabilidad(habilidad)})})

    
    method cumplirMision(){


    }
}
