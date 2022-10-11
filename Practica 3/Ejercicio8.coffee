###
Se debe simular una maratón con C corredores donde en la llegada hay UNA máquina
expendedoras de agua con capacidad para 20 botellas. Además, existe un repositor encargado
de reponer las botellas de la máquina. Cuando los C corredores han llegado al inicio comienza
la carrera. Cuando un corredor termina la carrera se dirigen a la máquina expendedora, espera
su turno (respetando el orden de llegada), saca una botella y se retira. Si encuentra la máquina
sin botellas, le avisa al repositor para que cargue nuevamente la máquina con 20 botellas;
espera a que se haga la recarga; saca una botella y se retira. Nota: mientras se reponen las
botellas se debe permitir que otros corredores se encolen
###

process corredor [ID: 1..C]{
    Carrera.llega();
    # Corriendo
    Maquina.tomaBotella();
    # Esperando a que la maquina le de la botella
    Maquina.finaliza();
}

process repositor {
    while true {
        Maquina.cargaMaquina();
        # Cargando la maquina
        Maquina.finalizaCarga();
    }
}

Monitor Carrera {
    int esperando = 0;
    cond cola;

    procedure llega (){
        esperando++;
        if (esperando < C){
            wait(cola);
        } else {
            signal_all(cola);
        }
    }
}

Monitor Maquina {
    int botellas = 20;
    int esperando = 0;
    int libre = true;
    cond cola;
    cond primero;
    cond espera;

    procedure llegaMaquina (){
        if (!libre){
            esperando++;
            wait(cola);
        } else {
            libre = false;
        }
        if (botellas == 0){
            signal(espera);
            wait(primero);
        botellas--;
    }

    procedure finaliza (){
        if (esperando == 0){
            libre = true
        } else {
            signal(cola);
        }
    }

    procedure cargaMaquina (){
        if (botellas>0){
            wait(espera);
        }
    }

    procedure finalizaCarga (){
        botellas = 20;
        signal(primero);
    }
}