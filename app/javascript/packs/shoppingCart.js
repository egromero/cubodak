ADD_BAG = "/add_to_bag";
GET_SHOPPING_CART = "/get_shopping_cart";

window.addToBag = function () {
  const token = document.querySelector('meta[name="csrf-token"]').content;
  const productId = $("#product-id").val();
  const quantity = $("#product-quantity").val();
  $.ajax(ADD_BAG, {
    type: "POST",
    headers: {
      "X-CSRF-Token": token,
      "Content-Type": "application/json",
    },
    data: JSON.stringify({
      product_id: productId,
      quantity: quantity,
    }),
  }).done(function (data) {
    showCart(data);
  });
};

window.closeShoppingCart = function () {
  const shoppingDiv = $("#shopping-div");
  shoppingDiv.animate(
    {
      width: "toggle",
      "font-size": "0",
    },
    () => {
      shoppingDiv.remove();
    }
  );
};

window.getCart = function () {
  fetch(GET_SHOPPING_CART)
    .then((response) => response.json())
    .then((data) => showCart(data));
};

const showCart = (data) => {
  if (data.status) {
    $("#blurry-div").css("display", "");
    const total_final_price = data.data.reduce(function (a, b) {
      return a + b["total_price"];
    }, 0);
    var elements = "";
    data.data.forEach((product) => {
      const {
        image,
        product: { name, final_price },
        quantity,
      } = product;
      elements += `<div class="card-text flex-row-div">
                <img src=${image} class="miniature"%>
                <p class="product-info">${name}</p>
                <p class="product-info">${quantity}</p>
                <p class="product-info">$${final_price}</p>
            </div>`;
    });
    $("body").append(
      `<div class="shopping-div" id="shopping-div">
            <div class="flex-row-div" style="justify-content: space-evenly; margin:1rem auto; height:100%">
            <span class="close" onCLick="window.closeShoppingCart();">X</span>
            <div class="flex-column-div" style="width:60%; height: 94%;border-right: 8px solid darkgray;padding-right: 10%;">
            <p class="card-sub-title" style="text-align:center">BOLSA DE COMPRAS</p>
            <div class="flex-row-div">
            <p style="width:50px;"></p>
            <p>Producto</p>
            <p>Cantidad</p>
            <p>Valor</p>
            </div>
            ${elements}
            <a href="/" class="styled-btn" style="margin: 2rem auto">Seguir comprando</a>
            </div> 
            <div class="flex-column-div">
                <p class="card-sub-title" style="text-align:center">TOTAL</p>
            <div>
            Valor Total $${total_final_price}
          </div>
        <a href="/checkout" class="styled-btn btn-red" style="margin: 2rem auto">Pagar Aquí</a>
      </div>
    </div>
    </div>
    `
    );
  } else {
    $("body").append(
      `<div class="shopping-div" id="shopping-div">
            <div class="flex-row-div" style="justify-content: space-evenly; margin:1rem auto; height:100%">
            <span class="close" onCLick="window.closeShoppingCart();">X</span>
            <div class="flex-column-div" style="width:60%; height: 94%;border-right: 8px solid darkgray;padding-right: 10%;">
            <p class="card-sub-title" style="text-align:center">BOLSA DE COMPRAS</p>
            <div class="flex-row-div">
            <p style="width:50px;"></p>
            <p>Producto</p>
            <p>Cantidad</p>
            <p>Valor</p>
            </div>
            NO HAY PRODUCTOS EN EL CARRITO.
            <a href="/" class="styled-btn" style="margin: 2rem auto">Seguir comprando</a>
            </div> 
            <div class="flex-column-div">
                <p class="card-sub-title" style="text-align:center">TOTAL</p>
            <div>
            Valor Total $0
          </div>
        <a href="/checkout" class="styled-btn btn-red" style="margin: 2rem auto">Pagar Aquí</a>
      </div>
    </div>
    </div>
    `
    );
  }
};
