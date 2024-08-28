%juego(precio, nombre, tipo, decuento)
juego(200, csgo, accion, 50).
juego(100, lol, rol(1000), 0).
juego(50, outerWilds, puzzle(facil, 10), 60).

cuantoSale(NombreJuego, PrecioFinal):-
    juego(PrecioNormal, NombreJuego, _, Descuento),
    PrecioFinal is PrecioNormal - PrecioNormal * Descuento.

tieneBuenDescuento(NombreJuego):-
    juego(_, NombreJuego, _, Descuento),
    Descuento >= 50.

esPopular(NombreJuego):-juego(_, NombreJuego, accion, _).

esPopular(NombreJuego):-
    juego(_, NombreJuego, rol(Jugadores), _),
    Jugadores > 1000000.

esPopular(NombreJuego):- juego(_, NombreJuego, puzzle(facil, _), _).
esPopular(NombreJuego):- juego(_, NombreJuego, puzzle(_, 25), _).

esPopular(minecraft).
esPopular(counter).


posee(vegeta, minecraft).
desea(vegeta, outerWilds, paraSiMismo).
desea(vegeta, csgo, regalo(willy)).

esUsuario(NombreUsuario):- posee(NombreUsuario, _).
esUsuario(NombreUsuario):- desea(NombreUsuario, _, _).

adictoALosDecuentos(NombreUsuario):-
    esUsuario(NombreUsuario),
    forall(desea(NombreUsuario, NombreJuego, _), tieneBuenDescuento(NombreJuego)).

fanaticoGenero(NombreUsuario, Genero):-
    posee(NombreUsuario, NombreJuego1),
    posee(NombreUsuario, NombreJuego2),
    NombreJuego1 \= NombreJuego2,
    sonDelMismoGenero(NombreJuego1, NombreJuego2),
    juego(_, NombreJuego1, Genero, _).

sonDelMismoGenero(NombreJuego1, NombreJuego2):-
    juego(_, NombreJuego1, accion, _),
    juego(_, NombreJuego2, accion, _).
sonDelMismoGenero(NombreJuego1, NombreJuego2):-
    juego(_, NombreJuego1, rol(_), _),
    juego(_, NombreJuego2, rol(_), _).
sonDelMismoGenero(NombreJuego1, NombreJuego2):-
    juego(_, NombreJuego1, puzzle(_,_), _),
    juego(_, NombreJuego2, puzzle(_,_), _).

monoTematico(NombreUsuario):-
    posee(NombreUsuario, NombreJuego),
    forall(posee(NombreUsuario, NombreJuego2), sonDelMismoGenero(NombreJuego, NombreJuego2)).

buenosAmigos(NombreUsuario1, NombreUsuario2):-
    desea(NombreUsuario1, NombreJuego1, regalo(NombreUsuario2)),
    desea(NombreUsuario2, NombreJuego2, regalo(NombreUsuario1)),
    esPopular(NombreJuego1),
    esPopular(NombreJuego2).

cuantoGastara(NombreUsuario, Gasto):-
    esUsuario(NombreUsuario),
    findall(Precio, (desea(NombreUsuario, NombreJuego, _), cuantoSale(NombreJuego, Precio)), Precios),
    sum_list(Precios, Gasto).

