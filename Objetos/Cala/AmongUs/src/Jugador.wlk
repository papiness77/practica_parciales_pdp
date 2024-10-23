class Jugador {
  var nivelSospecha = 40
  var mochila = []
  const color
  const nave
  
  method esSospechoso() = nivelSospecha > 50

  method buscarItem(item) {
    mochila.add(item)
  }

  method completoSusTareas()

  method realizarUnaTarea()

  method tieneItem(item) = mochila.contains(item)

  method levantarSospecha(cantidad) {
    nivelSospecha += cantidad
  }

  method bajarSospecha(cantidad) {
    nivelSospecha -= cantidad
  }

  method serImpugnado() {
    
  }

  method color() = color

  method llamarAReunion() {
    nave.realizarReunion()
  }
}