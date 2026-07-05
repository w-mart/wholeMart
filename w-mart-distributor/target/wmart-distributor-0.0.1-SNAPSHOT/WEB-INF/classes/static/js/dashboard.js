/* Page-specific scripts for distributor\dashboard.jsp */

document.addEventListener("DOMContentLoaded", function () {
            var form = document.getElementById("wmDashboardAiForm");
            var input = document.getElementById("wmDashboardAiMessage");
            var voiceButton = document.getElementById("wmDashboardAiVoice");
            var responseBox = document.getElementById("wmDashboardAiResponse");
            var actionBox = document.getElementById("wmDashboardAiActionBox");
            var quickButtons = document.getElementById("wmDashboardAiQuickButtons");
            var performanceBrief = document.getElementById("performanceBrief");
            var attentionList = document.getElementById("wmAttentionList");
            var dashboardState = {
                orders: [],
                products: [],
                payments: [],
                deliveries: []
            };

            if (!form || !input || !responseBox) {
                return;
            }

            var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            var recognition = SpeechRecognition ? new SpeechRecognition() : null;
            var voiceHadError = false;
            var finalTranscript = "";

            if (recognition) {
                recognition.lang = "en-IN";
                recognition.interimResults = true;
                recognition.continuous = false;

                recognition.addEventListener("start", function () {
                    voiceHadError = false;
                    finalTranscript = "";
                    input.value = "";
                    voiceButton.classList.add("is-listening");
                    voiceButton.setAttribute("aria-label", "Stop voice input");
                    voiceButton.setAttribute("title", "Stop voice input");
                    responseBox.textContent = "Listening...";
                });

                recognition.addEventListener("result", function (event) {
                    var interimTranscript = "";
                    for (var i = event.resultIndex; i < event.results.length; i += 1) {
                        if (event.results[i].isFinal) {
                            finalTranscript += event.results[i][0].transcript;
                        } else {
                            interimTranscript += event.results[i][0].transcript;
                        }
                    }
                    input.value = (finalTranscript + " " + interimTranscript).trim();
                });

                recognition.addEventListener("end", function () {
                    voiceButton.classList.remove("is-listening");
                    voiceButton.setAttribute("aria-label", "Start voice input");
                    voiceButton.setAttribute("title", "Start voice input");
                    if (voiceHadError) {
                        return;
                    }
                    input.value = (finalTranscript || input.value).trim();
                    if (input.value) {
                        window.askAi();
                    } else {
                        responseBox.textContent = "No voice input heard.";
                    }
                });

                recognition.addEventListener("error", function (event) {
                    voiceHadError = true;
                    voiceButton.classList.remove("is-listening");
                    voiceButton.setAttribute("aria-label", "Start voice input");
                    voiceButton.setAttribute("title", "Start voice input");
                    responseBox.textContent = event.error === "not-allowed"
                        ? "Microphone permission is blocked."
                        : "Voice input is not available right now.";
                });
            } else if (voiceButton) {
                voiceButton.disabled = true;
                voiceButton.title = "Voice input is not supported in this browser";
            }

            function setText(id, value) {
                var element = document.getElementById(id);
                if (element) {
                    element.textContent = value;
                }
            }

            function money(value) {
                return "Rs. " + Number(value || 0).toFixed(2);
            }

            function startOfDay(date) {
                return new Date(date.getFullYear(), date.getMonth(), date.getDate());
            }

            function daysAgo(days) {
                var date = startOfDay(new Date());
                date.setDate(date.getDate() - days);
                return date;
            }

            function percentChange(current, previous) {
                if (!previous) {
                    return current ? "new activity" : "0% change";
                }
                var percent = ((current - previous) / previous) * 100;
                return (percent >= 0 ? "up " : "down ") + Math.abs(percent).toFixed(1) + "%";
            }

            function sumOrders(orders, fromDate, toDate) {
                return orders.reduce(function (total, order) {
                    var created = order.createdAt ? new Date(order.createdAt) : null;
                    if (!created || created < fromDate || created >= toDate) {
                        return total;
                    }
                    return total + Number(order.totalAmount || 0);
                }, 0);
            }

            function countOrders(orders, fromDate, toDate) {
                return orders.filter(function (order) {
                    var created = order.createdAt ? new Date(order.createdAt) : null;
                    return created && created >= fromDate && created < toDate;
                }).length;
            }

            function normalizeRows(data) {
                if (window.wmRows) {
                    return window.wmRows(data);
                }
                return Array.isArray(data) ? data : [];
            }

            function buildAttentionItem(title, detail, href, actionText, tone) {
                return '<div class="wm-attention-item ' + (tone || '') + '">'
                    + '<strong>' + title + '</strong>'
                    + '<span>' + detail + '</span>'
                    + '<a href="' + href + '">' + actionText + '</a>'
                    + '</div>';
            }

            function renderRecommendedActions() {
                if (!attentionList) {
                    return;
                }

                var orders = dashboardState.orders;
                var products = dashboardState.products;
                var payments = dashboardState.payments;
                var deliveries = dashboardState.deliveries;
                var waitingOrders = orders.filter(function (order) {
                    return order.status === "PLACED";
                }).length;
                var acceptedOrders = orders.filter(function (order) {
                    return order.status === "ACCEPTED";
                }).length;
                var pendingPayments = payments.filter(function (payment) {
                    return payment.status === "PENDING";
                }).length;
                var inProgressDeliveries = deliveries.filter(function (delivery) {
                    return delivery.status !== "DELIVERED" && delivery.status !== "FAILED";
                }).length;
                var pricedProducts = products.filter(function (product) {
                    return Number(product.unitPrice || 0) > 0;
                }).length;
                var catalogHealth = products.length ? Math.round((pricedProducts / products.length) * 100) : 0;

                var attentionItems = [];

                if (waitingOrders > 0) {
                    attentionItems.push(buildAttentionItem(
                        "Order review queue",
                        waitingOrders + " orders are waiting for distributor review.",
                        "/web/distributor/orders",
                        "Review",
                        "is-urgent"
                    ));
                }

                if (acceptedOrders > 0) {
                    attentionItems.push(buildAttentionItem(
                        "Dispatch planning",
                        acceptedOrders + " accepted orders need delivery coordination.",
                        "/web/distributor/delivery",
                        "Plan",
                        ""
                    ));
                }

                if (pendingPayments > 0) {
                    attentionItems.push(buildAttentionItem(
                        "Payment follow-up",
                        pendingPayments + " settlements are still pending.",
                        "/web/distributor/dues",
                        "Collect",
                        ""
                    ));
                }

                if (catalogHealth < 100 && products.length > 0) {
                    attentionItems.push(buildAttentionItem(
                        "Catalog cleanup",
                        catalogHealth + "% of items have a valid price.",
                        "/web/distributor/products",
                        "Update",
                        ""
                    ));
                } else if (products.length === 0) {
                    attentionItems.push(buildAttentionItem(
                        "Catalog setup",
                        "Add products so retailers can start placing orders.",
                        "/web/distributor/add-product",
                        "Add",
                        "is-urgent"
                    ));
                }

                if (inProgressDeliveries > 0) {
                    attentionItems.push(buildAttentionItem(
                        "Delivery tracking",
                        inProgressDeliveries + " delivery records are still active.",
                        "/web/distributor/delivery",
                        "Track",
                        ""
                    ));
                }

                if (attentionItems.length === 0) {
                    attentionItems.push(buildAttentionItem(
                        "All caught up",
                        "No urgent operational issues found in the current dashboard data.",
                        "/web/distributor/reports",
                        "Review",
                        ""
                    ));
                }

                attentionList.innerHTML = attentionItems.slice(0, 6).map(function(html) {
                    // Convert the item into the row format used on the homepage
                    var temp = document.createElement('div');
                    temp.innerHTML = html;
                    var item = temp.firstChild;
                    var title = item.querySelector('strong').textContent;
                    var span = item.querySelector('span').textContent;
                    var pillClass = item.classList.contains('is-urgent') ? 'status status-danger' : 'status wm-home-pill';
                    return '<div class="wm-home-ops-row"><div><strong>' + title + '</strong><span>' + span + '</span></div><span class="' + pillClass + '">Priority</span></div>';
                }).join("");
            }

            function renderPerformanceBrief(orders) {
                if (!performanceBrief) {
                    return;
                }

                var today = daysAgo(0);
                var tomorrow = daysAgo(-1);
                var yesterday = daysAgo(1);
                var last7 = daysAgo(7);
                var previous7 = daysAgo(14);
                var monthStart = new Date(today.getFullYear(), today.getMonth(), 1);
                var nextMonthStart = new Date(today.getFullYear(), today.getMonth() + 1, 1);
                var previousMonthStart = new Date(today.getFullYear(), today.getMonth() - 1, 1);

                var todayRevenue = sumOrders(orders, today, tomorrow);
                var yesterdayRevenue = sumOrders(orders, yesterday, today);
                var weekRevenue = sumOrders(orders, last7, tomorrow);
                var previousWeekRevenue = sumOrders(orders, previous7, last7);
                var monthRevenue = sumOrders(orders, monthStart, nextMonthStart);
                var previousMonthRevenue = sumOrders(orders, previousMonthStart, monthStart);
                var todayOrders = countOrders(orders, today, tomorrow);
                var last7Orders = countOrders(orders, last7, tomorrow);
                var dailyAverage = last7Orders / 7;

                performanceBrief.textContent = "Today: " + money(todayRevenue) + " (" + percentChange(todayRevenue, yesterdayRevenue) + " vs yesterday). " + 
                    "Weekly volume: " + money(weekRevenue) + ". Total orders today: " + todayOrders + ".";
            }

            wmFetch("/api/v1/orders")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (orders) {
                    orders = normalizeRows(orders);
                    dashboardState.orders = orders;

                    setText("ordersWaiting", orders.filter(function (order) {
                        return order.status === "PLACED";
                    }).length);

                    setText("ordersReady", orders.filter(function (order) {
                        return order.status === "ACCEPTED";
                    }).length);

                    setText("ordersCompleted", orders.filter(function (order) {
                        return order.status === "DELIVERED";
                    }).length);

                    setText("reportTotalOrders", orders.length);

                    setText("reportPendingOrders", orders.filter(function (order) {
                        return order.status === "PLACED";
                    }).length);

                    setText("reportActiveOrders", orders.filter(function (order) {
                        return order.status !== "DELIVERED"
                            && order.status !== "CANCELLED"
                            && order.status !== "REJECTED";
                    }).length);

                    setText("capturedRevenue", money(orders.reduce(function (total, order) {
                        return total + Number(order.totalAmount || 0);
                    }, 0)));

                    renderPerformanceBrief(orders);
                    renderRecommendedActions();
                })
                .catch(function () {
                    if (performanceTicker) {
                        performanceBrief.textContent = "Unable to load performance insights.";
                    }
                    console.warn("Unable to load orders dashboard data.");
                });

            wmFetch("/api/v1/products/mine")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (products) {
                    products = normalizeRows(products);
                    dashboardState.products = products;

                    var categories = new Set(products.map(function (product) {
                        return product.category;
                    })).size;

                    setText("totalItems", products.length);
                    setText("reportTotalItems", products.length);
                    setText("categoryCount", categories);
                    setText("reportCategoryCount", categories);
                    setText("stockPlanningCount", categories);
                    renderRecommendedActions();
                })
                .catch(function () {
                    console.warn("Unable to load product dashboard data.");
                });

            wmFetch("/api/v1/payments")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (payments) {
                    payments = normalizeRows(payments);
                    dashboardState.payments = payments;

                    setText("pendingSettlements", payments.filter(function (payment) {
                        return payment.status === "PENDING";
                    }).length);
                    renderRecommendedActions();
                })
                .catch(function () {
                    console.warn("Unable to load payment dashboard data.");
                });

            wmFetch("/api/v1/deliveries")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (deliveries) {
                    deliveries = normalizeRows(deliveries);
                    dashboardState.deliveries = deliveries;

                    setText("completedDropoffs", deliveries.filter(function (delivery) {
                        return delivery.status === "DELIVERED";
                    }).length);
                    renderRecommendedActions();
                })
                .catch(function () {
                    console.warn("Unable to load delivery dashboard data.");
                });

            window.askAi = function askAi() {
                var message = input.value.trim();

                if (!message) {
                    responseBox.textContent = "Type a question for AI first.";
                    return;
                }

                responseBox.textContent = "Thinking...";

                if (actionBox) {
                    actionBox.innerHTML = "";
                }

                wmFetch("/api/v1/ai/agent/chat", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        message: message
                    })
                })
                    .then(function (apiResponse) {
                        if (!apiResponse.ok) {
                            throw new Error("AI service error");
                        }
                        return apiResponse.json();
                    })
                    .then(function (data) {
                        responseBox.textContent = data && data.answer
                            ? data.answer
                            : "No response received.";
                        Lucide.createIcons(); // Re-render Lucide icons if new content is added
                        if (data && data.requiresConfirmation) {
                            showAiConfirmation(data.actionId, data.actionType);
                        }
                    })
                    .catch(function () {
                        responseBox.textContent = "Unable to reach AI right now. Try opening the full chat.";
                    });
            }; // End window.askAi

            window.showAiConfirmation = function showAiConfirmation(actionId, actionType) {
                if (!actionBox) {
                    return;
                }

                actionBox.innerHTML = '<div class="alert alert-warning mt-2">'
                    + 'AI wants to perform action: <b>' + actionType + '</b><br/>'
                    + '<button class="btn btn-success btn-sm mt-2" type="button" onclick="confirmAiAction(' + actionId + ', true)">Confirm</button> '
                    + '<button class="btn btn-secondary btn-sm mt-2" type="button" onclick="confirmAiAction(' + actionId + ', false)">Cancel</button>'
                    + '</div>';
            };

            window.confirmAiAction = function confirmAiAction(actionId, confirm) {
                wmFetch("/api/v1/ai/actions/confirm", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        actionId: actionId,
                        confirm: confirm
                    })
                })
                    .then(function (apiResponse) {
                        if (!apiResponse.ok) {
                            throw new Error("AI action error");
                        }
                        return apiResponse.json();
                    })
                    .then(function (data) {
                        responseBox.textContent = data.message || "Action updated.";

                        if (actionBox) {
                            actionBox.innerHTML = "";
                        }
                    })
                    .catch(function () {
                        responseBox.textContent = "Unable to update the AI action.";
                    });
            };

            form.addEventListener("submit", function (event) {
                event.preventDefault();
                window.askAi();
            });

            if (voiceButton && recognition) {
                voiceButton.addEventListener("click", function () {
                    if (voiceButton.classList.contains("is-listening")) {
                        recognition.stop();
                        return;
                    }
                    try {
                        recognition.start();
                    } catch (error) {
                        responseBox.textContent = "Voice input is already starting.";
                    }
                });
            }

            if (quickButtons) {
                quickButtons.addEventListener("click", function (event) {
                    var button = event.target.closest("[data-ai-message]");

                    if (!button) {
                        return;
                    }

                    input.value = button.getAttribute("data-ai-message");
                    window.askAi();
                });
            }

            // Initialize Lucide icons on page load
            if (typeof Lucide !== 'undefined') {
                Lucide.createIcons();
            }
        });
