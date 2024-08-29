%-------------------%
% ---- PARTE 1 ---- %
%-------------------%

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

caracteristicas(harry, corajudo).
caracteristicas(harry, amistoso).
caracteristicas(harry, orgulloso).
caracteristicas(harry, inteligente).

caracteristicas(draco, inteligente).
caracteristicas(draco, orgulloso).

caracteristicas(hermione, inteligente).
caracteristicas(hermione, orgulloso).
caracteristicas(hermione, responsable).

odia(harry, slytherin).
odia(draco, hufflepuff).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

requisito(gryffindor, corajudo).
requisito(slytherin, orgulloso).
requisito(slytherin, inteligente).
requisito(ravenclaw, inteligente).
requisito(ravenclaw, responsable).
requisito(hufflepuff, amistoso).

% ---- 1 ---- %
mago(Mago):-
    sangre(Mago, _).

puedeEntrar(Mago, slytherin):-
    sangre(Mago, Tipo),
    Tipo \= impura.

puedeEntrar(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

% ---- 2 ---- %
caracterApropiado(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    forall(requisito(Casa, Caracteristica), caracteristicas(Mago, Caracteristica)).

% ---- 3 ---- %
puedenElegirlo(hermione, gryffindor).

puedenElegirlo(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    caracterApropiado(Mago, Casa),
    not(odia(Mago, Casa)).

% ---- 4 ---- %
relacionadosPorCasas(Magos, Indice1, Indice2):-
    length(Magos, Largo),
    Indice2 =< Largo,
    nth1(Indice1, Magos, Mago1),
    nth1(Indice2, Magos, Mago2),
    puedeEntrar(Mago1, Casa),
    puedeEntrar(Mago2, Casa),
    Indice1 is Indice1 + 1,
    Indice2 is Indice2 + 2,
    relacionadosPorCasas(Magos, Indice1, Indice2).

cadenaDeAmistades(Magos):-
    forall(member(Mago, Magos), caracteristicas(Mago, amistoso)),
    relacionadosPorCasas(Magos, 1, 2).

%-------------------%
% ---- PARTE 2 ---- %
%-------------------%
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

accion(harry, mal(fueraDeCama)).
accion(harry, mal(tercerPiso)).
accion(harry, mal(bosque)).
accion(harry, bien(vencerVoldemort, 60)).

accion(hermione, mal(tercerPiso)).
accion(hermione, mal(seccionRestringidaBiblioteca)).
accion(hermione, bien(salvarAmigos, 50)).

accion(draco, mazmorras).

accion(ron, bien(ganarAjedrez, 50)).

% ---- 1 ---- %

% a %
buenAlumno(Mago):-
    mago(Mago),
    not(accion(Mago, mal(_))).

% b %
hizoAccion(Mago, Accion):-
    accion(Mago, mal(Accion)).

hizoAccion(Mago, Accion):-
    accion(Mago, Accion).

hizoAccion(Mago, Accion):-
    accion(Mago, bien(Accion, _)).

recurrente(Accion):-
    hizoAccion(_, Accion),
    hizoAccion(Mago, Accion),
    hizoAccion(OtroMago, Accion),
    Mago \= OtroMago.

% ---- 2 ---- %
calcularPuntos(bien(_, Puntos), Puntos).

calcularPuntos(Accion, 0).

calcularPuntos(mal(fueraDeCama), -50).
calcularPuntos(mal(bosque), -50).
calcularPuntos(mal(seccionRestringidaBiblioteca), -10).
calcularPuntos(mal(tercerPiso), -75).

puntosMago(Mago, Puntos):-
    findall(Punto, (accion(Mago, Accion), calcularPuntos(Accion, Punto)), ListaPuntosMago),
    sum_list(ListaPuntosMago, Puntos).

puntajeTotal(Casa, Puntos):-
    esDe(_, Casa),
    findall(Punto, (esDe(Mago, Casa), puntosMago(Mago, Punto)), ListaPuntos),
    sum_list(ListaPuntos, Puntos).

% ---- 3 ---- %
ganoLaCopa(Casa):-
    esDe(_, Casa),
    puntajeTotal(Casa, PuntosCasa),
    forall(puntajeTotal(_, PuntosOtraCasa), PuntosCasa >= PuntosOtraCasa).

% ---- 4 ---- %
accion(hermione, pregunta(dondeEstaBezoar, 20, snape)).
accion(hermione, pregunta(comoLevitarPluma, 25, flitwick)).

calcularPuntos(pregunta(_, Puntos, Profesor), Puntos):-
    Profesor \= snape.

calcularPuntos(pregunta(_, PuntosBase, snape), Puntos):-
    Puntos is PuntosBase / 2.
