/* Page-specific scripts for distributor\orders.jsp */

document.addEventListener("DOMContentLoaded", function () {
                                var ordersBody = document.getElementById("ordersBody");
                                var orderSearch = document.getElementById("orderSearch");
                                var statusFilter = document.getElementById("statusFilter");
                                var orders = [];

                                function money(value) {
                                    return "Rs. " + Number(value || 0).toFixed(2);
                                }

                                function setText(id, value) {
                                    var element = document.getElementById(id);
                                    if (element) element.textContent = value;
                                }

                                function escapeHtml(value) {
                                    return String(value || "")
                                        .replace(/&/g, "&amp;")
                                        .replace(/</g, "&lt;")
                                        .replace(/>/g, "&gt;")
                                        .replace(/"/g, "&quot;")
                                        .replace(/'/g, "&#39;");
                                }

                                function render() {
                                    var query = (orderSearch.value || "").toLowerCase();
                                    var status = statusFilter.value;
                                    var filtered = orders.filter(function (order) {
                                        var text = [order.id, order.retailerName, order.retailerLocation, order.status, order.paymentMode].join(" ").toLowerCase();
                                        return (!query || text.indexOf(query) !== -1) && (!status || order.status === status);
                                    });
                                    ordersBody.innerHTML = filtered.length ? filtered.map(function (order, index) {
                                        var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
                                        var retailerName = escapeHtml(order.retailerName || "#" + order.retailerUserId);
                                        var retailerLocation = escapeHtml(order.retailerLocation || "Location not available");
                                        var action = "<a class=\"wm-btn wm-btn-secondary\" href=\"/web/distributor/orders/view?id=" + encodeURIComponent(order.id) + "\">View</a>";
                                        return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(order.id).padStart(5, "0") + "</td><td><strong>" + retailerName + "</strong><br><small>" + retailerLocation + "</small></td><td>" + money(order.totalAmount) + "</td><td>" + order.status + "</td><td>" + date + "</td><td>" + action + "</td></tr>";
                                    }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
                                    setText("totalOrders", orders.length);
                                    setText("placedOrders", orders.filter(function (order) { return order.status === "PLACED"; }).length);
                                    setText("acceptedOrders", orders.filter(function (order) { return order.status === "ACCEPTED"; }).length);
                                }

                                function load() {
                                    wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
                                        orders = wmRows(data);
                                        render();
                                    }).catch(function () {
                                        ordersBody.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>";
                                    });
                                }
                                orderSearch.addEventListener("input", render);
                                statusFilter.addEventListener("change", render);
                                load();
                            });
