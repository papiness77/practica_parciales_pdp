import src.Jugador.*


class Tripulante inherits Jugador {
  const tareasPendientes
  
  override method completoSusTareas() = tareasPendientes.isEmpty()

  override method realizarUnaTarea() {
    if(self.tieneTareasRealizables()) {
      const tareaARealizar = self.tareasRealizables().anyOne()
      self.realizarTarea(tareaARealizar)
      nave.chequearVictoriaTripulantes()
    }
  }

  method realizarTarea(tarea) {
    tarea.serRealizada(self)
    tareasPendientes.remove(tarea)
  }

  method tieneTareasRealizables() = not self.tareasRealizables().isEmpty()

  method tareasRealizables() = tareasPendientes.filter{ tarea => self.puedeRealizarTarea(tarea) }

  method puedeRealizarTarea(tarea) {
    tarea.cumpleRequerimientos(self)
  }
}