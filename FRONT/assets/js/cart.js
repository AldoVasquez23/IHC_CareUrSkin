// cart.js

let cart = []; 

function addToCart(productName, productPrice, productImage) {
    const userId = auth.currentUser ? auth.currentUser.uid : null;

    if (!userId) {
        alert("Por favor, inicie sesión para añadir productos al carrito.");
        return;
    }

    const product = {
        name: productName,
        price: productPrice,
        image: productImage,
        quantity: 1
    };

    // Añadir el producto al arreglo del carrito
    cart.push(product);

    // Guardar el carrito en Firebase Realtime Database
    database.ref('cart/' + userId).set(cart)
        .then(() => {
            updateCartView();
            // Mostrar alerta de éxito
            alert('Producto añadido al carrito con éxito');
        })
        .catch((error) => {
            console.error("Error al escribir en Firebase:", error.message);
        });
}


function updateCartView() {
    const cartList = document.querySelector('.cart-list'); // Contenedor de la lista de productos en el carrito
    const cartTotalSpan = document.querySelector('.cart-total'); // Elemento que muestra el total
    const cartBadge = document.querySelector('.badge-bg-1'); // Elemento que muestra el número del carrito
    
    if (!cartList || !cartTotalSpan || !cartBadge) {
        console.error('Error: No se encontraron los elementos del carrito en el DOM.');
        return;
    }

    let total = 0;
    let quantity = 0;
    
    // Limpiar la lista de productos en el carrito
    cartList.innerHTML = '';

    // Añadir los productos al carrito en el DOM
    cart.forEach((product, index) => {
        const listItem = `
        <li class="single-cart-list">
            <a href="#" class="photo"><img src="${product.image}" class="cart-thumb" alt="image" /></a>
            <div class="cart-list-txt">
                <h6><a href="#">${product.name}</a></h6>
                <p>1 x - <span class="price">$${product.price.toFixed(2)}</span></p>
            </div>
            <div class="cart-close">
                <span class="lnr lnr-cross" onclick="removeFromCart(${index})"></span>
            </div>
        </li>
        <li class="total">
            <span class="cart-total">Total: $0.00</span>
            <button class="btn-cart pull-right" onclick="pagar()">Pagar</button>
        </li>
         `;
        cartList.innerHTML += listItem;
        total += product.price;
        quantity += 1;
    });

    // Actualizar el total en el DOM
    cartTotalSpan.textContent = `Total: $${total.toFixed(2)}`;

    // Actualizar el número del carrito en el ícono
    cartBadge.textContent = quantity;
}


// Inicializar el carrito al cargar la página
document.addEventListener('DOMContentLoaded', () => {
    const userId = auth.currentUser ? auth.currentUser.uid : 'anonimo';

    // Cargar carrito desde Firebase
    database.ref('cart/' + userId).get().then((snapshot) => {
        if (snapshot.exists()) {
            cart = snapshot.val() || [];
            updateCartView();
        }
    }).catch((error) => {
        console.error(error.message);
    });
});

const cartBadge = document.querySelector('.badge-bg-1');
cartBadge.textContent = cart.length;
