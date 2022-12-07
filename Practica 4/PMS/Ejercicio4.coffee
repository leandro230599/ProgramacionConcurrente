### En una exposición aeronáutica hay un simulador de vuelo (que debe ser usado con
exclusión mutua) y un empleado encargado de administrar su uso. Hay P personas que
esperan a que el empleado lo deje acceder al simulador, lo usa por un rato y se retira. El
empleado deja usar el simulador a las personas respetando el orden de llegada. Nota: cada
persona usa sólo una vez el simulador. ###

process Personas [ID:1..P] {
    Admin!encolar(ID);
    Empleado?permiso();
    usaSimulador();
    Empleado!termino();
}

process Empleado {
    int idPersona;

    while true {
        Admin!pedido();
        Admin?turnoPersona(idPersona);
        Personas[idPersona]!permiso();
        Personas[idPersona]?termino();
    }
}

process Admin {
    cola buffer;
    int idPersona;

    do Personas[*]encolar(idPersona) → push(buffer, idPersona);
    □ not empty (buffer); Empleado?pedido() → pop(buffer, idPersona);
                                                Empleado!turnoPersona(idPersona);

}