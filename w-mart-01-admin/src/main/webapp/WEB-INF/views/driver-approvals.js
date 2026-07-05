/* Page-specific scripts for admin\driver-approvals.jsp */

document.addEventListener("DOMContentLoaded", () => {
            const driversBody = document.getElementById("driversBody");
            const driverSearch = document.getElementById("driverSearch");
            const statusFilter = document.getElementById("statusFilter");

            let allDrivers = [];

            const setText = (id, value) => {
                const element = document.getElementById(id);
                if (element) {
                    element.textContent = value;
                }
            };

            const renderTable = () => {
                const query = (driverSearch.value || "").toLowerCase();
                const status = statusFilter.value;

                const filteredDrivers = allDrivers.filter(driver => {
                    const driverInfo = [driver.name, driver.mobile, driver.status].join(" ").toLowerCase();
                    const matchesQuery = !query || driverInfo.includes(query);
                    const matchesStatus = !status || driver.status === status;
                    return matchesQuery && matchesStatus;
                });

                if (filteredDrivers.length === 0) {
                    driversBody.innerHTML = `<tr><td colspan="5">No driver accounts found matching your criteria.</td></tr>`;
                } else {
                    driversBody.innerHTML = filteredDrivers.map((driver, index) => `
                        <tr>
                            <td>${index + 1}</td>
                            <td>${driver.name}</td>
                            <td>${driver.mobile}</td>
                            <td>${driver.status}</td>
                            <td>${driver.createdAt ? new Date(driver.createdAt).toLocaleDateString() : "-"}</td>
                        </tr>
                    `).join("");
                }
            };

            const updateStats = () => {
                setText("totalDrivers", allDrivers.length);
                setText("pendingDrivers", allDrivers.filter(driver => driver.status === "PENDING_APPROVAL").length);
                setText("activeDrivers", allDrivers.filter(driver => driver.status === "ACTIVE").length);
            };

            const fetchData = () => {
                fetch("/api/v1/users/drivers")
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        allDrivers = wmRows(data); // Assuming wmRows is a global function
                        renderTable();
                        updateStats();
                    })
                    .catch(error => {
                        console.error("Error fetching drivers:", error);
                        driversBody.innerHTML = `<tr><td colspan="5">Unable to load drivers from the database.</td></tr>`;
                    });
            };

            driverSearch.addEventListener("input", renderTable);
            statusFilter.addEventListener("change", renderTable);

            fetchData();
        });
