<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Nearby Distributors</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">

</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main>
            <div class="wm-home-container">

                <section class="wm-home-hero" aria-label="Nearby Distributors">

                    <!-- Data table (requires js enabled) -->
                    <h1 class="wm-title">Nearby Distributors</h1>
                    <p class="wm-subtitle">Find distributors serving your location</p>

                    <div class="wm-stats">
                        <div class="wm-stat">
                            <div class="wm-stat-icon">T</div>
                            <div><b id="totalDistributors">0</b><span>Total</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon">A</div>
                            <div><b id="approvedDistributors">0</b><span>Approved</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon">O</div>
                            <div><b id="onlineDistributors">0</b><span>Available</span></div>
                        </div>
                    </div>

                    <div class="wm-toolbar">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <input id="distributorSearch" class="wm-input" type="search" placeholder="Search">
                            </div>
                            <div class="col-md-3">
                                <select class="wm-select" disabled>
                                    <option>All Statuses</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <table class="wm-table">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Business Name</th>
                                <th>Shop / Contact</th>
                                <th>Location</th>
                                <th>GSTIN</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="distributorsBody">
                            <tr>
                                <td colspan="6">Loading distributors...</td>
                            </tr>
                        </tbody>
                    </table>

                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            var distributorsBody = document.getElementById("distributorsBody");
                            var distributorSearch = document.getElementById("distributorSearch");
                            var distributors = [];

                            function setText(id, value) {
                                var element = document.getElementById(id);
                                if (element) element.textContent = value;
                            }

                            function render() {
                                var query = (distributorSearch.value || "").toLowerCase();
                                var filtered = distributors.filter(function (distributor) {
                                    var searchable = [
                                        distributor.businessName,
                                        distributor.shopName,
                                        distributor.contactName,
                                        distributor.city,
                                        distributor.state,
                                        distributor.gstin
                                    ].join(" ").toLowerCase();
                                    return !query || searchable.indexOf(query) !== -1;
                                });

                                distributorsBody.innerHTML = filtered.length ? filtered.map(function (distributor, index) {
                                    var shopContact = [distributor.shopName, distributor.contactName]
                                        .map(function(s) { return (s || "").trim(); }).filter(Boolean).join(" / ") || "-";

                                    var location = [distributor.city, distributor.state, distributor.pincode, distributor.addressLine]
                                        .map(function(s) { return (s || "").toString().trim(); }).filter(Boolean).join(", ") || "-";

                                    var productsUrl = "/web/retailer/products?distributorUserId=" +
                                        encodeURIComponent(distributor.userId) +
                                        "&distributorName=" +
                                        encodeURIComponent(distributor.businessName || "Distributor");

                                    return "<tr>" +
                                        "<td>" + (index + 1) + "</td>" +
                                        "<td>" + (distributor.businessName || "-") + "</td>" +
                                        "<td>" + shopContact + "</td>" +
                                        "<td>" + location + "</td>" +
                                        "<td>" + (distributor.gstin || "-") + "</td>" +
                                        "<td><a class=\"wm-btn wm-btn-secondary\" href=\"" + productsUrl + "\">Products</a></td>" +
                                        "</tr>";
                                }).join("") :
                                    "<tr><td colspan=\"6\">No nearby distributors found in the database.</td></tr>";
                            }

                            fetch("/api/v1/distributors/nearby/summary")
                                .then(function (response) { return response.json(); })
                                .then(function (data) {
                                    var approved = Number(data.approved || 0);
                                    var total = Number(data.total);
                                    setText("totalDistributors", total);
                                    setText("approvedDistributors", approved);
                                    setText("onlineDistributors", approved);
                                })
                                .catch(function () {
                                    setText("totalDistributors", 0);
                                    setText("approvedDistributors", 0);
                                    setText("onlineDistributors", 0);
                                });

                            fetch("/api/v1/distributors/nearby")
                                .then(function (response) { return response.json(); })
                                .then(function (data) {
                                    // Some endpoints return {rows:[...]} or {content:[...]}; normalize.
                                    var normalized = data;
                                    if (data && typeof data === 'object') {
                                        if (Array.isArray(data.rows)) normalized = data.rows;
                                        else if (Array.isArray(data.content)) normalized = data.content;
                                        else if (Array.isArray(data.data)) normalized = data.data;
                                    }
                                    console.log("[distributors] /api/v1/distributors/nearby response:", data);
                                    // /api/v1/distributors/nearby returns List<DistributorProfileDto> (plain array)
                                    distributors = Array.isArray(normalized) ? normalized : (Array.isArray(data) ? data : []);
                                    console.log("[distributors] normalized length:", Array.isArray(distributors) ? distributors.length : 'n/a');
                                    render();
                                })
                                .catch(function (e) {
                                    distributorsBody.innerHTML = "<tr><td colspan=\"6\">Unable to load distributors from the database.</td></tr>";
                                });

                            distributorSearch.addEventListener("input", render);

                            // If API returns HTML/text or fails silently, show what we got for debugging
                            // (no-op in production unless you check page source)
                        });
                    </script>

                </section>

                <%@ include file="/WEB-INF/common/footer.jsp" %>

            </div>
        </main>
    </div>

</body>

</html>
