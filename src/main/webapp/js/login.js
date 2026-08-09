/**
 * WholeMart Login & Registration Management
 * Handles multi-step registration wizard, role switching, validation, password toggles, and tab navigation.
 */

(function () {
    'use strict';

    // Global step navigation functions so onclick handlers in JSP work seamlessly
    window.goToStep = function (stepNum) {
        showStep(stepNum);
    };

    window.validateAndNext = function (fromStep, toStep) {
        if (validateStep(fromStep)) {
            showStep(toStep);
        }
    };

    function showStep(stepNum) {
        // Hide all steps
        const steps = document.querySelectorAll('.register-step');
        steps.forEach(function (step) {
            step.classList.remove('active-step');
            step.style.display = 'none';
        });

        // Show target step
        const targetStep = document.getElementById('step' + stepNum);
        if (targetStep) {
            targetStep.style.display = 'block';
            targetStep.classList.add('active-step');
        }

        // Update wizard indicators
        for (let i = 1; i <= 3; i++) {
            const ind = document.getElementById('indicator' + i);
            if (!ind) continue;
            const circle = ind.querySelector('.wizard-circle');
            
            if (i < stepNum) {
                ind.classList.add('active', 'completed');
                if (circle) circle.innerHTML = '<i class="bi bi-check-lg text-white"></i>';
            } else if (i === stepNum) {
                ind.classList.add('active');
                ind.classList.remove('completed');
                if (circle) circle.textContent = i;
            } else {
                ind.classList.remove('active', 'completed');
                if (circle) circle.textContent = i;
            }
        }

        // Scroll smoothly to form top on step change
        const formCard = document.querySelector('.auth-card');
        if (formCard) {
            formCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }

    function showFieldError(input, message) {
        if (!input) return;
        input.classList.add('is-invalid');
        input.classList.remove('is-valid');
        
        let feedback = input.parentNode.querySelector('.invalid-feedback');
        if (!feedback) {
            feedback = document.createElement('div');
            feedback.className = 'invalid-feedback d-block';
            if (input.parentNode.classList.contains('input-group') || input.parentNode.classList.contains('password-group')) {
                input.parentNode.parentNode.appendChild(feedback);
            } else {
                input.parentNode.appendChild(feedback);
            }
        }
        feedback.textContent = message;
        feedback.style.display = 'block';
    }

    function clearFieldError(input) {
        if (!input) return;
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        
        const parent = input.parentNode.classList.contains('input-group') || input.parentNode.classList.contains('password-group')
            ? input.parentNode.parentNode
            : input.parentNode;
        const feedback = parent.querySelector('.invalid-feedback');
        if (feedback) {
            feedback.style.display = 'none';
        }
    }

    function validateStep(stepNum) {
        let isValid = true;
        let firstInvalidField = null;

        if (stepNum === 1) {
            const stepEl = document.getElementById('step1');
            if (!stepEl) return true;

            const fullName = stepEl.querySelector('input[name="fullName"]');
            const mobile = stepEl.querySelector('input[name="mobile"]');
            const email = stepEl.querySelector('input[name="email"]');
            const role = document.getElementById('regRoleSelect');
            const password = document.getElementById('regPassword');
            const confirmPassword = document.getElementById('regConfirmPassword');

            // Full Name validation
            if (fullName) {
                if (!fullName.value.trim() || fullName.value.trim().length < 2) {
                    showFieldError(fullName, 'Please enter your full name (at least 2 characters).');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = fullName;
                } else {
                    clearFieldError(fullName);
                }
            }

            // Mobile validation (10 digits)
            if (mobile) {
                const cleanedMobile = mobile.value.replace(/\D/g, '');
                if (!/^[6-9]\d{9}$/.test(cleanedMobile)) {
                    showFieldError(mobile, 'Please enter a valid 10-digit mobile number starting with 6, 7, 8, or 9.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = mobile;
                } else {
                    mobile.value = cleanedMobile;
                    clearFieldError(mobile);
                }
            }

            // Email validation
            if (email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email.value.trim())) {
                    showFieldError(email, 'Please enter a valid email address.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = email;
                } else {
                    clearFieldError(email);
                }
            }

            // Role validation
            if (role) {
                if (!role.value) {
                    showFieldError(role, 'Please select your role.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = role;
                } else {
                    clearFieldError(role);
                }
            }

            // Password validation
            if (password) {
                if (password.value.length < 6) {
                    showFieldError(password, 'Password must be at least 6 characters long.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = password;
                } else {
                    clearFieldError(password);
                }
            }

            // Confirm Password validation
            if (confirmPassword) {
                if (confirmPassword.value !== password.value) {
                    showFieldError(confirmPassword, 'Passwords do not match.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = confirmPassword;
                } else if (!confirmPassword.value) {
                    showFieldError(confirmPassword, 'Please confirm your password.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = confirmPassword;
                } else {
                    clearFieldError(confirmPassword);
                }
            }
        } else if (stepNum === 2) {
            const roleSelect = document.getElementById('regRoleSelect');
            const role = roleSelect ? roleSelect.value : 'Retailer';
            const isDriver = role === 'Driver' || role === 'ROLE_DRIVER';

            if (isDriver) {
                const license = document.querySelector('input[name="licenseNumber"]');
                const vehicleType = document.querySelector('select[name="vehicleType"]');
                const vehicleNumber = document.querySelector('input[name="vehicleNumber"]');

                if (license && !license.value.trim()) {
                    showFieldError(license, 'Driving license number is required for drivers.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = license;
                } else if (license) {
                    clearFieldError(license);
                }

                if (vehicleType && !vehicleType.value) {
                    showFieldError(vehicleType, 'Please select your vehicle type.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = vehicleType;
                } else if (vehicleType) {
                    clearFieldError(vehicleType);
                }

                if (vehicleNumber && !vehicleNumber.value.trim()) {
                    showFieldError(vehicleNumber, 'Vehicle registration number is required.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = vehicleNumber;
                } else if (vehicleNumber) {
                    clearFieldError(vehicleNumber);
                }
            } else {
                const businessName = document.querySelector('input[name="businessName"]');
                if (businessName && !businessName.value.trim()) {
                    showFieldError(businessName, 'Shop or Business name is required.');
                    isValid = false;
                    if (!firstInvalidField) firstInvalidField = businessName;
                } else if (businessName) {
                    clearFieldError(businessName);
                }
            }
        }

        if (firstInvalidField) {
            firstInvalidField.focus();
        }

        return isValid;
    }

    // Role select handler to switch between business fields and driver fields
    function updateRoleFields() {
        const roleSelect = document.getElementById('regRoleSelect');
        if (!roleSelect) return;

        const role = roleSelect.value;
        const businessFields = document.getElementById('businessFields');
        const driverFields = document.getElementById('driverFields');
        const step2Title = document.getElementById('step2Title');

        const isDriver = role === 'Driver' || role === 'ROLE_DRIVER';

        if (isDriver) {
            if (businessFields) businessFields.style.display = 'none';
            if (driverFields) driverFields.style.display = 'block';
            if (step2Title) step2Title.textContent = 'Step 2: Driver & Vehicle Details';
        } else {
            if (businessFields) businessFields.style.display = 'block';
            if (driverFields) driverFields.style.display = 'none';
            if (step2Title) step2Title.textContent = 'Step 2: Business Information';
        }
    }

    // Password strength indicator
    function checkPasswordStrength(password) {
        const bar = document.getElementById('passwordBar');
        if (!bar) return;

        let strength = 0;
        if (password.length >= 6) strength += 25;
        if (password.length >= 10) strength += 25;
        if (/[A-Z]/.test(password)) strength += 20;
        if (/[0-9]/.test(password)) strength += 15;
        if (/[^A-Za-z0-9]/.test(password)) strength += 15;

        bar.style.width = strength + '%';
        if (strength < 40) {
            bar.style.background = '#dc3545'; // Danger / Red
        } else if (strength < 75) {
            bar.style.background = '#ffc107'; // Warning / Yellow
        } else {
            bar.style.background = '#198754'; // Success / Green
        }
    }

    // Switch between Login and Register tabs
    function switchTab(targetTab) {
        const tabLogin = document.getElementById('tabLogin');
        const tabRegister = document.getElementById('tabRegister');
        const paneLogin = document.getElementById('login');
        const paneRegister = document.getElementById('register');
        const authHeader = document.querySelector('.auth-header h3');

        if (targetTab === 'register') {
            if (tabLogin) tabLogin.classList.remove('active');
            if (tabRegister) tabRegister.classList.add('active');
            if (paneLogin) {
                paneLogin.classList.remove('show', 'active');
                paneLogin.style.display = 'none';
            }
            if (paneRegister) {
                paneRegister.classList.add('show', 'active');
                paneRegister.style.display = 'block';
            }
            if (authHeader) authHeader.textContent = 'Create New Account';
            showStep(1);
        } else {
            if (tabRegister) tabRegister.classList.remove('active');
            if (tabLogin) tabLogin.classList.add('active');
            if (paneRegister) {
                paneRegister.classList.remove('show', 'active');
                paneRegister.style.display = 'none';
            }
            if (paneLogin) {
                paneLogin.classList.add('show', 'active');
                paneLogin.style.display = 'block';
            }
            if (authHeader) authHeader.textContent = 'Welcome Back';
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        // Tab buttons
        const tabLogin = document.getElementById('tabLogin');
        const tabRegister = document.getElementById('tabRegister');

        if (tabLogin) {
            tabLogin.addEventListener('click', function (e) {
                e.preventDefault();
                switchTab('login');
            });
        }

        if (tabRegister) {
            tabRegister.addEventListener('click', function (e) {
                e.preventDefault();
                switchTab('register');
            });
        }

        // Links to switch tabs
        document.querySelectorAll('.wm-show-register').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                switchTab('register');
            });
        });

        document.querySelectorAll('.wm-show-login').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                switchTab('login');
            });
        });

        // Check URL parameter to auto-open register tab (?tab=register or ?action=register)
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('tab') === 'register' || urlParams.get('action') === 'register') {
            switchTab('register');
        }

        // Role select change listener
        const regRoleSelect = document.getElementById('regRoleSelect');
        if (regRoleSelect) {
            regRoleSelect.addEventListener('change', updateRoleFields);
            updateRoleFields();
        }

        // Password strength meter listener
        const regPassword = document.getElementById('regPassword');
        if (regPassword) {
            regPassword.addEventListener('input', function () {
                checkPasswordStrength(this.value);
            });
        }

        // Password show/hide toggle icons
        document.querySelectorAll('.wm-eye-icon').forEach(function (icon) {
            icon.addEventListener('click', function () {
                const targetId = this.getAttribute('data-toggle-password');
                const input = document.getElementById(targetId);
                if (input) {
                    if (input.type === 'password') {
                        input.type = 'text';
                        this.classList.remove('bi-eye');
                        this.classList.add('bi-eye-slash');
                    } else {
                        input.type = 'password';
                        this.classList.remove('bi-eye-slash');
                        this.classList.add('bi-eye');
                    }
                }
            });
        });

        // Login form submission handler
        const loginForm = document.querySelector('.wm-login-form') || document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', function (e) {
                const emailInput = loginForm.querySelector('input[name="email"]') || loginForm.querySelector('input[name="username"]');
                const passwordInput = loginForm.querySelector('input[name="password"]');
                const roleSelect = loginForm.querySelector('select[name="role"]');
                const loginBtn = document.getElementById('loginBtn') || loginForm.querySelector('button[type="submit"]');

                let isFormValid = true;
                let firstInvalid = null;

                if (emailInput && !emailInput.value.trim()) {
                    showFieldError(emailInput, 'Please enter your registered email, username, or mobile number.');
                    isFormValid = false;
                    if (!firstInvalid) firstInvalid = emailInput;
                } else if (emailInput) {
                    clearFieldError(emailInput);
                }

                if (passwordInput && !passwordInput.value.trim()) {
                    showFieldError(passwordInput, 'Please enter your password.');
                    isFormValid = false;
                    if (!firstInvalid) firstInvalid = passwordInput;
                } else if (passwordInput) {
                    clearFieldError(passwordInput);
                }

                if (roleSelect && !roleSelect.value) {
                    showFieldError(roleSelect, 'Please select your role (Admin, Retailer, Distributor, Driver).');
                    isFormValid = false;
                    if (!firstInvalid) firstInvalid = roleSelect;
                } else if (roleSelect) {
                    clearFieldError(roleSelect);
                }

                if (!isFormValid) {
                    e.preventDefault();
                    if (firstInvalid) firstInvalid.focus();
                    return false;
                }

                if (loginBtn) {
                    loginBtn.disabled = true;
                    loginBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Verifying details...';
                }
            });
        }

        // Register form final submission handler
        const registerForm = document.getElementById('registerForm');
        if (registerForm) {
            registerForm.addEventListener('submit', function (e) {
                // Validate Step 3 fields
                const city = registerForm.querySelector('input[name="city"]');
                const state = registerForm.querySelector('input[name="state"]');
                const pincode = registerForm.querySelector('input[name="pincode"]');
                const agreeTerms = document.getElementById('agreeTerms');

                let step3Valid = true;
                let firstErr = null;

                if (city && !city.value.trim()) {
                    showFieldError(city, 'City is required.');
                    step3Valid = false;
                    if (!firstErr) firstErr = city;
                } else if (city) {
                    clearFieldError(city);
                }

                if (state && !state.value.trim()) {
                    showFieldError(state, 'State is required.');
                    step3Valid = false;
                    if (!firstErr) firstErr = state;
                } else if (state) {
                    clearFieldError(state);
                }

                if (pincode && !/^\d{6}$/.test(pincode.value.trim())) {
                    showFieldError(pincode, 'Please enter a valid 6-digit PIN code.');
                    step3Valid = false;
                    if (!firstErr) firstErr = pincode;
                } else if (pincode) {
                    clearFieldError(pincode);
                }

                if (agreeTerms && !agreeTerms.checked) {
                    showFieldError(agreeTerms, 'You must agree to the Terms & Conditions.');
                    step3Valid = false;
                    if (!firstErr) firstErr = agreeTerms;
                } else if (agreeTerms) {
                    clearFieldError(agreeTerms);
                }

                if (!step3Valid) {
                    e.preventDefault();
                    if (firstErr) firstErr.focus();
                    return false;
                }

                // Show spinner on submit button
                const submitBtn = document.getElementById('finalSubmitBtn');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Creating Account...';
                }
            });
        }
    });
})();
