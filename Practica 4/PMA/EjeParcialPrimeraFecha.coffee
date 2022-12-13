# Resolver con PMA el siguiente problema. Se debe modelar el funcionamiento de una casa de venta de repuestos
# automotores, en la que trabajan V vendedores y que debe atender a C clientes. El modelado debe considerar que:
# (a) cada cliente realiza un pedido y luego espera a que se lo entreguen; y (b) los pedidos que hacen los clientes son
# tomados por cualquiera de los vendedores. Cuando no hay pedidos para atender, los vendedores aprovechan para
# controlar el stock de los repuestos (tardan entre 2 y 4 minutos para hacer esto). Nota: maximizar la concurrencia. 

chan PedidoCliente(int, texto)
chan Resuelve[C](texto)
chan Pedido(int)
chan Siguiente[V](int, texto)

Process Coordinador {
    int idE;
    int idC;
    texto pedido;

    while true {
        receive Pedido(idE);
        if (empty(PedidoCliente)) {
            idC = -1;
            pedido = "vacio";
        } else{
            receive PedidoCliente(idC, pedido);
        }
        send Siguiente[idE](idC, pedido);
    }
}

Process vendedores [ID:1..V] {
    int idC;
    int tiempoTarda;
    texto pedido;
    texto respuesta;

    while true {
        send Pedido(ID);
        receive Siguiente[ID](idC,pedido);
        if (idC!=-1){
            respuesta = procesandoPedido(pedido);
            send Resuelve[idC](respuesta);
        } else {
            tiempoTarda = random(2..4);
            delay(tiempoTarda);
        }
    }
}

Process clientes [ID:1..C] {
    texto pedido;
    texto respuesta;

    pedido = realizaPedido();
    send PedidoCliente (ID,pedido);
    receive Resuelve[ID] (respuesta);
}