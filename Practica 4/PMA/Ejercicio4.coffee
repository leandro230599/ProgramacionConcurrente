### Simular la atención en un locutorio con 10 cabinas telefónicas, el cual tiene un empleado
que se encarga de atender a N clientes. Al llegar, cada cliente espera hasta que el empleado
le indique a qué cabina ir, la usa y luego se dirige al empleado para pagarle. El empleado
atiende a los clientes en el orden en que hacen los pedidos, pero siempre dando prioridad a
los que terminaron de usar la cabina. A cada cliente se le entrega un ticket factura. Nota:
maximizar la concurrencia; suponga que hay una función Cobrar() llamada por el empleado
que simula que el empleado le cobra al cliente. ###

chan Pedido (int);
chan Termino (int);
chan UsarCabina[N] (int);
chan Cabina[10] ()
chan EsperaTicket[N] (texto);

process Cliente [ID:1..N] {
    int idCabina;
    texto factura;

    send Pedido (ID);
    receive UsarCabina[ID] (idCabina);
    usaCabina(idCabina);
    send Termino (ID);
    receive EsperaTicket[ID] (factura);

}

process Empleado {
    int idCliente;
    int idClienteTermino;
    int idCabina;
    texto factura;

    while true {
        if (empty(Termino)) {
            receive Pedido (idCliente);
            idCabina = ElegirCabina();
            send UsarCabina[idCliente] (idCabina);
        } else {
            receive Termino (idClienteTermino);
            Cobrar();
            factura = GenerarTicket();
            send EsperaTicket[idClienteTermino] (factura);
        }
    }
}