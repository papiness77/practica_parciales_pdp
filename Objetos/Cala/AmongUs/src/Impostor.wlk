import src.Jugador.*

class Impostor inherits Jugador {
  
  override method completoSusTareas() = true

  override method realizarUnaTarea() {
    
  }

  method realizarSabotaje(sabotaje) {
    sabotaje.serRealizado(nave)
    self.levantarSospecha(5)
  }
}