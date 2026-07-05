/* Page-specific scripts for retailer\distributors.jsp */

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
            var shopContact = [distributor.shopName, distributor.contactName].filter(Boolean).join(" / ") || "-";
            var location = [distributor.city, distributor.state, distributor.pincode].filter(Boolean).join(", ") || distributor.addressLine || "-";
            var productsUrl = "/web/retailer/products?distributorUserId=" + encodeURIComponent(distributor.userId) + "&distributorName=" + encodeURIComponent(distributor.businessName || "Distributor");
            return "<tr><td>" + (index + 1) + "</td><td>" + (distributor.businessName || "-") + "</td><td>" + shopContact + "</td><td>" + location + "</td><td>" + (distributor.gstin || "-") + "</td><td><a class=\"wm-btn wm-btn-secondary\" href=\"" + productsUrl + "\">Products</a></td></tr>";
        }).join("") : "<tr><td colspan=\"6\">No nearby distributors found in the database.</td></tr>";
    }

    wmFetch("/api/v1/distributors/nearby/summary").then(function (response) { return response.json(); }).then(function (data) {
        var approved = Number(data.approved || 0);
        var total = Number(data.total);
        setText("totalDistributors", total);
        setText("approvedDistributors", approved);
        setText("onlineDistributors", approved);
    }).catch(function () {
        setText("totalDistributors", 0);
        setText("approvedDistributors", 0);
        setText("onlineDistributors", 0);
    });

    wmFetch("/api/v1/distributors/nearby").then(function (response) { return response.json(); }).then(function (data) {
        distributors = wmRows(data);
        render();
    }).catch(function () {
        distributorsBody.innerHTML = "<tr><td colspan=\"6\">Unable to load distributors from the database.</td></tr>";
    });
    distributorSearch.addEventListener("input", render);
});
