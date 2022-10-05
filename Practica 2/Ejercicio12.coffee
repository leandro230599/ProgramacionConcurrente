###
Simular la atención en una Terminal de Micros que posee 3 puestos para hisopar a 150
pasajeros. En cada puesto hay una Enfermera que atiende a los pasajeros de acuerdo
con el orden de llegada al mismo. Cuando llega un pasajero se dirige al puesto que tenga
menos gente esperando. Espera a que la enfermera correspondiente lo llame para
hisoparlo, y luego se retira. Nota: sólo deben usar procesos Pasajero y Enfermera.
Además, suponer que existe una función Hisopar() que simula la atención del pasajero por
parte de la enfermera correspondiente.
###

sem mutexCola = 1;
sem mutexCantidad = 1;
cola C;
int cola_por_puestos[3][C]; # Arreglo de 3 colas
int cantidad_por_puesto[3] = ([3],0);
sem esperando[3] = ([3],0);
sem vacunado[150] = ([150],0);

process Pasajeros [ID: 0..149]{
    int menorCantidad = 999;
    int indexMenor;
    int i;
    P(mutexCantidad);
    for i = 0..2 {
        if (cantidad_por_puesto[i] < menorCantidad){
            menorCantidad = cantidad_por_puesto[i];
            indexMenor = i;
        }
    }
    V(mutexCantidad);
    P(mutexCola);
    push(ID, cola_por_puestos[indexMenor]);
    V(mutexCola);
    P(mutexCantidad);
    cantidad_por_puesto[indexMenor]++;
    V(mutexCantidad);
    V(esperando[indexMenor]);
    P(vacunado[ID]);
}

process Enfermera [ID: 0..2] {
    int id_Paciente;
    while true {
        P(esperando[ID]);
        P(mutexCola);
        id_Paciente = pop(cola_por_puestos[ID]);
        V(mutexCola);
        P(mutexCantidad);
        cantidad_por_puesto[ID]--;
        V(mutexCantidad);
        Hisopar(id_Paciente);
        V(vacunado[id_Paciente]);
    }
}