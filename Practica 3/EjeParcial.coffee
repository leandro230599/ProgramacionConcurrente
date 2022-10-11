###
Resolver con MONITORES la siguiente situacién. En una guardia de hospital hay 3 médicos, y acuden P Pacientes a ser atendidos de acuerdo al orden de llegada por cualquiera de los médicos. Cuando el paciente llega espera su turno, se dirige al consultorio del médico correspondiente, y cuando lo terminan de atender se retira. Cuando un médico esta libre atiende al siguiente paciente que haya llegado a la guardia. Nota: maximizar la concurrencia; nunca puede haber mas de un paciente en un mismo consultorio; suponga que existe una funcion AtenderPaciente() que simula el momento en que el médico esta atendiendo a un paciente.
###

process pacientes [ID: 1..P]{
    int medicoAsignado;

    Guardia.llegaPaciente(medicoAsignado);
    Consultorio[medicoAsignado].serAtendido();
}

process medicos [ID: 1..3]{
    while true {
        Guardia.atender(ID);
        Consultorio[ID].revisar();
    }
}

Monitor Guardia {
    int medicosLibres = 0;
    int esperando = 0;
    cond cola;
    cond espera;
    cola medicos;

    procedure llegaPaciente (medicoAsignado: out int) {
        if (medicosLibres == 0) {
            esperando++
            wait(cola);
        } else {
            medicosLibres--;
        }
        medicoAsignado = pop(medicos);
    }

    procedure atender (id: in int) {
        push(medicos, id);
        if (esperando > 0){
            esperando--;
            signal(cola);
        } else{
            medicosLibres++;
        }
    }
}

Monitor Consultorio [ID: 1..3]{

    cond espera;
    cond siendoAtendido;
    bool listo = false;

    procedure serAtendido (){
        listo = true;
        signal(espera);
        wait(siendoAtendido);
    }

    procedure revisar (){
        if (!listo) {
            wait(espera);
        }
        AtenderPaciente();
        signal(siendoAtendido);
    }
}