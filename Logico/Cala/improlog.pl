integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

% ---- 1 ---- %

tipoInstrumentoEnLaBanda(Integrante, Grupo, Tipo):-
    integrante(Grupo, Integrante, Instrumento),
    instrumento(Instrumento, Tipo).

buenaBase(Grupo):-
    /* integrante(Grupo, Integrante, Instrumento),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    instrumento(Instrumento, ritmico),
    instrumento(OtroInstrumento, armonico), */
    tipoInstrumentoEnLaBanda(Grupo, Integrante, ritmico),
    tipoInstrumentoEnLaBanda(Grupo, OtroIntegrante, armonico),
    Integrante \= OtroIntegrante.

% ---- 2 ---- %

nivelEnLaBanda(Integrante, Grupo, Nivel):-
    integrante(Grupo, Integrante, Instrumento),
    nivelQueTiene(Integrante, Instrumento, Nivel).

masDeDos(Numero, OtroNumero):-  
    NumeroComparable is OtroNumero + 2,
    Numero > NumeroComparable.

seDestaca(Integrante, Grupo):-
    nivelEnLaBanda(Integrante, Grupo, Nivel),
    forall((nivelEnLaBanda(OtroIntegrante, Grupo, OtroNivel), OtroIntegrante \= Integrante), masDeDos(Nivel, OtroNivel)).

% ---- 3 ---- %

grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])).
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).

% 8
grupo(estudio1, ensamble(3)).

% ---- 4 ---- %

sirveParaElGrupo(Grupo, Instrumento):-
    grupo(Grupo, formacion(Instrumentos)),
    member(Instrumentos, Instrumento).

sirveParaElGrupo(Grupo, Instrumento):-
    grupo(Grupo, bigBand),
    member([bateria, bajo, piano], Instrumento).

% 8
sirveParaElGrupo(Grupo, _):-
    grupo(Grupo, ensamble(_)).

hayCupo(Grupo, Instrumento):-
    grupo(Grupo, bigBand),
    instrumento(Instrumento, melodico(viento)).

hayCupo(Grupo, Instrumento):-
    grupo(Grupo, formacion()),
    not(integrante(Grupo, _, Instrumento)),
    sirveParaElGrupo(Grupo, Instrumento).

% ---- 5 ---- %

% 8
nivelNecesario(ensamble(NivelMinimo), NivelMinimo).

nivelNecesario(bigBand, Nivel):-
    Nivel >= 1.

nivelNecesario(formacion(Instrumentos), Nivel):-
    length(Instrumentos, CantidadInstrumentos),
    NivelMinimo is 7 - CantidadInstrumentos,
    Nivel >= NivelMinimo. 

puedeIncorporarse(Persona, Grupo, Instrumento):-
    not(integrante(Persona, Grupo, _)),
    grupo(Grupo, Tipo),
    hayCupo(Grupo, Instrumento),
    nivelQueTiene(Integrante, Integrante, Nivel),
    nivelNecesario(Tipo, Nivel).

% ---- 6 ---- %

quedoEnBanda(Persona):-
    not(integrante(_, Persona, _)),
    not(puedeIncorporarse(Persona, _, _)).

% ---- 7 ---- %    

puedeTocar(Grupo):-
    grupo(Grupo, bigBand),
    buenaBase(Grupo),
    findall(Integrante, tipoInstrumentoEnLaBanda(Integrante, Grupo, melodico(viento)), IntegrantesTocanViento),
    length(IntegrantesTocanViento, CantidadTocanViento),
    CantidadTocanViento >= 5.

puedeTocar(Grupo):-
    grupo(Grupo, formacion(Instrumentos)),
    forall(member(Instrumento, Instrumentos), integrante(Grupo, _, Instrumento)).

% 8
puedeTocar(Grupo):-
    grupo(Grupo, ensamble(_)),
    buenaBase(Grupo),
    tipoInstrumentoEnLaBanda(_, Grupo, melodico(_)).
