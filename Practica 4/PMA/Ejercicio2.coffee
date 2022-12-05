### Se desea modelar el funcionamiento de un banco en el cual existen 5 cajas para realizar
pagos. Existen P clientes que desean hacer un pago. Para esto, cada una selecciona la caja
donde hay menos personas esperando; una vez seleccionada, espera a ser atendido. En cada
caja, los clientes son atendidos por orden de llegada por los cajeros. Luego del pago, se les
entrega un comprobante. Nota: maximizando la concurrencia. ###

chan Cola[5](int);
chan Comprobante[P](texto);

process Clientes [ID:1..P] {
    int min;
    texto comprobante;

    min = minimo(Cola) // Funcion que retorna el index de la posicion con menor cantidad;
    send Cola[min] (ID);
    receive Comprobante[ID] (comprobante);
}

process Cajas [ID:1..5] {
    int idCliente;
    texto comprobante;
    while true {
        receive Cola[ID] (idCliente);
        comprobante = atenderCliente(idCliente);
        send Comprobante[idCliente] (comprobante);
    }
}