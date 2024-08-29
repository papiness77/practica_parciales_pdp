% ---- 1 ---- %
turno(dodain, lunes, 9, 15).
turno(dodain, miercoles, 9, 15).
turno(dodain, viernes, 9, 15).

turno(lucas, martes, 10, 20).

turno(juanC, sabado, 18, 22).
turno(juanC, domingo, 18, 22).

turno(juanFds, jueves, 10, 20).
turno(juanFds, viernes, 12, 20).

turno(leoC, lunes, 14, 18).
turno(leoC, miercoles, 14, 18).

turno(martu, miercoles, 23, 24).

turno(vale, Dia, Inicio, Fin):-
    turno(dodain, Dia, Inicio, Fin).

turno(vale, Dia, Inicio, Fin):-
    turno(juanC, Dia, Inicio, Fin).

% Por principio de universo cerrado, como Maiu no sabe el horario, no forma parte de nuestra base de conocimiento ya que no tiene un
% turno definido.

% ---- 2 ---- %
persona(Persona):-
    turno(Persona, _, _, _).

dia(lunes).
dia(martes).
dia(miercoles).
dia(jueves).
dia(viernes).
dia(sabado).
dia(domingo).

atiende(Dia, Hora, Persona):-
    dia(Dia),
    persona(Persona),
    turno(Persona, Dia, Inicio, Fin),
    between(Inicio, Fin, Hora).

% ---- 3 ---- %
atiendeOtroMas(Dia, Hora, Persona):-
    atiende(Dia, Hora, OtraPersona),
    OtraPersona \= Persona.

foreverAlone(Dia, Hora, Persona):-
    dia(Dia),
    persona(Persona),
    atiende(Dia, Hora, Persona),
    not(atiendeOtroMas(Dia, Hora, Persona)).

% ---- 5 ---- %
vendio(dodain, lunes, 10, [golosina(1200), cigarillos([jockey]), golosina(50)]).

vendio(dodain, miercoles, 12, [bebida(alcoholica, 8), bebida(noAlcoholica, 1), golosina(10)]).

vendio(martu, miercoles, 12, [golosina(1000), cigarillos([chesterfield, colorado, parisiennes]) ]).

vendio(lucas, martes, 11, golosina(600)).

vendio(lucas, martes, 18, [bebida(noAlcoholica, 2), cigarillos([derby])]).

ventaImportante(golosina(Precio)):-
    Precio > 100.

ventaImportante(cigarillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.

ventaImportante(bebida(alcoholica, _)).
ventaImportante(bebida(_, Cantidad)):-
    Cantidad > 5.

suertudo(Persona):-
    persona(Persona),
    vendio(Persona, _, _, Ventas),
    nth1(1, Ventas, PrimerVenta),
    ventaImportante(PrimerVenta).

    
