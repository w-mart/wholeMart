<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Distributor Dashboard</title>

    <style>
        .wm-ai-marquee {
            width: 100%;
            overflow: hidden;
            margin: 14px 0;
            position: relative;
            border-radius: 14px;
        }

        .wm-ai-marquee-track {
            display: flex;
            gap: 10px;
            width: max-content;
            animation: wmAiMarquee 24s linear infinite;
        }

        .wm-ai-marquee:hover .wm-ai-marquee-track {
            animation-play-state: paused;
        }

        .wm-ai-marquee-track .btn {
            white-space: nowrap;
            flex: 0 0 auto;
        }

        .wm-performance-marquee {
            overflow: hidden;
            margin: 16px 0 12px;
            border: 1px solid rgba(13, 105, 82, .16);
            border-radius: 8px;
            background: #f7fbf8;
        }

        .wm-performance-track {
            display: flex;
            gap: 12px;
            width: max-content;
            padding: 10px 12px;
            animation: wmPerformanceMarquee 28s linear infinite;
        }

        .wm-performance-marquee:hover .wm-performance-track {
            animation-play-state: paused;
        }

        .wm-performance-chip {
            flex: 0 0 auto;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-height: 34px;
            padding: 6px 12px;
            border: 1px solid rgba(13, 105, 82, .18);
            border-radius: 999px;
            background: #fff;
            color: #173026;
            font-weight: 700;
            white-space: nowrap;
        }

        .wm-performance-chip span {
            color: #0b8066;
        }

        @keyframes wmPerformanceMarquee {
            from {
                transform: translateX(0);
            }

            to {
                transform: translateX(-50%);
            }
        }

        @keyframes wmAiMarquee {
            from {
                transform: translateX(0);
            }

            to {
                transform: translateX(-50%);
            }
        }
    </style>

    <% request.setAttribute("wmBodyClass", "wm-dashboard-scale"); %>
    <%@ include file="../common/wholemart-shell-start.jsp" %>

    <div class="wm-dashboard-overview">
        <div class="wm-dashboard-primary">
            <div class="wm-dashboard-head">
                <div>
                    <div class="wm-insight-kicker">Distributor workspace</div>
                    <h1 class="wm-title">Welcome, Guest</h1>
                    <p class="wm-subtitle">
                        Overview of orders, inventory, payments, delivery activity, and next actions.
                    </p>
                </div>
                <div class="wm-head-actions">
                    <a class="btn wm-gradient-btn" href="/web/distributor/orders">View Orders</a>
                    <a class="btn wm-btn-secondary" href="/web/distributor/products">Inventory</a>
                </div>
            </div>

            <section class="wm-performance-marquee" aria-label="Distributor performance ticker">
                <div class="wm-performance-track" id="wmPerformanceTicker">
                    <div class="wm-performance-chip">Loading performance insights...</div>
                </div>
            </section>

            <div class="wm-toolbar wm-dashboard-toolbar">
                <input class="wm-input" placeholder="Search by order ID, retailer, or product">
                <select class="wm-select">
                    <option>All Statuses</option>
                    <option>Pending</option>
                    <option>Active</option>
                    <option>Delivered</option>
                </select>
                <a class="btn wm-gradient-btn wm-search-order" href="/web/distributor/orders">Search Order</a>
            </div>
        </div>

        <div class="wm-dashboard-side">
            <section class="wm-ai-top-card">
                <div>
                    <span class="wm-insight-kicker">AI Control Center</span>
                    <h2>Ask AI for everything</h2>
                    <p>Orders, inventory, payments, delivery, reports, and daily priorities.</p>

                    <br><br><br>

                    <div class="wm-ai-quick-response" id="wmDashboardAiResponse">
                        AI response will appear here.
                    </div>

                    <!-- AI Quick Buttons Marquee Start -->
                    <div class="wm-ai-marquee">
                        <div class="wm-ai-marquee-track" id="wmDashboardAiQuickButtons">

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="What should I do first today?">
                                What should I do first today?
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show today's order summary.">
                                Show today's order summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show low stock summary.">
                                Show low stock summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show payment and dues summary.">
                                Show payment and dues summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Suggest next actions.">
                                Suggest next actions
                            </button>

                            <!-- Duplicate buttons for smooth infinite marquee -->
                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="What should I do first today?">
                                What should I do first today?
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show today's order summary.">
                                Show today's order summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show low stock summary.">
                                Show low stock summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Show payment and dues summary.">
                                Show payment and dues summary
                            </button>

                            <button class="btn wm-btn-secondary" type="button"
                                    data-ai-message="Suggest next actions.">
                                Suggest next actions
                            </button>

                        </div>
                    </div>
                    <!-- AI Quick Buttons Marquee End -->

                    <form class="wm-ai-quick-form" id="wmDashboardAiForm">
                        <input class="wm-input" id="wmDashboardAiMessage"
                               placeholder="Ask about today's priorities">
                        <button class="btn wm-ai-voice-btn" id="wmDashboardAiVoice" type="button"
                                aria-label="Start voice input" title="Start voice input">
                            <span class="wm-ai-voice-icon" aria-hidden="true"></span>
                        </button>
                        <button class="btn wm-gradient-btn" type="submit">Ask AI</button>
                    </form>

                    <div id="wmDashboardAiActionBox"></div>
                </div>
            </section>
        </div>
    </div>

    <div class="wm-insight-grid">
        <section class="wm-insight-card wm-insight-card-accent">
            <div class="wm-insight-kicker">Today</div>
            <h2>Order Pipeline</h2>
            <p>Track new demand and fulfillment work before it reaches dispatch.</p>
            <div class="wm-insight-list">
                <span><b id="ordersWaiting">0</b> orders waiting for review</span>
                <span><b id="ordersReady">0</b> accepted orders</span>
                <span><b id="ordersCompleted">0</b> completed delivery</span>
            </div>
        </section>

        <section class="wm-insight-card">
            <div class="wm-insight-kicker">Inventory</div>
            <h2>Stock Attention</h2>
            <p>Keep fast-moving products available for retailer demand.</p>
            <div class="wm-insight-list">
                <span><b id="totalItems">0</b> total items</span>
                <span><b id="categoryCount">0</b> categories</span>
                <span><b>0</b> expired items</span>
            </div>
        </section>

        <section class="wm-insight-card">
            <div class="wm-insight-kicker">Payments</div>
            <h2>Ledger Snapshot</h2>
            <p>Review collections, dues, and settlement follow-ups.</p>
            <div class="wm-insight-list">
                <span><b id="capturedRevenue">Rs. 0.00</b> captured revenue</span>
                <span><b id="pendingSettlements">0</b> pending settlements</span>
                <span><b>0</b> overdue dues</span>
            </div>
        </section>
    </div>

    <div class="wm-ops-grid">
        <section class="wm-ops-card">
            <div>
                <span class="wm-insight-kicker">Drivers</span>
                <h2>Delivery Activity</h2>
                <p>Assign drivers once accepted orders are ready for dispatch.</p>
            </div>
            <div class="wm-mini-metrics">
                <div><strong>0</strong><span>available drivers</span></div>
                <div><strong id="completedDropoffs">0</strong><span>completed drop-offs</span></div>
                <div><strong>0</strong><span>delayed routes</span></div>
            </div>
        </section>

        <section class="wm-ops-card">
            <div>
                <span class="wm-insight-kicker">AI Assist</span>
                <h2>Recommended Next Actions</h2>
                <p>Prepare reorder plans, check order queues, and follow up with retailers.</p>
            </div>
            <div class="wm-action-list">
                <a href="/web/distributor/products">Review low stock inventory</a>
                <a href="/web/distributor/orders">Check open order queue</a>
                <a href="/web/distributor/ai-chat">Ask AI for daily priorities</a>
            </div>
        </section>
    </div>

    <div class="wm-insight-grid">
        <section class="wm-report-card">
            <h2>Inventory Report</h2>
            <p><span>Total Items:</span><strong id="reportTotalItems">0</strong></p>
            <p><span>Categories:</span><strong id="reportCategoryCount">0</strong></p>
            <p><span>Expired Items:</span><strong>0</strong></p>
        </section>

        <section class="wm-report-card">
            <h2>Orders Report</h2>
            <p><span>Total Orders:</span><strong id="reportTotalOrders">0</strong></p>
            <p><span>Pending:</span><strong id="reportPendingOrders">0</strong></p>
            <p><span>Active:</span><strong id="reportActiveOrders">0</strong></p>
        </section>

        <section class="wm-report-card">
            <h2>Monthly Focus</h2>
            <p><span>Retailer Follow-ups:</span><strong>0</strong></p>
            <p><span>Dispatch Queue:</span><strong>0</strong></p>
            <p><span>Stock Planning:</span><strong id="stockPlanningCount">0</strong></p>
        </section>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var form = document.getElementById("wmDashboardAiForm");
            var input = document.getElementById("wmDashboardAiMessage");
            var voiceButton = document.getElementById("wmDashboardAiVoice");
            var responseBox = document.getElementById("wmDashboardAiResponse");
            var actionBox = document.getElementById("wmDashboardAiActionBox");
            var quickButtons = document.getElementById("wmDashboardAiQuickButtons");
            var performanceTicker = document.getElementById("wmPerformanceTicker");

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

            function renderPerformanceTicker(orders) {
                if (!performanceTicker) {
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
                var spikeText = dailyAverage && todayOrders > dailyAverage
                    ? "spike +" + (((todayOrders - dailyAverage) / dailyAverage) * 100).toFixed(1) + "%"
                    : "steady demand";

                var chips = [
                    "Today " + money(todayRevenue) + " <span>(" + percentChange(todayRevenue, yesterdayRevenue) + " vs yesterday)</span>",
                    "Last 7 days " + money(weekRevenue) + " <span>(" + percentChange(weekRevenue, previousWeekRevenue) + " vs previous week)</span>",
                    "This month " + money(monthRevenue) + " <span>(" + percentChange(monthRevenue, previousMonthRevenue) + " vs last month)</span>",
                    "Orders today " + todayOrders + " <span>(" + spikeText + ")</span>"
                ];
                var html = chips.concat(chips).map(function (chip) {
                    return "<div class=\"wm-performance-chip\">" + chip + "</div>";
                }).join("");
                performanceTicker.innerHTML = html;
            }

            fetch("/api/v1/orders")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (orders) {
                    orders = Array.isArray(orders) ? orders : [];

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

                    renderPerformanceTicker(orders);
                })
                .catch(function () {
                    if (performanceTicker) {
                        performanceTicker.innerHTML = "<div class=\"wm-performance-chip\">Unable to load performance insights.</div>";
                    }
                    console.warn("Unable to load orders dashboard data.");
                });

            fetch("/api/v1/products/mine")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (products) {
                    products = Array.isArray(products) ? products : [];

                    var categories = new Set(products.map(function (product) {
                        return product.category;
                    })).size;

                    setText("totalItems", products.length);
                    setText("reportTotalItems", products.length);
                    setText("categoryCount", categories);
                    setText("reportCategoryCount", categories);
                    setText("stockPlanningCount", categories);
                })
                .catch(function () {
                    console.warn("Unable to load product dashboard data.");
                });

            fetch("/api/v1/payments")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (payments) {
                    payments = Array.isArray(payments) ? payments : [];

                    setText("pendingSettlements", payments.filter(function (payment) {
                        return payment.status === "PENDING";
                    }).length);
                })
                .catch(function () {
                    console.warn("Unable to load payment dashboard data.");
                });

            fetch("/api/v1/deliveries")
                .then(function (apiResponse) {
                    return apiResponse.json();
                })
                .then(function (deliveries) {
                    deliveries = Array.isArray(deliveries) ? deliveries : [];

                    setText("completedDropoffs", deliveries.filter(function (delivery) {
                        return delivery.status === "DELIVERED";
                    }).length);
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

                fetch("/api/v1/ai/agent/chat", {
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

                        if (data && data.requiresConfirmation) {
                            showAiConfirmation(data.actionId, data.actionType);
                        }
                    })
                    .catch(function () {
                        responseBox.textContent = "Unable to reach AI right now. Try opening the full chat.";
                    });
            };

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
                fetch("/api/v1/ai/actions/confirm", {
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
        });
    </script>

    <%@ include file="../common/wholemart-shell-end.jsp" %>
