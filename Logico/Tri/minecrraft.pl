jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

esJugador(Jugador):-
    jugador(Jugador, _, _).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).

itemComestibleEnInventario(Jugador, Item):-
    esJugador(Jugador),
    tieneItem(Jugador, Item),
    comestible(Item).

sePreocupaPorSuSalud(Jugador):-
    esJugador(Jugador),
    itemComestibleEnInventario(Jugador, Item1),
    itemComestibleEnInventario(Jugador, Item2),
    Item1 \= Item2.

cantidadDelItem(Jugador, Item, Cantidad):-
    tieneItem( _, Item),
    esJugador(Jugador),
    findall(Item, tieneItem(Jugador, Item), ItemsBuscados),
    length(ItemsBuscados, Cantidad).

tieneMasDe(Jugador, Item):-
    cantidadDelItem(Jugador, Item, Cantidad),
    forall(cantidadDelItem(_, Item, CantidadOtra), Cantidad >= CantidadOtra).

hayMonstruos(Lugar):-
    lugar(Lugar, _, Oscuridad),
    Oscuridad > 6.

dondeEstaJugador(Jugador, Lugar):-
    esJugador(Jugador),
    lugar(Lugar, Jugadores, _),
    member(Jugador, Jugadores).

correPeligro(Jugador):-
    esJugador(Jugador), 
    dondeEstaJugador(Jugador, Lugar),
    hayMonstruos(Lugar).

correPeligro(Jugador):-
    esJugador(Jugador), 
    tieneHambre(Jugador),
    not(itemComestibleEnInventario(Jugador, _)).

tieneHambre(Jugador):-
    jugador(Jugador, _, Hambre),
    Hambre < 4.



cantidadHambrientosLugar(Lugar, Cantidad):-
    lugar(Lugar, Jugadores, _),
    findall(Hambriento, (member(Hambriento, Jugadores), tieneHambre(Hambriento)), Hambrientos),
    length(Hambrientos, Cantidad).

cantidadJugadoresLugar(Lugar, Cantidad):-
    lugar(Lugar, Jugadores, _),
    length(Jugadores, Cantidad).

nivelPeligrosidad(Lugar, 100):-
    hayMonstruos(Lugar).

nivelPeligrosidad(Lugar, NIvel):-
    not(hayMonstruos(Lugar)),
    cantidadHambrientosLugar(Lugar, CantidadHambrientos),
    cantidadJugadoresLugar(Lugar, CantidadJugadores),
    CantidadJugadores \= 0, 
    NIvel is (CantidadHambrientos/CantidadJugadores)*100.

nivelPeligrosidad(Lugar, Nivel):-
    cantidadJugadoresLugar(Lugar, 0),
    lugar(Lugar, _, Oscuridad),
    Nivel is Oscuridad*10.

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).


puedeConstruir(Jugador, Item):-
    item(Item, Materiales),
    forall( member(Material, Materiales), tieneLoNecesario(Jugador, Material)).

tieneLoNecesario(Jugador, itemSimple(Material, Cantidad)):-
    cantidadDelItem(Jugador, Material, CantidadObtenida),
    CantidadObtenida >= Cantidad.

tieneLoNecesario(Jugador, itemCompuesto(Item)):-
    puedeConstruir(Jugador, Item).


