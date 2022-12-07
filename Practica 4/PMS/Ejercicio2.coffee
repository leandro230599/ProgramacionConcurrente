### En un laboratorio de genética veterinaria hay 3 empleados. El primero de ellos
continuamente prepara las muestras de ADN; cada vez que termina, se la envía al segundo
empleado y vuelve a su trabajo. El segundo empleado toma cada muestra de ADN
preparada, arma el set de análisis que se deben realizar con ella y espera el resultado para
archivarlo. Por último, el tercer empleado se encarga de realizar el análisis y devolverle el
resultado al segundo empleado. ###

# Se podria mejorar este ejercicio usando otro proceso coordinador, al cual el primer robot
# le manda las muestras asi no se genera demora innecesaria y despues el segundo tomando
# las muestras del coordinador que estan en su cola privada

process PrimerEmpleado {
    texto muestra;
    
    while true {
        muestra = prepararMuestraADN();
        SegundoEmpleado!.muestra(muestra);
    }
}

process SegundoEmpleado {
    texto muestra;
    texto resultado;

    while true {
        PrimerEmpleado?.muestra(muestra);
        preparaSetAnalisis();
        TercerEmpleado!.setListo(true);
        TercerEmmpleado?.resultado(resultado);
    }
}

process TercerEmpleado {
    bool listo = false;
    texto resultado;

    while true {
        SegundoEmpleado?.setListo(listo);
        resultado = realizaAnalisis();
        SegundoEmpleado!.resultado(resultado);
    }
}