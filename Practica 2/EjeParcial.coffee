###
Resolver con SEMAFOROS el siguiente problema, Hay N personas que deben usar un teléfono publico de a una a la vez y de acuerdo al orden de llegada, pero dando prioridad a las que tienen que usarlo con urgencia (cada persona ya sabe al comenzar si es de tipo urgente o no). Nota: suponga que la persona tiene una funcion Usar_Teléfono que simula el uso del teléfono.
###

Cola c;
sem mutex = 1;
bool libre = true;
sem espera[N] = 0;

process personas [ID: 1..N] {
    bool urgencia;
    int aux;

    P(mutex);
    if (libre){
        libre = false;
        V(mutex);
    } else {
        insertar_ordenado(c,urgencia, ID);
        V(mutex);
        P(espera[ID]);
    }
    Usar_Telefono();
    P(mutex);
    if (empty(C)){
        libre = true;
    } else {
        aux = pop(c);
        V(espera[aux]);
    }
    V(mutex);
}