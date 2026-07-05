document.addEventListener('DOMContentLoaded', function() {
    const loginModal = document.getElementById('loginModal');

    // Function to open the login popup, now globally available
    window.openLoginPopup = function() {
        if (loginModal) {
            loginModal.style.display = 'flex';
        }
    };

    // Function to close the login popup, now globally available
    window.closeLoginPopup = function() {
        if (loginModal) {
            loginModal.style.display = 'none';
        }
    };

    // Close popup if user clicks on the overlay
    if (loginModal) {
        loginModal.addEventListener('click', function(event) {
            if (event.target === loginModal) {
                closeLoginPopup();
            }
        });
    }
});