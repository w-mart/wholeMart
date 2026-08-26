<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WholeMart | Distributor Inventory</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap"
            rel="stylesheet">
        <link href="/css/common.css" rel="stylesheet">
        <link href="/css/orders.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">

    </head>

    <body class="wm-home">

        <% String wmUserName=session.getAttribute("name")==null ? "Guest" :
            String.valueOf(session.getAttribute("name")); String wmUserInitial=wmUserName.substring(0,1).toUpperCase();
            %>

            <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

                <div class="wm-app">

                    <main>
                        <div class="wm-home-container wm-distributor-inventory">
                            <section class="wm-home-reports mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">ANALYTICS</span>
                                    <h2>Reports & Business Intelligence</h2>
                                    <p>Real-time insights into inventory, fulfillment and business growth.</p>
                                </div>

                                <div class="row g-4">

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Inventory Health</h3>
                                                <div class="wm-ring is-success" style="--pct:92"><span>92%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Total Products</span><strong
                                                    id="reportTotalItems">0</strong></div>
                                            <div class="wm-report-item"><span>Categories</span><strong
                                                    id="reportCategoryCount">0</strong></div>
                                            <div class="wm-report-item"><span>Availability</span><strong
                                                    style="color:var(--wm-success)">92%</strong></div>
                                            <div class="wm-report-item"><span>Out of Stock</span><strong
                                                    style="color:var(--wm-danger)">0</strong></div>
                                        </article>
                                    </div>

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Order Performance</h3>
                                                <div class="wm-ring is-success" style="--pct:98"><span>98%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Total Orders</span><strong
                                                    id="reportTotalOrders">0</strong></div>
                                            <div class="wm-report-item"><span>Running Orders</span><strong
                                                    id="reportActiveOrders">0</strong></div>
                                            <div class="wm-report-item"><span>Success Rate</span><strong
                                                    style="color:var(--wm-success)">98.4%</strong></div>
                                            <div class="wm-report-item"><span>Rejected</span><strong>0</strong></div>
                                        </article>
                                    </div>

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Business Growth</h3>
                                                <div class="wm-ring" style="--pct:78"><span>78%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Retailers</span><strong>84</strong></div>
                                            <div class="wm-report-item"><span>Revenue Trend</span><strong
                                                    style="color:var(--wm-success)">+12%</strong></div>
                                            <div class="wm-report-item"><span>Expansion</span><strong>2 Cities</strong>
                                            </div>
                                            <div class="wm-report-item"><span>Target
                                                    Achievement</span><strong>78%</strong></div>
                                        </article>
                                    </div>

                                </div>
                            </section>
                            <div class="wm-inventory-divider" aria-hidden="true"></div>
                            <section class="wm-inventory-panel" aria-labelledby="inventoryListTitle">
                                <div class="wm-inventory-panel-header">
                                    <div>
                                        <span class="wm-kicker">INVENTORY</span>
                                        <h3 id="inventoryListTitle">Product catalog</h3>
                                        <p>Search, review, and manage the products available to your retailers.</p>
                                    </div>
                                    <a class="home-btn home-btn-primary" href="/web/distributor/add-product"><i class="bi bi-plus-lg" aria-hidden="true"></i> Add product</a>
                                </div>
                                <div class="wm-toolbar">
                                    <div class="wm-search-field">
                                        <i class="bi bi-search" aria-hidden="true"></i>
                                        <input id="productSearch" class="wm-input" type="search" placeholder="Search products, SKU, category..." aria-label="Search products">
                                    </div>
                                    <div class="wm-filter-field"><select id="categoryFilter" class="wm-select" aria-label="Filter products by category">
                                            <option>All Products</option>
                                        </select></div>
                                </div>
                            <div class="wm-table-container" tabindex="0">
                                <table class="wm-table">
                                <thead>
                                    <tr>
                                        <th>S.No</th>
                                        <th>SKU</th>
                                        <th>Product Name</th>
                                        <th>Brand</th>
                                        <th>Category</th>
                                        <th>Qty</th>
                                        <th>Price</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="productsBody">
                                    <tr class="wm-skel-tr">
                                        <td><div class="wm-shimmer" style="height:16px; width:24px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:80px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:160px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:70px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:90px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:45px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:65px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:26px; width:55px; border-radius:4px;"></div></td>
                                    </tr>
                                    <tr class="wm-skel-tr">
                                        <td><div class="wm-shimmer" style="height:16px; width:24px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:80px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:140px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:70px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:85px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:45px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:65px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:26px; width:55px; border-radius:4px;"></div></td>
                                    </tr>
                                    <tr class="wm-skel-tr">
                                        <td><div class="wm-shimmer" style="height:16px; width:24px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:80px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:180px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:70px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:75px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:45px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:65px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:26px; width:55px; border-radius:4px;"></div></td>
                                    </tr>
                                    <tr class="wm-skel-tr">
                                        <td><div class="wm-shimmer" style="height:16px; width:24px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:80px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:150px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:70px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:95px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:45px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:16px; width:65px; border-radius:4px;"></div></td>
                                        <td><div class="wm-shimmer" style="height:26px; width:55px; border-radius:4px;"></div></td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>
                            <div class="wm-pagination">
                                <button id="prevPage" class="wm-btn wm-btn-secondary" disabled>Prev</button>
                                <span id="pageInfo"></span>
                                <button id="nextPage" class="wm-btn wm-btn-secondary" disabled>Next</button>
                            </div>
                            </section>
                        </div>
                    </main>
                    <%@ include file="/WEB-INF/common/footer.jsp" %>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var productsBody = document.getElementById("productsBody");
                        var productSearch = document.getElementById("productSearch");
                        var categoryFilter = document.getElementById("categoryFilter");
                        var prevPageBtn = document.getElementById("prevPage");
                        var nextPageBtn = document.getElementById("nextPage");
                        var pageInfo = document.getElementById("pageInfo");
                        var currentPage = 1;
                        var rowsPerPage = 5;
                        var products = [];

                        function money(value) {
                            return "Rs. " + Number(value || 0).toFixed(2);
                        }

                        function setText(id, value) {
                            var element = document.getElementById(id);
                            if (element) element.textContent = value;
                        }

                        function render() {
                            var query = (productSearch.value || "").toLowerCase();
                            var filtered = products.filter(function (product) {
                                var matchesSearch = !query || [product.sku, product.name, product.brand, product.category].join(" ").toLowerCase().indexOf(query) !== -1;
                                var matchesCategory = !categoryFilter.value || categoryFilter.value === "All Products" || product.category === categoryFilter.value;
                                return matchesSearch && matchesCategory;
                            });

                            var totalPages = Math.ceil(filtered.length / rowsPerPage);
                            if (currentPage > totalPages && totalPages > 0) {
                                currentPage = totalPages;
                            }

                            var start = (currentPage - 1) * rowsPerPage;
                            var end = start + rowsPerPage;
                            var paginatedItems = filtered.slice(start, end);

                            productsBody.innerHTML = paginatedItems.length ? paginatedItems.map(function (product, index) {
                                var qty = product.stockQuantity == null ? "-" : product.stockQuantity;
                                var sku = product.sku || ("PRD-" + String(product.id).padStart(5, "0"));
                                var brand = product.brand || "-";
                                return "<tr><td>" + (start + index + 1) + "</td><td>" + sku + "</td><td>" + product.name + "</td><td>" + brand + "</td><td>" + product.category + "</td><td>" + qty + "</td><td>" + money(product.unitPrice) + "</td><td><button class=\"wm-btn wm-btn-secondary\" type=\"button\">View</button></td></tr>";
                            }).join("") : "<tr><td colspan=\"8\">No inventory found for your distributor account.</td></tr>";

                            prevPageBtn.disabled = currentPage === 1;
                            nextPageBtn.disabled = currentPage === totalPages || totalPages === 0;

                            if (totalPages > 0) {
                                pageInfo.textContent = "Page " + currentPage + " of " + totalPages;
                            } else {
                                pageInfo.textContent = "";
                            }

                            setText("reportTotalItems", products.length);
                            setText("reportCategoryCount", new Set(products.map(function (product) { return product.category; }).filter(Boolean)).size);
                        }

                        fetch("/api/v1/products/mine")
                            .then(function (response) {
                                return response.json().then(function (body) {
                                    return { ok: response.ok, status: response.status, body: body };
                                });
                            })
                            .then(function (result) {
                                console.log('[/api/v1/products/mine] status=', result.status, 'body=', result.body);

                                if (!result.ok) {
                                    products = [];
                                    productsBody.innerHTML = "<tr><td colspan=\"8\">Unable to load inventory. Status: " + result.status + "</td></tr>";
                                    setText("reportTotalItems", 0);
                                    setText("reportCategoryCount", 0);
                                    return;
                                }

                                // API returns List<ProductDto>: [ {id, distributorUserId, name, category, unitPrice}, ... ]
                                products = Array.isArray(result.body) ? result.body : [];
                                var categories = Array.from(new Set(products.map(function (product) { return product.category; }).filter(Boolean))).sort();
                                categoryFilter.innerHTML = "<option value=\"All Products\">All products</option>" + categories.map(function (category) {
                                    return "<option value=\"" + category.replace(/&/g, "&amp;").replace(/\"/g, "&quot;") + "\">" + category.replace(/&/g, "&amp;").replace(/</g, "&lt;") + "</option>";
                                }).join("");
                                console.log('[/api/v1/products/mine] products.length=', products.length);

                                render();
                            }).catch(function () {
                                productsBody.innerHTML = "<tr><td colspan=\"8\">Unable to load inventory from the database.</td></tr>";
                            });
                        productSearch.addEventListener("input", function() {
                            currentPage = 1;
                            render();
                        });

                        categoryFilter.addEventListener("change", function() {
                            currentPage = 1;
                            render();
                        });

                        prevPageBtn.addEventListener("click", function() {
                            if (currentPage > 1) currentPage--;
                            render();
                        });

                        nextPageBtn.addEventListener("click", function() {
                            if (!nextPageBtn.disabled) currentPage++;
                            render();
                        });
                    });
                </script>
    </body>

    </html>
