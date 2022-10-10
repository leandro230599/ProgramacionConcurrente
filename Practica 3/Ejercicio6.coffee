###
Existe una comisión de 50 alumnos que deben realizar tareas de a pares, las cuales son corregidas por un JTP. Cuando los alumnos llegan, forman una fila. Una vez que están todos en fila, el JTP les asigna un número de grupo a cada uno. Para ello, suponga que existe una función AsignarNroGrupo() que retorna un número “aleatorio” del 1 al 25. Cuando un alumno ha recibido su número de grupo, comienza a realizar su tarea. Al terminarla, el alumno le avisa al JTP y espera por su nota. Cuando los dos alumnos del grupo completaron la tarea, el JTP les asigna un puntaje (el primer grupo en terminar tendrá como nota 25, el segundo 24, y así sucesivamente hasta el último que tendrá nota 1). Nota: el JTP no guarda el número de grupo que le asigna a cada alumno.
###

process alumnos [ID: 1..50]{
    int grupo;

    Comision.hacerFila(ID,grupo);
    # Realiza su tarea
    Jtp.avisarYEsperarNota(ID,grupo);
}

process jtp {
    int i;

    Comision.asignarGrupo();
    for i:= 1..25{
        Jtp.darNota();
    }
}

Monitor Comision {
    cond cola;
    cond llegaron;
    int esperando = 0;
    int grupoXAlumno[50];

    procedure hacerFila (id, grupo : in int){
        esperando++;
        if (esperando==50){
            signal(llegaron)
        }
        wait(cola);
        grupo = grupoXAlumno[id];
    }

    procedure asignarGrupo (){
        int i;

        if (esperando < 50){
            wait(llegaron);
        }
        signal_all(cola);
        for i:= 1..50 {
            grupoXAlumno[i] = AsignarNroGrupo();
        }
    }
}

Monitor Jtp {
    int nota = 25;
    int terminaron[25] = 0;
    int notaGrupal[25];
    int esperandoNota = 0;
    cola terminados;
    cond cola[25];
    cond esperandoGrupo;

    procedure avisarYEsperarNota (idAlumno,grupo: in int, nota: out int){
        terminaron[grupo]++;
        if (terminaron[grupo] == 2){
            esperandoNota++;
            push(terminados,grupo);
            signal(esperandoGrupo);
        }
        wait(cola[grupo]);
        nota = notaGrupal[grupo];
    }

    procedure darNota (){
        int grupoAux;
        if (esperandoNota == 0){
            wait(esperandoGrupo);
        }else{
            esperandoNota--;
            grupoAux = pop(terminados):
            notaGrupal[grupoAux] = nota;
            nota--;
            signal_all(cola[grupo]);
        }
    }
}