function changeQuantity(amount) {
    const quantityInput = document.getElementById('quantity');
    let newQuantity = parseInt(quantityInput.value) + amount;
    newQuantity = Math.max(1, Math.min(newQuantity, 999));
    quantityInput.value = newQuantity;
}

const stars = document.querySelectorAll('.star');
stars.forEach((star, index) => {
    star.addEventListener('mouseover', () => {
        stars.forEach((s, i) => {
            s.classList.toggle('hover', i <= index);
        });
    });

    star.addEventListener('mouseout', () => {
        stars.forEach(s => s.classList.remove('hover'));
    });

    star.addEventListener('click', () => {
        const rating = star.getAttribute('data-value');
        stars.forEach(s => {
            s.classList.toggle('active', s.getAttribute('data-value') <= rating);
        });
    });
});

const wishlistHeart = document.getElementById('wishlist-heart');
wishlistHeart.addEventListener('click', () => {
    wishlistHeart.classList.toggle('active');
});

function changeMainImage(src) {
    document.getElementById('main-image').src = src;
}

function submitComment() {
    const commentText = document.getElementById('comment').value;
    if (commentText.trim() !== '') {
        const commentList = document.getElementById('comment-list');
        const newComment = document.createElement('div');
        newComment.className = 'comment-item';
        newComment.innerHTML = `
            <div class="comment-header">
                <div class="user-icon"></div>
                <div class="comment-username">Usuario${Math.floor(Math.random() * 1000)}</div>
            </div>
            <div class="comment-text">${commentText}</div>
        `;
        commentList.prepend(newComment);
        document.getElementById('comment').value = '';
    }
}