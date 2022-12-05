### Suponga que N clientes llegan a la cola de un banco y que serán atendidos por sus
empleados. Analice el problema y defina qué procesos, recursos y comunicaciones serán
necesarios/convenientes para resolver el problema. Luego, resuelva considerando las
siguientes situaciones: 
    a. Existe un único empleado, el cual atiende por orden de llegada ###

chan Cola(int)
chan Turno[N](int)

process Persona [ID:1..N] {
    int idAux;
    send Cola (ID);
    receive Turno[ID] (idAux);
}

process Empleado {
    int idPersona;
    while(true) {
        receive Cola (idPersona);
        atenderPersona(idPersona)
        send Turno[idPersona] (idPersona)
    }
}

### b. Ídem a) pero considerando que hay 2 empleados para atender, ¿qué debe
modificarse en la solución anterior? ###

Se debe modificar la cantidad de empleados y nada mas 
process Empleado [ID:1..2] {

### c. Ídem b) pero considerando que, si no hay clientes para atender, los empleados
realizan tareas administrativas durante 15 minutos. ¿Se puede resolver sin usar
procesos adicionales? ¿Qué consecuencias implicaría? ###

chan Cola(int)
chan Pedido(int)
chan Turno[N](int)

process Persona [ID:1..N] {
    int idAux;
    send Cola (ID);
    receive Turno[ID] (idAux);
}

process Empleado [ID:1..2] {
    int idPersona;
    while true {
        send Pedido (ID);
        receive Turno[ID] (idPersona);
        if (idPersona <> -1) {
            atenderPersona(idPersona);
        }
        else {
            delay(900) // Se duerme 15 minutos
        }
    }
}

process Coordinador {
    int idEmpleado;
    int idPersona;
    while true {
        receive Pedido (idEmpleado)
        if (not empty (Cola)) {
            receive Cola (idPersona);
        } else {
            idPersona = -1;
        }
        send Turno[idEmpleado] (idPersona);
    }
}

