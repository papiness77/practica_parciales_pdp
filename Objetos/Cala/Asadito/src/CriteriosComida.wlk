object vegetariano {
  method tomarDecision(unaComida) = not unaComida.esCarne()
}

object dietetico {
  const caloriasRecomendadas = 500

  method tomarDecision(unaComida) = unaComida.calorias() < caloriasRecomendadas
}

class Alternado {
  var aceptar = true

  method tomarDecision(_unaComida) {
    aceptar = !aceptar

    return !aceptar
  }
}

class Combinacion {
  const condiciones = []

  method tomarDecision(unaComida) = condiciones.all{ condicion => condicion.tomarDecision(unaComida) }
}