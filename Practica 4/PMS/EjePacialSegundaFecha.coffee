# Resolver con Pasaje de Mensajes Sincrónicos (PMS) el siguiente problema. En un torneo de programación
# hay 1 organizador, N competidores y S supervisores. El organizador comunica el desafío a resolver a cada
# competidor. Cuando un competidor cuenta con el desafío a resolver, lo hace y lo entrega para ser evaluado.
# A continuación, espera a que alguno de los supervisores lo corrija y le indique si está bien. En caso de tener
# errores, el competidor debe corregirlo y volver a entregar, repitiendo la misma metodología hasta que llegue
# a la solución esperada. Los supervisores corrigen las entregas respetando el orden en que los competidores
# van entregando. Nota: maximizar la concurrencia y no generar demora innecesaria.

Process Organizador {
    int i = 1;
    string desafio;
    while (i<=N) {
        desafio = generarDesafio();
        Competidores[i]!comunica(desafio);
        i++;
    }
}

Process Competidores [ID:1..N] {
    string desafio;
    string resuelto;
    bool isOK = false;

    Organizador?comunica(desafio);
    while not isOK {
        resuelto = resuelveDesafio(desafio);
        Admin!entregar(ID,resuelto);
        Supervisores[*]?respuesta(isOK);
    }

}

Process Supervisores [ID:1..S] {
    int idC;
    string desafio;
    bool isOK;

    while true {
        Admin!pedido(ID):
        Admin?corregir(idC, desafio);
        isOK = corrigiendoExamen(desafio);
        Competidores[idC]!respuesta(isOK);
    }
}

Process Admin {
    cola orden;
    string desafio;
    int idC;
    int idE;

    do Competidores[*]?entregar(idC,desafio) → push(orden,(idC,desafio))
    □ not empty(orden); Supervisores[*]?pedido(idE) → pop(orden, (idC,desafio))
                                                Supervisores[idE]!corregir(idC,desafio)
    # Todo este DO podria ser mejor con el while true y un if, porque este do si no toma algo true, termina
}