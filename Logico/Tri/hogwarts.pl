%mago(nombre, sangre, preferencia).

mago(harry, mestizo, slytherin).
mago(draco, pura, hufflepuff).
mago(hermione, impura, niguna).

caracteristica(harry, coraje).
caracteristica(harry, orgulloso).
caracteristica(harry, amistoso).
caracteristica(harry, inteligente).

caracteristica(draco, inteligente).
caracteristica(draco, orgulloso).

caracteristica(hermione, inteligente).
caracteristica(hermione, orgulloso).
caracteristica(hermione, responsable).

casa(gryfindor, coraje).

casa(slytherin, orgulloso).
casa(slytherin, inteligente).

casa(ravenclaw, inteligente).
casa(ravenclaw, responsable).

casa(hufflepuff, amistoso).

esCasa(Casa):-
    casa(Casa, _).

esMago(NombreMago):-
    mago(NombreMago, _, _).

permite(Casa, Mago):-
    esCasa(Casa),
    esMago(Mago),
    casa(Casa, _),
    Casa \= slytherin.

permite(slytherin, Mago):-
    esMago(Mago),
    mago(Mago, Sangre, _),
    Sangre \= impura.


esApropiado(Mago, Casa):-
    esMago(Mago),
    esCasa(Casa),
    forall(casa(Casa, Caracteristica), caracteristica(Mago, Caracteristica)).

seleccionado(Mago, Casa):-
    esMago(Mago),
    esCasa(Casa),
    permite(Casa, Mago),
    esApropiado(Mago, Casa),
    not(mago(Mago, _, Casa)).

seleccionado(hermione, gryfindor).

cadenaDeAmistades(Magos):-
    sonTodosAmistosos(Magos),
    podrianEstarEnLaCasaDelSiguiente(Magos).

sonTodosAmistosos(Magos):-
    forall(member(Mago, Magos), caracteristica(Mago, amistoso)).


podrianEstarEnLaCasaDelSiguiente([]).
podrianEstarEnLaCasaDelSiguiente([X]).
podrianEstarEnLaCasaDelSiguiente([Mago, SiguienteMago | Magos]):-
    esApropiado(Mago, Casa),
    esApropiado(SiguienteMago, Casa),
    podrianEstarEnLaCasaDelSiguiente(Magos).



