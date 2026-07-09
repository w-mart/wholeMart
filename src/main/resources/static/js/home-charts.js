document.addEventListener("DOMContentLoaded", function () {
    // --- Login Form Submission Logic ---
    const loginModal = document.getElementById('loginModal');

    function openLoginPopup() {
        if (loginModal) {
            loginModal.style.display = 'flex';
        }
    }

    function closeLoginPopup() {
        if (loginModal) {
            loginModal.style.display = 'none';
        }
    }

    // Close modal if user clicks outside of the modal content
    window.onclick = function (event) {
        if (event.target == loginModal) {
            closeLoginPopup();
        }
    }
    const loginPopupForm = document.getElementById('loginPopupForm');
    if (loginPopupForm) {
        loginPopupForm.addEventListener('submit', async function (e) {
            e.preventDefault();
            const loginData = {
                email: document.getElementById('popup_email').value,
                password: document.getElementById('popup_password').value
            };
            const popupMessageArea = document.getElementById('popup_message-area');
            popupMessageArea.textContent = '';
            popupMessageArea.className = 'message';

            try {
                const response = await fetch('/api/v1/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(loginData),
                });
                const responseData = await response.json();
                if (response.ok && responseData.token) {
                    localStorage.setItem('jwt_token', responseData.token);
                    window.location.href = '/dashboard'; // Redirect to dashboard on success
                } else {
                    const errorMessage = responseData.message || 'Invalid credentials';
                    popupMessageArea.textContent = `Error: ${errorMessage}`;
                    popupMessageArea.classList.add('error');
                }
            } catch (error) {
                console.error('Login failed:', error);
                popupMessageArea.textContent = 'Login failed. Please try again later.';
                popupMessageArea.classList.add('error');
            }
        });
    }

    // Doughnut Chart for Sales Breakdown
    const doughnutCtx = document.getElementById('salesDoughnutChart');
    new Chart(doughnutCtx, {
        type: 'doughnut',
        data: {
            labels: [
                'Online Sales',
                'Offline Sales'
            ],
            datasets: [{
                label: 'Monetary Value',
                data: [
                    12.5,
                    5.9
                ],
                backgroundColor: [
                    '#1F6D46',
                    '#2E5AA8'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                title: {
                    display: true,
                    text: 'Sales Channels (in ₹L)'
                }
            },
            cutout: '65%'
        }
    });

    // Line Chart for Sales Trend
    const lineCtx = document.getElementById('salesTrendChart');
    new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Sales (in L)',
                data: [12.5, 14.2, 15.1, 17.3, 16.9, 18.4],
                fill: false,
                borderColor: '#C2410C',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: 'Monthly Sales Trend'
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    ticks: {
                        callback: function (value) {
                            return '₹' + value + 'L';
                        }
                    }
                }
            }
        }
    });

    // Bar Chart for Orders & Retailers
    const barCtx = document.getElementById('activityBarChart');
    new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: [
                'Distributors',
                'Retailers',
                'Cities Covered',
                'Orders Fulfilled',
                'New Retailers'
            ],
            datasets: [{
                label: 'Count',
                data: [
                    150,
                    800,
                    25,
                    3240,
                    86
                ],
                backgroundColor: [
                    '#2E5AA8',
                    '#1F6D46',
                    '#E3A73B',
                    '#154F34',
                    '#C2410C'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false // Hide legend as it's self-explanatory
                },
                title: {
                    display: true,
                    text: 'Activity Count'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });

    // Doughnut Chart for Expiry Management
    const expiryCtx = document.getElementById('expiryManagementChart');
    new Chart(expiryCtx, {
        type: 'doughnut',
        data: {
            labels: [
                'Value Saved (₹)',
                'At Risk (₹)'
            ],
            datasets: [{
                label: 'Amount',
                data: [
                    45000,
                    8500
                ],
                backgroundColor: [
                    '#1F6D46',
                    '#E3A73B'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' },
                title: { display: true, text: 'Expiry Management (AI)' }
            },
            cutout: '65%'
        }
    });
});