function setWmLanguage(lang) {
    try {
        document.cookie = "wm_lang=" + encodeURIComponent(lang) + "; path=/; max-age=31536000";
        var url = new URL(window.location.href);
        url.searchParams.set('lang', lang);
        window.location.href = url.toString();
    } catch (e) {
        window.location.search = '?lang=' + encodeURIComponent(lang);
    }
}
window.setWmLanguage = setWmLanguage;
if (typeof globalThis !== 'undefined') {
    globalThis.setWmLanguage = setWmLanguage;
}

/* ============================================================
   Global WholeMart API / Network Loader & Request Interceptor
   ============================================================ */
(function () {
    var activeCount = 0;
    var progressTimer = null;
    var safetyTimer = null;
    var currentProgress = 0;

    function ensureLoaderDom() {
        if (document.getElementById('wm-global-progress')) return;
        if (!document.body && !document.documentElement) return;

        // Top progress bar
        var progressContainer = document.createElement('div');
        progressContainer.id = 'wm-global-progress';
        progressContainer.className = 'wm-global-progress';
        progressContainer.innerHTML = '<div class="wm-global-progress-bar" id="wm-global-progress-bar"></div>';

        // Floating pill loader
        var loaderContainer = document.createElement('div');
        loaderContainer.id = 'wm-global-loader';
        loaderContainer.className = 'wm-global-loader';
        loaderContainer.setAttribute('aria-live', 'polite');
        loaderContainer.setAttribute('role', 'status');
        loaderContainer.innerHTML = [
            '<div class="wm-loader-card">',
            '  <div class="wm-loader-spinner">',
            '    <svg class="wm-spin-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.75" stroke-linecap="round" stroke-linejoin="round">',
            '      <circle cx="12" cy="12" r="10" stroke-opacity="0.2"></circle>',
            '      <path d="M12 2a10 10 0 0 1 10 10" stroke="currentColor"></path>',
            '    </svg>',
            '  </div>',
            '  <div class="wm-loader-text">',
            '    <span class="wm-loader-msg" id="wm-loader-msg">Loading...</span>',
            '    <span class="wm-loader-sub" id="wm-loader-sub">WholeMart API</span>',
            '  </div>',
            '  <span class="wm-loader-badge" id="wm-loader-badge" style="display:none">1</span>',
            '</div>'
        ].join('');

        // Ensure styles are present in head
        if (!document.getElementById('wm-loader-dynamic-style')) {
            var style = document.createElement('style');
            style.id = 'wm-loader-dynamic-style';
            style.textContent = [
                '.wm-global-progress{position:fixed;top:0;left:0;width:100%;height:3.5px;z-index:2147483647;pointer-events:none;opacity:0;transition:opacity .25s ease;}',
                '.wm-global-progress.is-active{opacity:1;}',
                '.wm-global-progress-bar{height:100%;width:0%;background:linear-gradient(90deg,#10b981 0%,#059669 35%,#2563eb 70%,#6366f1 100%);box-shadow:0 0 12px rgba(16,185,129,.9),0 0 6px rgba(37,99,235,.6);border-radius:0 3px 3px 0;transition:width .22s cubic-bezier(.4,0,.2,1);}',
                '.wm-global-loader{position:fixed;bottom:24px;right:24px;z-index:2147483646;pointer-events:none;opacity:0;transform:translateY(14px) scale(.95);transition:opacity .25s cubic-bezier(.16,1,.3,1),transform .25s cubic-bezier(.16,1,.3,1);}',
                '.wm-global-loader.is-active{opacity:1;transform:translateY(0) scale(1);pointer-events:auto;}',
                '.wm-loader-card{display:flex;align-items:center;gap:10px;background:rgba(18,24,31,.94);color:#ffffff;backdrop-filter:blur(14px);-webkit-backdrop-filter:blur(14px);border:1px solid rgba(255,255,255,.16);border-radius:9999px;padding:8px 16px 8px 12px;box-shadow:0 12px 32px rgba(0,0,0,.32),0 2px 8px rgba(0,0,0,.16);font-family:system-ui,-apple-system,sans-serif;font-size:13px;font-weight:500;user-select:none;}',
                '.wm-loader-spinner{width:20px;height:20px;display:flex;align-items:center;justify-content:center;color:#10b981;flex-shrink:0;}',
                '.wm-loader-spinner svg.wm-spin-icon{width:100%;height:100%;animation:wm-spin-animation .75s linear infinite;}',
                '@keyframes wm-spin-animation{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}',
                '.wm-loader-text{display:flex;flex-direction:column;line-height:1.25;}',
                '.wm-loader-msg{font-weight:600;color:#ffffff;letter-spacing:-0.01em;}',
                '.wm-loader-sub{font-size:10px;color:rgba(255,255,255,.65);font-family:monospace;text-transform:uppercase;letter-spacing:.06em;}',
                '.wm-loader-badge{background:#10b981;color:#064e3b;font-size:10px;font-weight:700;padding:1px 7px;border-radius:9999px;margin-left:2px;}',
                'button.wm-btn-loading{opacity:.75;pointer-events:none;position:relative;}'
            ].join('');
            (document.head || document.documentElement).appendChild(style);
        }

        var root = document.body || document.documentElement;
        root.appendChild(progressContainer);
        root.appendChild(loaderContainer);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', ensureLoaderDom);
    } else {
        ensureLoaderDom();
    }

    function setProgress(percent) {
        currentProgress = percent;
        var bar = document.getElementById('wm-global-progress-bar');
        var progress = document.getElementById('wm-global-progress');
        if (bar && progress) {
            progress.classList.add('is-active');
            bar.style.width = percent + '%';
        }
    }

    var WmLoader = {
        start: function (method, url, customMsg) {
            ensureLoaderDom();
            activeCount++;

            var msg = customMsg;
            if (!msg) {
                var m = (method || 'GET').toUpperCase();
                if (m === 'POST') msg = 'Processing POST request...';
                else if (m === 'PUT' || m === 'PATCH') msg = 'Updating records...';
                else if (m === 'DELETE') msg = 'Deleting...';
                else msg = 'Loading data...';
            }

            var msgEl = document.getElementById('wm-loader-msg');
            var subEl = document.getElementById('wm-loader-sub');
            var badgeEl = document.getElementById('wm-loader-badge');
            var loaderEl = document.getElementById('wm-global-loader');
            var progressEl = document.getElementById('wm-global-progress');

            if (msgEl) msgEl.textContent = msg;
            if (subEl) {
                var urlLabel = '';
                try {
                    if (url) {
                        var parsed = new URL(url, window.location.href);
                        urlLabel = parsed.pathname;
                        if (urlLabel.length > 28) urlLabel = urlLabel.slice(0, 26) + '…';
                    }
                } catch (e) {
                    urlLabel = (url || '').slice(0, 28);
                }
                subEl.textContent = urlLabel ? (method ? method.toUpperCase() + ' ' : '') + urlLabel : 'WholeMart API';
            }

            if (badgeEl) {
                if (activeCount > 1) {
                    badgeEl.style.display = 'inline-block';
                    badgeEl.textContent = activeCount;
                } else {
                    badgeEl.style.display = 'none';
                }
            }

            if (loaderEl) loaderEl.classList.add('is-active');
            if (progressEl) progressEl.classList.add('is-active');

            if (activeCount === 1) {
                setProgress(25);
                clearInterval(progressTimer);
                progressTimer = setInterval(function () {
                    if (currentProgress < 85) {
                        setProgress(currentProgress + (85 - currentProgress) * 0.18);
                    }
                }, 200);
            }

            clearTimeout(safetyTimer);
            safetyTimer = setTimeout(function () {
                activeCount = 0;
                WmLoader.finish();
            }, 15000);
        },

        finish: function () {
            activeCount = Math.max(0, activeCount - 1);
            var badgeEl = document.getElementById('wm-loader-badge');
            if (badgeEl) {
                if (activeCount > 1) {
                    badgeEl.style.display = 'inline-block';
                    badgeEl.textContent = activeCount;
                } else {
                    badgeEl.style.display = 'none';
                }
            }

            if (activeCount === 0) {
                clearInterval(progressTimer);
                clearTimeout(safetyTimer);
                setProgress(100);

                setTimeout(function () {
                    var progressEl = document.getElementById('wm-global-progress');
                    var loaderEl = document.getElementById('wm-global-loader');
                    var bar = document.getElementById('wm-global-progress-bar');
                    if (progressEl) progressEl.classList.remove('is-active');
                    if (loaderEl) loaderEl.classList.remove('is-active');
                    setTimeout(function () {
                        if (bar && activeCount === 0) bar.style.width = '0%';
                    }, 250);
                }, 200);
            }
        },

        show: function (msg) {
            this.start('API', null, msg || 'Loading...');
        },

        hide: function () {
            activeCount = 0;
            this.finish();
        },

        setProgress: setProgress
    };

    window.WmLoader = WmLoader;
    window.showWmLoader = function (msg) { WmLoader.show(msg); };
    window.hideWmLoader = function () { WmLoader.hide(); };
    window.setWmProgress = setProgress;

    // 1. Intercept Global window.fetch
    if (typeof window.fetch === 'function' && !window.__wm_fetch_intercepted) {
        window.__wm_fetch_intercepted = true;
        var nativeFetch = window.fetch;
        window.fetch = function (input, init) {
            var method = 'GET';
            var url = '';
            if (typeof input === 'string') {
                url = input;
            } else if (input && input.url) {
                url = input.url;
            }
            if (init && init.method) {
                method = init.method.toUpperCase();
            } else if (input && input.method) {
                method = input.method.toUpperCase();
            }

            var skip = (init && init.__skipLoader) || false;
            if (!skip) {
                WmLoader.start(method, url);
            }

            try {
                var fetchPromise = nativeFetch.apply(this, arguments);
                return fetchPromise.then(
                    function (res) {
                        if (!skip) WmLoader.finish();
                        return res;
                    },
                    function (err) {
                        if (!skip) WmLoader.finish();
                        throw err;
                    }
                );
            } catch (err) {
                if (!skip) WmLoader.finish();
                throw err;
            }
        };
    }

    // 2. Intercept Global XMLHttpRequest
    if (typeof window.XMLHttpRequest === 'function' && !window.__wm_xhr_intercepted) {
        window.__wm_xhr_intercepted = true;
        var originalOpen = XMLHttpRequest.prototype.open;
        var originalSend = XMLHttpRequest.prototype.send;

        XMLHttpRequest.prototype.open = function (method, url) {
            this.__wm_method = method ? method.toUpperCase() : 'GET';
            this.__wm_url = url || '';
            return originalOpen.apply(this, arguments);
        };

        XMLHttpRequest.prototype.send = function () {
            var self = this;
            var isSkip = this.__wm_skipLoader || false;
            if (!isSkip) {
                WmLoader.start(this.__wm_method || 'GET', this.__wm_url || '');
                var finished = false;
                var onDone = function () {
                    if (!finished) {
                        finished = true;
                        WmLoader.finish();
                    }
                };
                this.addEventListener('loadend', onDone);
                this.addEventListener('error', onDone);
                this.addEventListener('abort', onDone);
                this.addEventListener('timeout', onDone);
            }
            return originalSend.apply(this, arguments);
        };
    }

    // 3. Intercept Form Submissions
    document.addEventListener('submit', function (event) {
        var form = event.target;
        if (!form || form.dataset.noLoader === 'true' || form.dataset.wmNoLoader) return;
        var method = (form.method || 'GET').toUpperCase();
        var action = form.action || window.location.href;
        var submitBtn = form.querySelector('button[type="submit"], input[type="submit"]');
        if (submitBtn) {
            submitBtn.classList.add('wm-btn-loading');
        }
        WmLoader.start(method, action, method === 'POST' ? 'Submitting form...' : 'Loading...');
    }, true);
})();

(function () {

    function normalize(value) {
        return (value || "").toString().trim().toLowerCase();
    }

    function rowsFromResponse(data) {
        if (Array.isArray(data)) {
            return data;
        }
        if (data && Array.isArray(data.content)) {
            return data.content;
        }
        return [];
    }

    window.wmRows = rowsFromResponse;

    function closestPanel(element) {
        return element.closest(".wm-panel") || document;
    }

    function enhanceTable(table) {
        var panel = closestPanel(table);
        var toolbar = table.closest(".table-responsive")?.previousElementSibling;
        if (!toolbar || !toolbar.classList.contains("wm-toolbar")) {
            toolbar = panel.querySelector(".wm-toolbar");
        }

        var rows = Array.from(table.querySelectorAll("tbody tr"));
        if (rows.length === 0 || table.dataset.enhanced === "true") {
            return;
        }
        table.dataset.enhanced = "true";

        var searchInput = toolbar ? toolbar.querySelector("input[type='search'], input:not([type])") : null;
        var statusSelect = toolbar ? toolbar.querySelector("select") : null;
        if (searchInput) {
            searchInput.setAttribute("type", "search");
        }

        var pageSize = Number(table.dataset.pageSize || 6);
        var currentPage = 1;
        var pagination = document.createElement("div");
        pagination.className = "wm-pagination";
        pagination.innerHTML = '<button type="button" class="btn btn-sm btn-primary" data-page="prev">Previous</button><span></span><button type="button" class="btn btn-sm btn-primary" data-page="next">Next</button>';
        table.closest(".table-responsive").appendChild(pagination);

        function rowMatches(row) {
            if (row.dataset.dismissed === "true") {
                return false;
            }
            var search = normalize(searchInput && searchInput.value);
            var filter = normalize(statusSelect && statusSelect.value);
            var text = normalize(row.textContent);
            var matchesSearch = !search || text.indexOf(search) !== -1;
            var matchesFilter = !filter || filter.indexOf("all") === 0 || text.indexOf(filter) !== -1;
            return matchesSearch && matchesFilter;
        }

        function render() {
            var visibleRows = rows.filter(rowMatches);
            var totalPages = Math.max(1, Math.ceil(visibleRows.length / pageSize));
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }

            rows.forEach(function (row) {
                row.hidden = true;
            });

            visibleRows.slice((currentPage - 1) * pageSize, currentPage * pageSize).forEach(function (row, index) {
                row.hidden = false;
                var firstCell = row.querySelector("td");
                if (firstCell && /^\d+$/.test(firstCell.textContent.trim())) {
                    firstCell.textContent = String((currentPage - 1) * pageSize + index + 1);
                }
            });

            pagination.querySelector("span").textContent = "Page " + currentPage + " of " + totalPages;
            pagination.querySelector('[data-page="prev"]').disabled = currentPage === 1;
            pagination.querySelector('[data-page="next"]').disabled = currentPage === totalPages;
        }

        if (searchInput) {
            searchInput.addEventListener("input", function () {
                currentPage = 1;
                render();
            });
        }
        if (statusSelect) {
            statusSelect.addEventListener("change", function () {
                currentPage = 1;
                render();
            });
        }
        pagination.addEventListener("click", function (event) {
            var direction = event.target.dataset.page;
            if (direction === "prev") currentPage -= 1;
            if (direction === "next") currentPage += 1;
            render();
        });

        table.addEventListener("click", function (event) {
            var button = event.target.closest("button");
            if (!button) {
                return;
            }
            var action = normalize(button.dataset.action || button.textContent);
            var row = button.closest("tr");
            if (!row) {
                return;
            }

            if (action.indexOf("delete") !== -1 || action.indexOf("dismiss") !== -1 || action.indexOf("remove") !== -1) {
                if (action.indexOf("dismiss") !== -1 || window.confirm("Remove this row?")) {
                    row.dataset.dismissed = "true";
                    render();
                }
                return;
            }

            if (action.indexOf("edit") !== -1) {
                row.dataset.original = row.innerHTML;
                Array.from(row.children).slice(1, -1).forEach(function (cell) {
                    if (cell.querySelector("button")) return;
                    var value = cell.textContent.trim();
                    cell.innerHTML = '<input class="form-control form-control-sm" value="' + value.replace(/"/g, "&quot;") + '">';
                });
                button.textContent = "Save";
                button.dataset.action = "save";
                var cancel = document.createElement("button");
                cancel.type = "button";
                cancel.className = "btn btn-sm btn-light ms-1";
                cancel.dataset.action = "cancel";
                cancel.textContent = "Cancel";
                button.after(cancel);
                return;
            }

            if (action.indexOf("save") !== -1) {
                Array.from(row.querySelectorAll("td input")).forEach(function (input) {
                    input.closest("td").textContent = input.value;
                });
                button.textContent = "Edit";
                button.dataset.action = "edit";
                row.querySelector('[data-action="cancel"]')?.remove();
                render();
                return;
            }

            if (action.indexOf("cancel") !== -1 && row.dataset.original) {
                row.innerHTML = row.dataset.original;
            }
        });

        render();
    }

    function wireModalButtons() {
        document.addEventListener("click", function (event) {
            var trigger = event.target.closest("[data-modal-target]");
            if (trigger) {
                var modal = document.querySelector(trigger.dataset.modalTarget);
                if (modal) modal.hidden = false;
            }
            if (event.target.matches("[data-modal-close], .wm-modal")) {
                event.target.closest(".wm-modal").hidden = true;
            }
        });
    }

    function wireAppSidebar() {
        var menuButton = document.querySelector(".wm-menu");
        var sidebar = document.querySelector(".wm-sidebar");
        if (!menuButton || !sidebar) {
            return;
        }

        var desktopQuery = window.matchMedia("(min-width: 901px)");

        function setOpen(open) {
            document.body.classList.toggle("wm-sidebar-open", open);
            sidebar.classList.toggle("open", open);
            menuButton.classList.toggle("is-active", open);
            menuButton.setAttribute("aria-expanded", String(open));
            menuButton.setAttribute("aria-label", open ? "Close menu" : "Open menu");
        }

        function toggle() {
            setOpen(!document.body.classList.contains("wm-sidebar-open"));
        }

        menuButton.addEventListener("click", function (event) {
            event.stopPropagation();
            toggle();
        });

        document.addEventListener("click", function (event) {
            if (!desktopQuery.matches &&
                    document.body.classList.contains("wm-sidebar-open") &&
                    !event.target.closest(".wm-sidebar") &&
                    !event.target.closest(".wm-menu")) {
                setOpen(false);
            }
        });

        sidebar.querySelectorAll("a").forEach(function (link) {
            link.addEventListener("click", function () {
                if (!desktopQuery.matches) {
                    setOpen(false);
                }
            });
        });

        desktopQuery.addEventListener("change", function (event) {
            setOpen(event.matches);
        });

        setOpen(desktopQuery.matches);
    }

    function wireProfileMenu() {
        var menu = document.querySelector("[data-profile-menu]");
        if (!menu) {
            return;
        }
        var trigger = menu.querySelector(".wm-user-trigger");
        var popover = menu.querySelector(".wm-profile-popover");
        if (!trigger || !popover) {
            return;
        }

        function setOpen(open) {
            menu.classList.toggle("is-open", open);
            popover.hidden = !open;
            trigger.setAttribute("aria-expanded", String(open));
        }

        trigger.addEventListener("click", function (event) {
            event.stopPropagation();
            setOpen(popover.hidden);
        });

        document.addEventListener("click", function (event) {
            if (!menu.contains(event.target)) {
                setOpen(false);
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                setOpen(false);
                trigger.focus();
            }
        });
    }

    function normalizeStatIcons() {
        var iconMap = [
            ["revenue", "banknote"],
            ["paid", "banknote"],
            ["earning", "banknote"],
            ["warning", "alert-triangle"],
            ["pending", "clock"],
            ["active", "check-circle"],
            ["delivered", "truck"],
            ["delivery", "truck"],
            ["driver", "truck"],
            ["order", "shopping-cart"],
            ["inventory", "package"],
            ["item", "package"],
            ["alert", "alert-circle"],
            ["info", "info"],
            ["total", "bar-chart-3"],
            ["completed", "check-check"],
            ["cart", "shopping-bag"],
            ["user", "user"],
            ["report", "file-text"],
            ["approval", "shield-check"]
        ];

        document.querySelectorAll(".wm-stat, .status, .wm-status").forEach(function (el) {
            var text = normalize(el.textContent);
            var iconName = null;
            for (var i = 0; i < iconMap.length; i += 1) {
                if (text.indexOf(iconMap[i][0]) !== -1) {
                    iconName = iconMap[i][1];
                    break;
                }
            }

            if (iconName) {
                var iconContainer = el.querySelector(".wm-stat-icon");
                if (iconContainer) {
                    iconContainer.innerHTML = '<i data-lucide="' + iconName + '"></i>';
                } else if (!el.querySelector('i[data-lucide]')) {
                    el.insertAdjacentHTML('afterbegin', '<i data-lucide="' + iconName + '" class="me-1" style="width:12px;height:12px"></i>');
                }
            }
        });
        if (window.lucide) {
            lucide.createIcons();
        }
    }

    function upgradePlainTables() {
        document.querySelectorAll("table.wm-table").forEach(function (table) {
            if (!table.closest(".wm-table-wrap")) {
                var wrapper = document.createElement("div");
                wrapper.className = "wm-table-wrap";
                table.parentNode.insertBefore(wrapper, table);
                wrapper.appendChild(table);
            }
            table.querySelectorAll("button").forEach(function (button) {
                button.classList.add("btn", "btn-sm");
                if (button.textContent.toLowerCase().indexOf("delete") !== -1 ||
                        button.textContent.toLowerCase().indexOf("dismiss") !== -1) {
                    button.classList.add("btn-outline-danger");
                } else {
                    button.classList.add("btn-outline-success");
                }
            });
        });
    }

document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".table").forEach(enhanceTable);
        wireModalButtons();
        wireAppSidebar();
        wireProfileMenu();
        normalizeStatIcons();
        upgradePlainTables();

        // Fix home-page "Sign in" not responding:
        // some pages don't load the home.jsp inline modal JS; ensure the link navigates.
        // (The home.jsp inline handler will still work when present.)
        var authOpeners = document.querySelectorAll(".js-auth-open");
        authOpeners.forEach(function (a) {
            a.addEventListener("click", function () {
                var modal = document.getElementById("homeAuthModal");
                if (!modal) {
                    return; // let browser navigate normally
                }

                // If the inline modal JS is present, it will toggle the modal.
                // If not, keep default navigation.
                // We do NOT preventDefault here.
            }, { capture: true });
        });

        if (window.lucide) {
            lucide.createIcons();
        }
    });
})();
