<title>Add Product</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<link href="/css/add-product.css" rel="stylesheet">
<h1 class="wm-title">Add Product</h1>
<p class="wm-subtitle">Create a complete catalog, inventory, compliance, logistics, and AI-ready product record.</p>

<form id="productForm" class="wm-product-form">
    <div class="wm-product-wizard-head" aria-label="Product form progress">
        <div>
            <strong id="productWizardStepTitle">Core Identity</strong>
            <span id="productWizardStepCount">Step 1 of 15</span>
        </div>
        <div class="wm-product-progress"><span id="productWizardProgress"></span></div>
    </div>

    <section class="wm-form-band">
        <h2>Core Identity</h2>
        <div class="wm-autofill-panel">
            <label><span>Auto fill keyword / barcode</span><input class="wm-input" id="autoFillKeyword" placeholder="e.g. basmati rice, headphones, soap, barcode"></label>
            <button class="btn wm-btn-secondary" id="autoFillProduct" type="button">Auto fill details</button>
        </div>
        <div class="wm-form-grid">
            <label><span>Product Name</span><input class="wm-input" name="name" required placeholder="Premium basmati rice"></label>
            <label><span>Short Tagline</span><input class="wm-input" name="shortTagline" placeholder="One-liner for cards and listings"></label>
            <label><span>SKU</span><input class="wm-input" name="sku" placeholder="WM-RICE-001"></label>
            <label><span>Model Number</span><input class="wm-input" name="modelNumber" placeholder="MX-450-BLK"></label>
            <label><span>Brand</span><input class="wm-input" name="brand" placeholder="Brand name"></label>
            <label><span>Manufacturer</span><input class="wm-input" name="manufacturer" placeholder="Legal manufacturer name"></label>
            <label><span>Category</span><input class="wm-input" name="category" required placeholder="Grocery"></label>
            <label><span>Sub Category</span><input class="wm-input" name="subCategory" placeholder="Rice and grains"></label>
            <label><span>Barcode / QR</span><input class="wm-input" name="barcode" placeholder="EAN, UPC, QR code"></label>
        </div>
        <label class="wm-form-full"><span>Description</span><textarea class="wm-input" name="description" rows="3" placeholder="Product details, quality, usage, and selling notes"></textarea></label>
    </section>

    <section class="wm-form-band">
        <h2>Pricing</h2>
        <div class="wm-form-grid">
            <label><span>Selling Unit Price</span><input class="wm-input" name="unitPrice" type="number" step="0.01" required placeholder="0.00"></label>
            <label><span>Currency</span><select class="wm-select" name="currency"><option>INR</option><option>USD</option><option>EUR</option></select></label>
            <label><span>Compare-at Price</span><input class="wm-input" name="compareAtPrice" type="number" step="0.01" placeholder="0.00"></label>
            <label><span>Cost per Item</span><input class="wm-input" name="costPerItem" type="number" step="0.01" placeholder="0.00"></label>
            <label><span>MRP</span><input class="wm-input" name="mrp" type="number" step="0.01" placeholder="0.00"></label>
            <label><span>Wholesale Price</span><input class="wm-input" name="wholesalePrice" type="number" step="0.01" placeholder="0.00"></label>
            <label><span>Discount %</span><input class="wm-input" name="discountPercent" type="number" step="0.01" placeholder="0"></label>
            <label><span>Tax Class</span><select class="wm-select" name="taxClass"><option>GST 18%</option><option>GST 12%</option><option>GST 5%</option><option>GST 0%</option></select></label>
            <label><span>GST Rate %</span><input class="wm-input" name="gstRate" type="number" step="0.01" placeholder="5"></label>
            <label><span>HSN Code</span><input class="wm-input" name="hsnCode" placeholder="1006"></label>
            <label><span>COD Available</span><select class="wm-select" name="codAvailable"><option value="">Select</option><option value="true">Yes</option><option value="false">No</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Dynamic Pricing Rules</h2>
        <div class="wm-form-grid">
            <label><span>Condition</span><select class="wm-select" name="dynamicPricingCondition"><option>If stock below</option><option>If demand spikes</option><option>If expiry near</option><option>If competitor lower</option></select></label>
            <label><span>Target Price By</span><input class="wm-input" name="dynamicPricingTarget" placeholder="e.g. -10%, +5%, fixed price"></label>
            <label><span>Adjustment Type</span><select class="wm-select" name="dynamicPricingAdjustment"><option>Percentage</option><option>Fixed amount</option><option>AI recommended</option></select></label>
            <label><span>Enable Dynamic Pricing</span><select class="wm-select" name="dynamicPricingEnabled"><option value="false">Disabled</option><option value="true">Enabled</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Inventory</h2>
        <div class="wm-form-grid">
            <label><span>Unit of Measure</span><input class="wm-input" name="unitOfMeasure" placeholder="kg, litre, piece, carton"></label>
            <label><span>Pack Size</span><input class="wm-input" name="packSize" placeholder="25 kg bag, 12 pcs box"></label>
            <label><span>Stock Quantity</span><input class="wm-input" name="stockQuantity" type="number" step="1" placeholder="100"></label>
            <label><span>Reorder Level</span><input class="wm-input" name="reorderLevel" type="number" step="1" placeholder="20"></label>
            <label><span>Minimum Order Qty</span><input class="wm-input" name="minOrderQuantity" type="number" step="1" placeholder="1"></label>
            <label><span>Maximum Order Qty</span><input class="wm-input" name="maxOrderQuantity" type="number" step="1" placeholder="500"></label>
            <label><span>Batch Number</span><input class="wm-input" name="batchNumber" placeholder="BATCH-2026-01"></label>
            <label><span>Manufacture Date</span><input class="wm-input" name="manufactureDate" type="date"></label>
            <label><span>Expiry Date</span><input class="wm-input" name="expiryDate" type="date"></label>
            <label><span>Shelf Life Days</span><input class="wm-input" name="shelfLifeDays" type="number" step="1" placeholder="180"></label>
            <label><span>Storage Type</span><input class="wm-input" name="storageType" placeholder="Dry, chilled, frozen"></label>
            <label><span>Warehouse / Location</span><input class="wm-input" name="warehouseLocation" placeholder="Shelf B-04"></label>
            <label><span>Supplier</span><input class="wm-input" name="supplierNameOrId" placeholder="Supplier name or ID"></label>
            <label><span>Lead Time Days</span><input class="wm-input" name="leadTimeDays" type="number" step="1" placeholder="7"></label>
            <label><span>Track Inventory</span><select class="wm-select" name="trackInventory"><option value="true">Enabled</option><option value="false">Disabled</option></select></label>
            <label><span>Allow Backorders</span><select class="wm-select" name="allowBackorders"><option value="false">No</option><option value="true">Yes</option></select></label>
            <label><span>Returnable</span><select class="wm-select" name="returnable"><option value="">Select</option><option value="true">Yes</option><option value="false">No</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Dealer / Purchase Source</h2>
        <div class="wm-form-grid">
            <label><span>Dealer Name</span><input class="wm-input" name="dealerName" placeholder="Dealer or supplier business name"></label>
            <label><span>Dealer Contact Person</span><input class="wm-input" name="dealerContactPerson" placeholder="Contact person"></label>
            <label><span>Dealer Mobile</span><input class="wm-input" name="dealerMobile" placeholder="Dealer mobile number"></label>
            <label><span>Dealer Email</span><input class="wm-input" name="dealerEmail" type="email" placeholder="dealer@example.com"></label>
            <label><span>Dealer GSTIN</span><input class="wm-input" name="dealerGstin" placeholder="Dealer GSTIN"></label>
            <label><span>Dealer City</span><input class="wm-input" name="dealerCity" placeholder="City"></label>
            <label><span>Dealer State</span><input class="wm-input" name="dealerState" placeholder="State"></label>
            <label><span>Purchase Invoice No.</span><input class="wm-input" name="purchaseInvoiceNumber" placeholder="INV-2026-001"></label>
            <label><span>Purchase Date</span><input class="wm-input" name="purchaseDate" type="date"></label>
            <label><span>Purchase Cost Per Item</span><input class="wm-input" name="purchaseCostPerItem" type="number" step="0.01" placeholder="0.00"></label>
            <label><span>Purchase Quantity</span><input class="wm-input" name="purchaseQuantity" type="number" step="1" placeholder="100"></label>
            <label><span>Payment Status</span><select class="wm-select" name="dealerPaymentStatus"><option>Paid</option><option>Pending</option><option>Partial</option><option>Credit</option></select></label>
            <label class="wm-form-wide"><span>Dealer Address</span><input class="wm-input" name="dealerAddress" placeholder="Full dealer address"></label>
            <label class="wm-form-wide"><span>Purchase Notes</span><textarea class="wm-input" name="purchaseNotes" rows="2" placeholder="Warranty, credit terms, transport details, or internal purchase note"></textarea></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Sustainability and Carbon Footprint</h2>
        <div class="wm-form-grid">
            <label><span>Carbon Footprint kg CO2e</span><input class="wm-input" name="carbonScore" type="number" step="0.01" placeholder="4.2"></label>
            <label><span>Eco Label / Certification</span><select class="wm-select" name="ecoLabel"><option>None</option><option>Organic</option><option>Fair Trade</option><option>Energy Star</option><option>Recyclable</option></select></label>
            <label><span>Recyclability</span><select class="wm-select" name="recyclability"><option>Select</option><option>Fully recyclable</option><option>Partially recyclable</option><option>Not recyclable</option></select></label>
            <label><span>Packaging Type</span><select class="wm-select" name="packagingType"><option>Select</option><option>Plastic</option><option>Paper</option><option>Glass</option><option>Metal</option><option>Biodegradable</option></select></label>
            <label><span>Show Sustainability Badge</span><select class="wm-select" name="showSustainabilityBadge"><option value="true">Yes</option><option value="false">No</option></select></label>
            <label class="wm-form-wide"><span>Sustainability Note</span><input class="wm-input" name="sustainabilityNote" placeholder="Recyclable packaging, low transport impact"></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Compliance and Certifications</h2>
        <div class="wm-form-grid">
            <label><span>Origin Country</span><input class="wm-input" name="originCountry" placeholder="India"></label>
            <label><span>Origin State</span><input class="wm-input" name="originState" placeholder="Punjab"></label>
            <label><span>Origin City</span><input class="wm-input" name="originCity" placeholder="Amritsar"></label>
            <label><span>Certifications</span><input class="wm-input" name="certifications" placeholder="FSSAI, ISO, Organic"></label>
            <label><span>Warranty Period</span><input class="wm-input" name="warrantyPeriod" placeholder="12 months"></label>
            <label><span>Age Restriction</span><select class="wm-select" name="ageRestriction"><option>None</option><option>12+</option><option>18+</option></select></label>
            <label><span>Ingredients</span><input class="wm-input" name="ingredients" placeholder="Ingredients or composition"></label>
            <label><span>Allergen Info</span><input class="wm-input" name="allergenInfo" placeholder="Contains nuts, gluten free, etc."></label>
            <label class="wm-form-wide"><span>Safety Warnings</span><input class="wm-input" name="safetyWarnings" placeholder="Keep away from children"></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Media and Discovery</h2>
        <div class="wm-form-grid">
            <label><span>Image URL</span><input class="wm-input" name="imageUrl" type="url" placeholder="https://..."></label>
            <label><span>Video URL</span><input class="wm-input" name="videoUrl" type="url" placeholder="https://..."></label>
            <label><span>Product Demo Video</span><input class="wm-input" name="productDemoVideoUrl" type="url" placeholder="https://youtube.com/watch?v=..."></label>
            <label class="wm-form-wide"><span>Search Tags</span><input class="wm-input" name="tags" placeholder="rice, grocery, premium, wholesale"></label>
            <label class="wm-form-wide"><span>Media Upload Notes</span><textarea class="wm-input" name="mediaUploadNotes" rows="2" placeholder="Drag/drop upload placeholder, image requirements, asset notes"></textarea></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Logistics</h2>
        <div class="wm-form-grid">
            <label><span>Weight Kg</span><input class="wm-input" name="weightKg" type="number" step="0.001" placeholder="25"></label>
            <label><span>Length Cm</span><input class="wm-input" name="lengthCm" type="number" step="0.01" placeholder="50"></label>
            <label><span>Width Cm</span><input class="wm-input" name="widthCm" type="number" step="0.01" placeholder="35"></label>
            <label><span>Height Cm</span><input class="wm-input" name="heightCm" type="number" step="0.01" placeholder="12"></label>
            <label><span>Delivery Window</span><input class="wm-input" name="deliveryWindow" placeholder="Same day, 24-48 hours"></label>
            <label><span>Shipping Class</span><select class="wm-select" name="shippingClass"><option>Standard</option><option>Express</option><option>Heavy goods</option><option>Cold chain</option></select></label>
            <label><span>Delivery Estimate</span><input class="wm-input" name="deliveryEstimate" placeholder="3-5 business days"></label>
            <label><span>Free Shipping</span><select class="wm-select" name="freeShipping"><option value="false">No</option><option value="true">Yes</option></select></label>
            <label><span>Fragile</span><select class="wm-select" name="fragile"><option value="">Select</option><option value="true">Yes</option><option value="false">No</option></select></label>
            <label><span>Cold Chain Required</span><select class="wm-select" name="coldChainRequired"><option value="">Select</option><option value="true">Yes</option><option value="false">No</option></select></label>
            <label><span>Requires Refrigeration</span><select class="wm-select" name="requiresRefrigeration"><option value="false">No</option><option value="true">Yes</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>AR / VR and Immersive Preview</h2>
        <div class="wm-form-grid">
            <label><span>3D Model URL</span><input class="wm-input" name="arModelUrl" type="url" placeholder="https://cdn.com/model.glb"></label>
            <label><span>AR Experience URL</span><input class="wm-input" name="arExperienceUrl" type="url" placeholder="https://ar.yourstore.com/product-id"></label>
            <label><span>Virtual Try-on Type</span><select class="wm-select" name="virtualTryOnType"><option>None</option><option>Room preview</option><option>Wearable preview</option><option>Shelf preview</option></select></label>
            <label><span>360 Spin Video URL</span><input class="wm-input" name="spinVideoUrl" type="url" placeholder="https://cdn.com/spin.mp4"></label>
            <label><span>Enable AR Button</span><select class="wm-select" name="enableArButton"><option value="false">No</option><option value="true">Yes</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Variants and Attributes</h2>
        <div class="wm-form-grid">
            <label><span>Available Colors</span><input class="wm-input" name="availableColors" placeholder="Black, white, red, green"></label>
            <label><span>Available Sizes</span><input class="wm-input" name="availableSizes" placeholder="XS, S, M, L, XL"></label>
            <label><span>Material</span><input class="wm-input" name="material" placeholder="ABS plastic, aluminium"></label>
            <label><span>Style / Finish</span><input class="wm-input" name="styleFinish" placeholder="Matte, glossy, brushed metal"></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Loyalty and Reward Points</h2>
        <div class="wm-form-grid">
            <label><span>Points Earned Per Purchase</span><input class="wm-input" name="pointsEarnedPerPurchase" type="number" step="1" placeholder="50"></label>
            <label><span>Bonus Points</span><input class="wm-input" name="bonusPoints" type="number" step="1" placeholder="20"></label>
            <label><span>Points Expiry Days</span><input class="wm-input" name="pointsExpiryDays" type="number" step="1" placeholder="365"></label>
            <label><span>Eligible Tiers</span><select class="wm-select" name="eligibleTiers"><option>All tiers</option><option>Gold and above</option><option>Platinum only</option></select></label>
            <label><span>Reward Type</span><select class="wm-select" name="rewardType"><option>Store credit</option><option>Cashback</option><option>Discount coupon</option></select></label>
            <label><span>Minimum Redemption Points</span><input class="wm-input" name="minimumRedemptionPoints" type="number" step="1" placeholder="200"></label>
            <label><span>Display Points Badge</span><select class="wm-select" name="displayPointsBadge"><option value="true">Yes</option><option value="false">No</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>SEO and Discoverability</h2>
        <div class="wm-form-grid">
            <label class="wm-form-wide"><span>SEO Title</span><input class="wm-input" name="seoTitle" placeholder="Meta title, 50-60 chars"></label>
            <label class="wm-form-wide"><span>Meta Description</span><textarea class="wm-input" name="metaDescription" rows="2" placeholder="Search result description, 120-160 chars"></textarea></label>
            <label><span>URL Slug</span><input class="wm-input" name="urlSlug" placeholder="wireless-noise-cancelling-headphones"></label>
            <label><span>SEO Keywords</span><input class="wm-input" name="seoKeywords" placeholder="Comma-separated keywords"></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Visibility and Lifecycle</h2>
        <div class="wm-form-grid">
            <label><span>Status</span><select class="wm-select" name="status"><option>Draft</option><option>Published</option><option>Archived</option></select></label>
            <label><span>Publish Date</span><input class="wm-input" name="publishDate" type="datetime-local"></label>
            <label><span>Lifecycle Expiry Date</span><input class="wm-input" name="lifecycleExpiryDate" type="datetime-local"></label>
            <label><span>Target Channels</span><select class="wm-select" name="targetChannels"><option>All channels</option><option>Retailer app</option><option>Wholesale web</option><option>AI recommendations</option></select></label>
            <label><span>Featured Product</span><select class="wm-select" name="featuredProduct"><option value="false">No</option><option value="true">Yes</option></select></label>
            <label><span>Taxable</span><select class="wm-select" name="taxable"><option value="true">Yes</option><option value="false">No</option></select></label>
            <label><span>Gift Card Eligible</span><select class="wm-select" name="giftCardEligible"><option value="false">No</option><option value="true">Yes</option></select></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>Quality and Internal Notes</h2>
        <div class="wm-form-grid">
            <label><span>Internal Quality Rating</span><select class="wm-select" name="internalQualityRating"><option>5</option><option>4</option><option>3</option><option>2</option><option>1</option></select></label>
            <label><span>Enable Customer Reviews</span><select class="wm-select" name="enableCustomerReviews"><option value="true">Yes</option><option value="false">No</option></select></label>
            <label class="wm-form-wide"><span>Internal Notes</span><textarea class="wm-input" name="internalNotes" rows="3" placeholder="Private notes for your team"></textarea></label>
        </div>
    </section>

    <section class="wm-form-band">
        <h2>AI and Future Signals</h2>
        <div class="wm-form-grid">
            <label class="wm-form-wide"><span>AI Keywords</span><input class="wm-input" name="aiKeywords" placeholder="fast moving, festive, high margin, reorder weekly"></label>
            <label class="wm-form-wide"><span>Demand Forecast Note</span><input class="wm-input" name="demandForecastNote" placeholder="Expected demand spike during festivals"></label>
            <label><span>Smart Reorder</span><select class="wm-select" name="smartReorderEnabled"><option value="">Select</option><option value="true">Enabled</option><option value="false">Disabled</option></select></label>
        </div>
    </section>

    <div class="wm-form-actions">
        <a class="btn wm-btn-secondary" href="/web/distributor/products">Cancel</a>
        <button class="btn wm-btn-secondary" id="productPrev" type="button">Previous</button>
        <button class="btn wm-gradient-btn" id="productNext" type="button">Next</button>
        <button class="btn wm-gradient-btn" id="productSave" type="submit" hidden>Save Product</button>
    </div>
</form>

<script>
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
        fetch("/api/v1/products", {
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
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
