/* Admin dashboard page behavior */
$(function () {
    const metrics = [
        {
            id: "userCount",
            url: "/api/v1/admin/users",
            resolve: function (data) {
                return wmRows(data).length;
            }
        },
        {
            id: "approvalCount",
            url: "/api/v1/admin/distributors",
            resolve: function (data) {
                return wmRows(data).filter(function (row) {
                    return !row.approved;
                }).length;
            }
        },
        {
            id: "orderCount",
            url: "/api/v1/admin/orders",
            resolve: function (data) {
                return wmRows(data).length;
            }
        }
    ];

    metrics.forEach(function (metric) {
        const $element = $("#" + metric.id);
        if (!$element.length) {
            return;
        }

        $.ajax({
            url: metric.url,
            method: "GET",
            dataType: "json",
            success: function (data) {
                $element.text(metric.resolve(data));
            },
            error: function () {
                $element.text("0");
            }
        });
    });
});
