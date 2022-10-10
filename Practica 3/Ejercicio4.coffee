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
    bool positivo = true;
    int cant = 0;
    cola colaPeso;

    procedure ingresar (peso: in int){
        int pesoAux = pesoDisponible - peso;
        if (positivo && pesoAux < 0){
            positivo = false;
        }
        if (positivo) {
            pesoDisponible = pesoDisponible - peso;
        } else {
            cant++;
            push(colaPeso, peso);
            wait (cola);
        }
    }

    procedure salir (peso : in int) {
        int pesoAux;
        if (cant==0){
            positivo = true;
        } else{
            if ((pesoDisponible - colaPeso.tope()) < 0){
                cant--;
                pop(colaPeso)
                signal(cola);
            }
        }
        pesoDisponible = pesoDisponible + peso;
    }
}