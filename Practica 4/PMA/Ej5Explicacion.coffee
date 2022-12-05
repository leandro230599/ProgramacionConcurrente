### En una empresa de software hay N personas que prueban un nuevo producto
para encontrar errores, cuando encuentran uno generan un reporte para que uno
de los 3 empleados corrija el error (las personas no deben reciben ninguna
respuesta). Los empleados toman los reportes de acuerdo al orden de llegada, los
evalúan y hacen las correcciones necesarias; cuando no hay reportes para atender
los empleados se dedican a leer durante 10 minutos. ###

chan Reportes(texto);
chan Pedido(int);
chan Siguiente[3](texto);

Process Coordinador { 
    texto Rep;
    int idE;
    while (true) { 
        receive Pedido ( idE);
        if (empty (Reportes) ) 
            Rep = “VACIO”;
        else 
            receive Reportes ( Rep )
        send Siguiente[idE] ( Rep );
    };
}

Process Empleado[id: 0..2] { 
    texto Rep;
    while (true) { 
        send Pedido(id);
        receive Siguiente[id] ( Rep );
        if (Rep <> “VACIO”) 
            resolver (Rep)
        else 
            delay (600); //lee 10 minutos
    };
}

Process Persona[id: 0..N-1] { 
    texto R;
    while (true) { 
        R = generarReporteConProblema;
        send Reportes ( R );
    };
}