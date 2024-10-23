object nave {
  var nivelOxigeno = 50
  const jugadores = []
  var jugadoresVivos = jugadores
  
  method aumentarNivelOxigeno(cantidad) {
    nivelOxigeno += cantidad
  }

  method bajarNivelOxigeno(cantidad) {
    nivelOxigeno -= cantidad
  }

  method alguienTiene(item) {
    jugadores.anyOne().tieneItem(item)
  }

  method chequearVictoriaTripulantes() {
    if(self.todosCompletaronSusTareas()) {
      throw new Exception(message = "Ganaron los tripulantes :( )")
    }
  }

  method chequearVictoriaImpostores() {
    if(nivelOxigeno <= 0) {
      throw new Exception(message = "Ganaron los impostores carajo!!!!) )")
    }
  }

  method todosCompletaronSusTareas() = jugadores.all{ jugador => jugador.completoSusTareas() }

  method impugnarA(color) {
    jugadores.find{jugador => jugador.color() == color}.serImpugnado()
  }

  method realizarReunion() {
    const votaciones = self.realizarVotacion()
    const recuento = self.contarVotos(votaciones)
    if(recuento.max{  })
  }

  method realizarVotacion() = jugadoresVivos.map{ jugador => jugador.votar() }

  method contarVotos(votacion) = self.posiblesVotos().map{ color => votacion.occurrencesOf(color)}



  method posiblesVotos() = jugadoresVivos.map{ jugador => jugador.color() }.add("enBlanco")

}