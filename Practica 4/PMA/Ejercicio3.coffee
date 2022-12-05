### Se debe modelar el funcionamiento de una casa de comida rápida, en la cual trabajan 2
cocineros y 3 vendedores, y que debe atender a C clientes. El modelado debe considerar
que:
- Cada cliente realiza un pedido y luego espera a que se lo entreguen.
- Los pedidos que hacen los clientes son tomados por cualquiera de los vendedores y se
lo pasan a los cocineros para que realicen el plato. Cuando no hay pedidos para atender,
los vendedores aprovechan para reponer un pack de bebidas de la heladera (tardan entre
1 y 3 minutos para hacer esto).
- Repetidamente cada cocinero toma un pedido pendiente dejado por los vendedores, lo
cocina y se lo entrega directamente al cliente correspondiente.
Nota: maximizar la concurrencia. ###

chan Pedido (int)
chan SolicitaPedido (int)
chan Entrega[C] (bool)
chan Atiende[3] (int)
chan CocineroRecibe (int)

process Cliente [ID:1..C] {
    bool recibioPedido = false

    send Pedido (ID);
    receive  Entrega[ID] (recibioPedido)
}

process Vendedores [ID:1..3] {
    int idCliente;
    while true {
        send SolicitaPedido (ID);
        receive Atiende[ID] (idCliente);
        if (idCliente == -1) {
            reponerHeladera();
        }
        else {
            send CocineroRecibe (idCliente);
        }
    }
}

process Cocineros [ID:1..2] {
    int idCliente;
    while true {
        receive CocineroRecibe (idCliente);
        cocinando();
        send Entrega[idCliente] (true);
    }
}

process Coordinador {
    int idCliente;
    int idVendedor;

    while true {
        receive SolicitaPedido (idVendedor);
        if not empty(Cola) {
            receive Pedido (idCliente);
        }
        else {
            idCliente = -1;
        }
        send Atiende[idVendedor] (idCliente);
    }
}