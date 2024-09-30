// Seleccionar los botones por su ID
const heartButton = document.getElementById("heartBtn");
const expandButton = document.getElementById("expandBtn");

// Acción para el botón de corazón (marcar o desmarcar)
heartButton.onclick = function() {
  heartButton.classList.toggle("marked");  // Alterna la clase 'marked' para cambiar el color
};

// Acción para el botón de expandir (redireccionar a otra página HTML)
expandButton.onclick = function() {
  window.location.href = "../../detalle_producto.html";  // Redirige a otro HTML
};
