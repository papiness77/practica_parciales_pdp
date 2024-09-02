% Base de conocimiento

jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

% ---- 1 ---- %

% a
tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).

tieneItemComestible(Jugador, Comestible):-
    tieneItem(Jugador, Comestible),
    comestible(Comestible).

% b
sePreocupaPorSuSalud(Jugador):-
    tieneItemComestible(Jugador, Item1),
    tieneItemComestible(Jugador, Item2),
    Item1 \= Item2.

% c
existeItem(Item):-
    tieneItem(_, Item).

cantidadDeItem(Jugador, Item, Cantidad):-
    existeItem(Item),
    jugador(Jugador, _, _),
    findall(Item, tieneItem(Jugador, Item), ItemsBuscados),
    length(ItemsBuscados, Cantidad).

% d
tieneMasDe(Jugador, Item):-
    cantidadDeItem(Jugador, Item, CantidadMaxima),  
    forall(cantidadDeItem(_, Item, OtraCantidad), CantidadMaxima >= OtraCantidad).

% ---- 2 ---- %

% a
hayMonstruos(Lugar):-
    lugar(Lugar, _, NivelOscuridad),
    NivelOscuridad > 6.

% b
seEncuentraEn(Jugador, Lugar):-
    lugar(Lugar, Poblacion, _),
    member(Jugador, Poblacion).

estaHabriento(Jugador):-
    jugador(Jugador, _, NivelHambre),
    NivelHambre < 4.

correPeligro(Jugador):-
    seEncuentraEn(Jugador, Lugar),
    hayMonstruos(Lugar).

correPeligro(Jugador):-
    estaHabriento(Jugador),
    not(tieneItemComestible(Jugador, _)).

% c
cantidadHambrientos(Poblacion, Cantidad):-
    findall(Jugador, (member(Jugador, Poblacion), estaHabriento(Jugador)), Hambrientos),
    length(Hambrientos, Cantidad).

peligrosidadConPoblacion(Lugar, NivelPeligrosidad):-
    not(hayMonstruos(Lugar)),
    lugar(Lugar, Poblacion, _),
    length(Poblacion, Total),
    cantidadHambrientos(Poblacion, Hambrientos),
    NivelPeligrosidad is Hambrientos / Total * 100.

peligrosidadConPoblacion(Lugar, 100):-
    hayMonstruos(Lugar).

estaPoblado(Lugar):-
    lugar(Lugar, Poblacion, _),
    length(Poblacion, Cantidad),
    Cantidad > 0.

peligrosidad(Lugar, NivelPeligrosidad):-
    lugar(Lugar, _, NivelOscuridad),
    not(estaPoblado(Lugar)),
    NivelPeligrosidad is NivelOscuridad * 10.

peligrosidad(Lugar, NivelPeligrosidad):-
    lugar(Lugar, _, _),
    estaPoblado(Lugar),
    peligrosidadConPoblacion(Lugar, NivelPeligrosidad).

% ---- 3 ---- %

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).


puedeObtenerlo(itemSimple(Item, CantidadNecesaria), Jugador):-
    cantidadDeItem(Jugador, Item, CantidadQueTiene),
    CantidadQueTiene >= CantidadNecesaria.

puedeObtenerlo(itemCompuesto(Item), Jugador):-
    puedeConstruir(Jugador, Item).

puedeConstruir(Jugador, Item):-
    jugador(Jugador, _, _),
    item(Item, ItemsNecesarios),
    forall(member(ItemNecesario, ItemsNecesarios), puedeObtenerlo(ItemNecesario, Jugador)).