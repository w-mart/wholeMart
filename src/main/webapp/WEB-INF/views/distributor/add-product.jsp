<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Add Product | WholeMart</title>

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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/add-product.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    </head>

    <body class="wm-body">

        <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

            <main class="wm-page">
                <div class="wm-hero">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <span class="wm-badge">
                                NEW PRODUCT
                            </span>
                            <h1>
                                Create Product
                            </h1>
                            <p>
                                Build a complete catalog record with pricing, inventory, compliance, logistics and AI powered
                                recommendations.
                            </p>
                        </div>
                        <div class="col-lg-4">
                            <div class="wm-ai-box">
                                <div class="ai-icon">
                                    <i class="bi bi-stars"></i>
                                </div>
                                <div>
                                    <h5>WholeMart AI</h5>
                                    <span>
                                        Ready to generate SKU, Category, GST, SEO & Product Description
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="wm-card">
<form id="productForm" class="wm-product-form" action="/api/v1/products" method="POST">
                        <!-- Basic Information -->
                        <section class="wm-section is-active">
                            <div class="wm-card-header">
                                <div>
                                    <small class="wm-section-tag">BASIC INFORMATION</small>
                                    <h3>Product Identity</h3>
                                    <p>Create the core information of your product.</p>
                                </div>
                                <button class="btn wm-ai-btn" type="button" id="autoFillProduct">
                                    <i class="bi bi-stars"></i>
                                    Auto Fill Using AI
                                </button>
                            </div>

                            <div class="row mt-4">
                                <div class="col-lg-4">
                                    <div class="wm-upload-card">
                                        <div class="upload-icon">
                                            <i class="bi bi-cloud-arrow-up"></i>
                                        </div>
                                        <h5>Upload Product Image</h5>
                                        <p>JPG, PNG, WEBP</p>
                                        <input type="file" class="form-control mt-3" name="imageUrl" />
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="row g-4">
                                        <div class="col-md-6">
                                            <label>Product Name</label>
                                            <input class="wm-input" name="name" required placeholder="e.g., Premium Basmati Rice" />
                                        </div>
                                        <div class="col-md-6">
                                            <label>SKU</label>
                                            <input class="wm-input" name="sku" placeholder="e.g., WM-000124" />
                                        </div>
                                        <div class="col-md-6">
                                            <label>Brand</label>
                                            <input class="wm-input" name="brand" placeholder="e.g., WholeMart" />
                                        </div>
                                        <div class="col-md-6">
                                            <label>Category</label>
                                            <select class="wm-select" name="category">
                                                <option>Grocery</option>
                                                <option>Electronics</option>
                                                <option>Fashion</option>
                                                <option>Home</option>
                                                <option>Dairy</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                     <label>Description</label>
                                     <textarea class="wm-textarea" rows="4" name="description"
                                        placeholder="Write a detailed product description..."></textarea>
                                </div>
                            </div>
                        </section>

                         <!-- Pricing & Tax -->
                        <section class="wm-section">
                            <hr class="my-5" />
                            <div class="wm-card-header">
                                 <div>
                                     <small class="wm-section-tag">PRICING</small>
                                     <h3>Pricing & Tax Configuration</h3>
                                     <p>Configure selling price, wholesale pricing and taxation.</p>
                                 </div>
                            </div>
                            <div class="row g-4 mt-3">
                                <div class="col-md-4">
                                    <label>Unit Price</label>
                                    <input type="number" class="wm-input" name="unitPrice" placeholder="0.00" />
                                </div>
                                <div class="col-md-4">
                                    <label>MRP</label>
                                    <input type="number" class="wm-input" name="mrp" placeholder="0.00" />
                                </div>
                                <div class="col-md-4">
                                     <label>GST %</label>
                                     <input class="wm-input" name="gstRate" placeholder="e.g., 18" />
                                </div>
                            </div>
                        </section>

                        <!-- Inventory -->
                        <section class="wm-section">
                            <hr class="my-5" />
                            <div class="wm-card-header">
                                 <div>
                                     <small class="wm-section-tag">INVENTORY</small>
                                     <h3>Inventory & Warehouse</h3>
                                     <p>Manage stock, warehouse and supplier details.</p>
                                 </div>
                            </div>
                             <div class="row g-4 mt-3">
                                 <div class="col-md-4">
                                     <label>Stock Quantity</label>
                                     <input class="wm-input" type="number" name="stockQuantity" placeholder="100" />
                                 </div>
                                 <div class="col-md-4">
                                     <label>Unit</label>
                                     <input class="wm-input" name="unitOfMeasure" placeholder="e.g., Piece, KG, Litre" />
                                 </div>
                                  <div class="col-md-4">
                                     <label>Warehouse Location</label>
                                     <input class="wm-input" name="warehouseLocation" placeholder="e.g., Warehouse A" />
                                 </div>
                             </div>
                        </section>


                        <div class="wm-bottom-bar">
                             <div>
                                 <h5>Save Product</h5>
                                 <span>Save this product to your catalog.</span>
                             </div>
                             <div class="wm-bottom-buttons">
                                 <button type="button" class="btn wm-btn-light">Save as Draft</button>
                    <button type="button" class="btn wm-btn-primary" id="publishProductBtn">Publish Product</button>
                             </div>
                        </div>

                    </form>
                </div>

                <script>
                    (function () {
                        const form = document.getElementById('productForm');
                        const publishBtn = document.getElementById('publishProductBtn');
                        if (!form || !publishBtn) return;


                        function toNumber(v) {
                            if (v === undefined || v === null || v === '') return null;
                            const n = Number(v);
                            return Number.isFinite(n) ? n : null;
                        }

                        function collectPayload() {
                            const data = Object.fromEntries(new FormData(form).entries());

                            // NOTE: backend expects JSON for @RequestBody ProductCreateRequest
                            return {
                                name: data.name,
                                category: data.category,
                                unitPrice: data.unitPrice !== undefined && data.unitPrice !== '' ? Number(data.unitPrice) : null,
                                stockQuantity: data.stockQuantity !== undefined && data.stockQuantity !== '' ? Number(data.stockQuantity) : 0,
                                mrp: data.mrp !== undefined && data.mrp !== '' ? Number(data.mrp) : null,
                                brand: data.brand || null,
                                details: {
                                    sku: data.sku || null,
                                    description: data.description || null,
                                    gstRate: data.gstRate !== undefined && data.gstRate !== '' ? Number(data.gstRate) : null,
                                    // map UI -> ProductCreateRequest fields used by backend
                                    unitOfMeasure: data.unitOfMeasure || null,
                                    // backend uses storageType/origin/etc. No warehouse field in request; keep as null
                                    imageUrl: data.imageUrl || null
                                }
                            };
                        }

                        publishBtn.addEventListener('click', async function (e) {
                            e.preventDefault();

                            const payload = collectPayload();

                            const res = await fetch(form.action, {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify(payload)
                            });

                            if (!res.ok) {
                                const text = await res.text().catch(() => '');
                                alert('Product creation failed: ' + res.status + (text ? '\n' + text : ''));
                                return;
                            }

                            alert('Product created successfully');
                            window.location.href = (form.action.replace('/api/v1/products', '/web/distributor/products'));
                        });

                        // prevent normal form submit (which sends x-www-form-urlencoded)
                        form.addEventListener('submit', function (e) {
                            e.preventDefault();
                        });
                    })();
                </script>
            </main>

            <%@ include file="/WEB-INF/common/footer.jsp" %>
            <style>
                @media (max-width: 720px) {
                    .wm-bottom-bar {
                        flex-direction: column;
                        align-items: stretch;
                        gap: 16px;
                        padding: 16px;
                    }
            
                    .wm-bottom-buttons {
                        flex-direction: column;
                        align-items: stretch;
                        width: 100%;
                    }
                }
            </style>
    </body>
    </html>