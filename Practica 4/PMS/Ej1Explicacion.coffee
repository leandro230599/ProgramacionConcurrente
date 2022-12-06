### En una empresa de software hay un empleado Testeo que prueba un nuevo
producto para encontrar errores, cuando encuentra uno generan un reporte para
que otro empleado Mantenimiento corrija el error y le responda. El empleado
Mantenimiento toma los reportes para evaluarlos, hacer las correcciones necesarias
y responderle al empleado Testeo. ###

Process Testeo { 
    texto R, Res;
    while (true) { 
        R = generarReporteConProblema;
        Mantenimiento!reporte(R);
        Mantenimiento?respuesta(Res);
    }
}

Process Mantenimiento { 
    texto Rep, Res;
    while (true) { 
        Testeo?reporte(Rep);
        Res = resolver(Rep);
        Testeo!respuesta(Res);
    }
}