###
Existen N vehículos que deben pasar por un puente de acuerdo con el orden de llegada.
Considere que el puente no soporta más de 50000kg y que cada vehículo cuenta con su propio
peso (ningún vehículo supera el peso soportado por el puente). 
###

process vehiculos [ID:0..N-1]{
    Puente.ingresar(peso);
    # Pasa por el puente
    Puente.salir(peso);
}

Monitor Puente {
    int pesoDisponible = 50000;
    cond cola;

    procedure ingresar (peso: in int){
        while ((pesoDisponible-peso)<0){
            wait(cola);
        }
        pesoDisponible = pesoDisponible-peso;
    }

    procedure salir (peso : in int) {
        pesoDisponible = pesoDisponible + peso;
        signal(cola);
    }
}