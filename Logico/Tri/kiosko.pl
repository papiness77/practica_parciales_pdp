% dodain atiende lunes, miércoles y viernes de 9 a 15.
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

% lucas atiende los martes de 10 a 20
atiende(lucas, martes, 10, 20).

% juanC atiende los sábados y domingos de 18 a 22.
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).

% juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

% leoC atiende los lunes y los miércoles de 14 a 18.
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

% martu atiende los miércoles de 23 a 24.
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HoraInicio, HoraFin):-
    atiende(dodain, Dia, HoraInicio, HoraFin).

atiende(vale, Dia, HoraInicio, HoraFin):-
    atiende(juanC, Dia, HoraInicio, HoraFin).


quienAtiende(Dia, Hora, NombrePersona):-
    atiende(NombrePersona, Dia, HoraInicio, HoraFin),
    between(HoraInicio, HoraFin, Hora).

foreverAlone(Dia, Hora, NombrePersona):-
    quienAtiende(Dia, Hora, NombrePersona),
    not((quienAtiende(Dia, Hora, OtraPersona), OtraPersona \= NombrePersona)).



venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).
    
vendedorSuertudo(NombrePersona):-
    atiende(NombrePersona, _, _, _),
    forall(venta(NombrePersona, _, Ventas), primeraVentaEsImportante(Ventas)).

primeraVentaEsImportante([PrimeraVenta | Cola]):-
    ventaImportante(PrimeraVenta).

ventaImportante(golosinas(Precio)):- Precio > 100.
ventaImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.

ventaImportante(bebidas(true, _)).
ventaImportante(bebidas(false, Cantidad)):- Cantidad > 5.