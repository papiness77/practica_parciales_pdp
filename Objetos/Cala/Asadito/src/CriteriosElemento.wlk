object sordo {
  method pasarElemento(comensalDador, comensalReceptor, _elementoPedido) {
    comensalReceptor.recibir(comensalDador.primerElemento())
  }
}

object pasarTodos {
  method pasarElemento(comensalDador, comensalReceptor, _elementoPedido) {
    comensalDador.elementos().forEach{ elemento => comensalReceptor.recibir(elemento)}
  }
}

object intercambiarLugares {
  method pasarElemento(comensalDador, comensalReceptor, _elementoPedido) {
    comensalDador.cambiarPosicionCon(comensalReceptor)
  }
}

object pasarBien {
  method pasarElemento(_comensalDador, comensalReceptor, elementoPedido) {
    comensalReceptor.recibir(elementoPedido)
  }
}
