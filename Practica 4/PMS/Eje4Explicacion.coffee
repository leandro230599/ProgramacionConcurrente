### En una empresa de software hay N empleados Testeo que prueban un nuevo
producto para encontrar errores, cuando encuentra uno generan un reporte para
que uno de los 3 empleados Mantenimiento corrija el error y le responda. Los
empleados Mantenimiento toma los reportes para evaluarlos de acuerdo al orden
de llegada, hace las correcciones necesarias y le responde al empleado Testeo
correspondiente (el que hizo el reporte). ###

Process Admin { 
    cola Fila; texto R; int idT, idM;
    do Testeo[*]?reporte(R, idT) → push (Fila, (R,idT));
    □ not empty(Fila); Mantenimiento[*]?pedido(idM)→    pop (Fila, (R, idT))
                                                        Mantenimiento[idM]!reporte (R, idT);
    od
} 

Process Testeo[id: 0 ..N-1] { 
    texto R, Res;
    while (true) { 
        R = generarReporteConProblema;
        Admin!reporte(R, id);
        Mantenimiento[*]?respuesta(Res);
    }
}

Process Mantenimiento[id: 0..2] { 
    texto Rep, Res; int idT;
    while (true) { 
        Admin!pedido(id);
        Admin?reporte(Rep, idT);
        Res = resolver(Rep);
        Testeo[idT]!respuesta(Res);
    }
}