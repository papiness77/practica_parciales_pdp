object arreglarTablero {
  
  method cumpleRequerimientos(jugador) = jugador.tieneItem("llaveInglesa")

  method serRealizada(jugador) {
    jugador.levantarSospecha(10)
  }
}

object sacarBasura {
  method cumpleRequerimientos(jugador) = jugador.tieneItem("escoba") && jugador.tieneItem("bolsaDeConsorcio")

  method serRealizada(jugador) {
    jugador.bajarSospecha(4)
  }
}

object ventilarNave {
  method cumpleRequerimientos(jugador) = true

  method serRealizada(jugador) {
    jugador.nave().aumentarNivelOxigeno(5)
  }
}