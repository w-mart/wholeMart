/* Page-specific scripts for distributor\add-product.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var form = document.getElementById("productForm");
    var sections = Array.from(form.querySelectorAll(".wm-form-band"));
    var prevButton = document.getElementById("productPrev");
    var nextButton = document.getElementById("productNext");
    var saveButton = document.getElementById("productSave");
    var stepTitle = document.getElementById("productWizardStepTitle");
    var stepCount = document.getElementById("productWizardStepCount");
    var progress = document.getElementById("productWizardProgress");
    var autoFillInput = document.getElementById("autoFillKeyword");
    var autoFillButton = document.getElementById("autoFillProduct");
    var currentStep = 0;
    var numericFields = ["unitPrice", "gstRate", "mrp", "wholesalePrice", "compareAtPrice", "costPerItem", "purchaseCostPerItem", "discountPercent", "weightKg", "lengthCm", "widthCm", "heightCm", "carbonScore"];
    var integerFields = ["minOrderQuantity", "maxOrderQuantity", "stockQuantity", "purchaseQuantity", "reorderLevel", "shelfLifeDays", "leadTimeDays", "pointsEarnedPerPurchase", "bonusPoints", "pointsExpiryDays", "minimumRedemptionPoints"];
    var booleanFields = ["returnable", "codAvailable", "fragile", "coldChainRequired", "smartReorderEnabled", "dynamicPricingEnabled", "trackInventory", "allowBackorders", "showSustainabilityBadge", "freeShipping", "requiresRefrigeration", "enableArButton", "displayPointsBadge", "featuredProduct", "taxable", "giftCardEligible", "enableCustomerReviews"];

    function value(name) {
        var field = form.elements[name];
        return field ? field.value.trim() : "";
    }

    function numberValue(name) {
        var raw = value(name);
        return raw === "" ? null : Number(raw);
    }

    function integerValue(name) {
        var raw = value(name);
        return raw === "" ? null : parseInt(raw, 10);
    }

    function booleanValue(name) {
        var raw = value(name);
        return raw === "" ? null : raw === "true";
    }

    function setValue(name, nextValue) {
        var field = form.elements[name];
        if (!field || nextValue === null || nextValue === undefined || field.value) {
            return;
        }
        field.value = nextValue;
    }

    function productPreset(keyword) {
        var text = keyword.toLowerCase();
        if (text.indexOf("headphone") !== -1 || text.indexOf("earbud") !== -1 || text.indexOf("speaker") !== -1) {
            return {
                category: "Electronics",
                subCategory: "Audio Equipment",
                productType: "Physical",
                unitOfMeasure: "piece",
                gstRate: "18",
                hsnCode: "8518",
                storageType: "Dry",
                returnable: "true",
                codAvailable: "true",
                fragile: "true",
                coldChainRequired: "false",
                taxClass: "GST 18%",
                warrantyPeriod: "12 months",
                ageRestriction: "None",
                shippingClass: "Standard",
                deliveryWindow: "2-5 business days",
                seoKeywords: "audio, headphones, electronics, wireless",
                aiKeywords: "high margin, gift item, electronics, fast moving",
                certifications: "BIS, RoHS",
                material: "ABS plastic, electronics",
                styleFinish: "Matte"
            };
        }
        if (text.indexOf("rice") !== -1 || text.indexOf("atta") !== -1 || text.indexOf("dal") !== -1 || text.indexOf("oil") !== -1) {
            return {
                category: "Grocery",
                subCategory: "Staples",
                productType: "Physical",
                unitOfMeasure: "kg",
                packSize: text.indexOf("oil") !== -1 ? "1 litre" : "25 kg bag",
                gstRate: text.indexOf("rice") !== -1 ? "5" : "5",
                hsnCode: text.indexOf("rice") !== -1 ? "1006" : "",
                storageType: "Dry",
                returnable: "false",
                codAvailable: "true",
                fragile: "false",
                coldChainRequired: "false",
                taxClass: "GST 5%",
                shelfLifeDays: "180",
                originCountry: "India",
                certifications: "FSSAI",
                seoKeywords: "grocery, staples, wholesale, kirana",
                aiKeywords: "fast moving, reorder weekly, bulk demand",
                deliveryWindow: "Same day or next day"
            };
        }
        if (text.indexOf("milk") !== -1 || text.indexOf("curd") !== -1 || text.indexOf("paneer") !== -1 || text.indexOf("ice cream") !== -1) {
            return {
                category: "Dairy",
                subCategory: "Chilled Foods",
                productType: "Physical",
                unitOfMeasure: "piece",
                gstRate: "5",
                storageType: "Chilled",
                returnable: "false",
                codAvailable: "true",
                fragile: "false",
                coldChainRequired: "true",
                requiresRefrigeration: "true",
                taxClass: "GST 5%",
                shelfLifeDays: "7",
                certifications: "FSSAI",
                shippingClass: "Cold chain",
                deliveryWindow: "Same day",
                aiKeywords: "perishable, cold chain, daily demand"
            };
        }
        return {
            category: "General Merchandise",
            subCategory: "Assorted",
            productType: "Physical",
            unitOfMeasure: "piece",
            gstRate: "18",
            taxClass: "GST 18%",
            storageType: "Dry",
            codAvailable: "true",
            returnable: "true",
            fragile: "false",
            coldChainRequired: "false",
            deliveryWindow: "2-5 business days",
            aiKeywords: "catalog item, wholesale, standard demand"
        };
    }

    function autoFillProductDetails() {
        var keyword = autoFillInput.value.trim() || value("name") || value("barcode") || value("sku");
        if (!keyword) {
            autoFillInput.focus();
            alert("Enter a product keyword, name, SKU, or barcode first.");
            return;
        }
        var preset = productPreset(keyword);
        setValue("name", keyword);
        setValue("sku", "WM-" + keyword.toUpperCase().replace(/[^A-Z0-9]+/g, "-").replace(/^-|-$/g, "").slice(0, 18));
        setValue("shortTagline", "One-liner for " + keyword);
        setValue("description", "Detailed product description for " + keyword + ". Review and edit before publishing.");
        setValue("brand", "WholeMart Partner");
        setValue("manufacturer", "Registered manufacturer");
        setValue("category", preset.category);
        setValue("subCategory", preset.subCategory);
        setValue("unitPrice", "0.00");
        setValue("mrp", "0.00");
        setValue("wholesalePrice", "0.00");
        setValue("gstRate", preset.gstRate);
        setValue("hsnCode", preset.hsnCode);
        setValue("taxClass", preset.taxClass);
        setValue("unitOfMeasure", preset.unitOfMeasure);
        setValue("packSize", preset.packSize);
        setValue("stockQuantity", "100");
        setValue("reorderLevel", "20");
        setValue("minOrderQuantity", "1");
        setValue("storageType", preset.storageType);
        setValue("returnable", preset.returnable);
        setValue("codAvailable", preset.codAvailable);
        setValue("fragile", preset.fragile);
        setValue("coldChainRequired", preset.coldChainRequired);
        setValue("requiresRefrigeration", preset.requiresRefrigeration);
        setValue("originCountry", preset.originCountry || "India");
        setValue("certifications", preset.certifications);
        setValue("shippingClass", preset.shippingClass || "Standard");
        setValue("deliveryWindow", preset.deliveryWindow);
        setValue("warrantyPeriod", preset.warrantyPeriod);
        setValue("ageRestriction", preset.ageRestriction || "None");
        setValue("seoTitle", keyword + " wholesale");
        setValue("metaDescription", "Buy " + keyword + " from verified WholeMart distributors.");
        setValue("urlSlug", keyword.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, ""));
        setValue("seoKeywords", preset.seoKeywords);
        setValue("aiKeywords", preset.aiKeywords);
        setValue("material", preset.material);
        setValue("styleFinish", preset.styleFinish);
        setValue("status", "Draft");
        alert("Auto-filled likely product details. Please review prices, stock, GST/HSN, and compliance fields.");
    }

    function buildPayload() {
        var payload = {};
        Array.from(form.elements).forEach(function (field) {
            if (!field.name || field.type === "submit") {
                return;
            }
            if (numericFields.indexOf(field.name) !== -1) {
                payload[field.name] = numberValue(field.name);
            } else if (integerFields.indexOf(field.name) !== -1) {
                payload[field.name] = integerValue(field.name);
            } else if (booleanFields.indexOf(field.name) !== -1) {
                payload[field.name] = booleanValue(field.name);
            } else {
                payload[field.name] = value(field.name) || null;
            }
        });
        payload.productMetadataJson = JSON.stringify(payload);
        return payload;
    }

    function currentSectionIsValid() {
        var fields = Array.from(sections[currentStep].querySelectorAll("input, select, textarea"));
        for (var index = 0; index < fields.length; index += 1) {
            if (!fields[index].checkValidity()) {
                fields[index].reportValidity();
                return false;
            }
        }
        return true;
    }

    function showStep(nextStep) {
        currentStep = Math.max(0, Math.min(nextStep, sections.length - 1));
        sections.forEach(function (section, index) {
            section.classList.toggle("is-active", index === currentStep);
            section.hidden = index !== currentStep;
        });
        var title = sections[currentStep].querySelector("h2").textContent;
        stepTitle.textContent = title;
        stepCount.textContent = "Step " + (currentStep + 1) + " of " + sections.length;
        progress.style.width = (((currentStep + 1) / sections.length) * 100) + "%";
        prevButton.disabled = currentStep === 0;
        nextButton.hidden = currentStep === sections.length - 1;
        saveButton.hidden = currentStep !== sections.length - 1;
        sections[currentStep].scrollIntoView({block: "start", behavior: "smooth"});
    }

    prevButton.addEventListener("click", function () {
        showStep(currentStep - 1);
    });

    nextButton.addEventListener("click", function () {
        if (currentSectionIsValid()) {
            showStep(currentStep + 1);
        }
    });

    autoFillButton.addEventListener("click", autoFillProductDetails);

    form.addEventListener("submit", function (event) {
        event.preventDefault();
        if (!currentSectionIsValid()) {
            return;
        }
        wmFetch("/api/v1/products", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(buildPayload())
        }).then(function (response) {
            if (response.ok) {
                location.href = "/web/distributor/products";
                return null;
            }
            return response.text().then(function (text) {
                alert("Unable to save product: " + text);
            });
        }).catch(function () {
            alert("Unable to save product. Please try again.");
        });
    });

    showStep(0);
});
