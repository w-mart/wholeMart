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
        var userClosedSidebar = false;

        function setOpen(open) {
            document.body.classList.toggle("wm-sidebar-open", open);
            sidebar.classList.toggle("open", open);
            menuButton.classList.toggle("is-active", open);
            menuButton.setAttribute("aria-expanded", String(open));
            menuButton.setAttribute("aria-label", open ? "Close menu" : "Open menu");
        }

        function toggle() {
            userClosedSidebar = !document.body.classList.contains("wm-sidebar-open");
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
                userClosedSidebar = true;
                setOpen(false);
            }
        });

        sidebar.querySelectorAll("a").forEach(function (link) {
            link.addEventListener("click", function () {
                userClosedSidebar = true;
                setOpen(false);
            });
        });

        desktopQuery.addEventListener("change", function () {
            if (!userClosedSidebar) {
                setOpen(false);
            }
        });

        setOpen(false);
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
            ["revenue", "$"],
            ["paid", "$"],
            ["earning", "$"],
            ["warning", "!"],
            ["pending", "P"],
            ["active", "A"],
            ["delivered", "D"],
            ["delivery", "D"],
            ["driver", "D"],
            ["order", "O"],
            ["inventory", "I"],
            ["item", "I"],
            ["alert", "!"],
            ["info", "i"],
            ["total", "T"],
            ["completed", "C"],
            ["cart", "C"],
            ["user", "U"],
            ["report", "R"],
            ["approval", "A"]
        ];

        document.querySelectorAll(".wm-stat").forEach(function (stat) {
            var icon = stat.querySelector(".wm-stat-icon");
            if (!icon) {
                return;
            }
            var text = normalize(stat.textContent);
            var replacement = "W";
            for (var i = 0; i < iconMap.length; i += 1) {
                if (text.indexOf(iconMap[i][0]) !== -1) {
                    replacement = iconMap[i][1];
                    break;
                }
            }
            icon.textContent = replacement;
        });
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
    });
})();
