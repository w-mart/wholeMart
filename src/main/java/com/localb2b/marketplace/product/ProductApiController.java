package com.localb2b.marketplace.product;

import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.inventory.InventoryItem;
import com.localb2b.marketplace.inventory.InventoryRepository;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/products")
public class ProductApiController {
    private final ProductService productService;
    private final CurrentUserProvider currentUserProvider;
    private final InventoryRepository inventoryRepository;

    public ProductApiController(ProductService productService,
                                 CurrentUserProvider currentUserProvider,
                                 InventoryRepository inventoryRepository) {
        this.productService = productService;
        this.currentUserProvider = currentUserProvider;
        this.inventoryRepository = inventoryRepository;
    }


    @GetMapping
    public Page<ProductDto> search(@RequestParam(required = false) String q,
                                   @RequestParam(required = false) Long distributorUserId,
                                   @RequestParam(defaultValue = "0") int page,
                                   @RequestParam(defaultValue = "20") int size) {
        Pageable pageable = Pageables.bounded(page, size);
        Page<Product> results = productService.search(distributorUserId, q, pageable);
        return results.map(this::toDto);
    }

    @GetMapping("/by-distributor")
    public List<ProductDto> productsByDistributor(@RequestParam Long distributorUserId) {
        return productService.productsByDistributor(distributorUserId)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }


    @GetMapping("/mine")
    public List<ProductDto> mine() {
        return productService.myProducts(currentUserProvider.requireCurrentUser()).stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @GetMapping("/mine/inventory-total-amount")
    public InventoryTotalAmountDto mineInventoryTotalAmount() {
        var currentUser = currentUserProvider.requireCurrentUser();
        // Only distributors should use this endpoint.
        var total = inventoryRepository.totalInventoryValueByDistributorUserId(currentUser.userId());
        return new InventoryTotalAmountDto(total);
    }


    @PostMapping
    public ProductDto create(@Valid @RequestBody ProductCreateRequest request) {
        return toDto(productService.create(currentUserProvider.requireCurrentUser(), request));
    }

    private ProductDto toDto(Product product) {
        // Includes SKU and stock quantity so the distributor products page can render Qty/SKU.

        return new ProductDto(
                product.getId(),
                product.getDistributorUserId(),
                product.getName(),
                product.getCategory(),
                product.getUnitPrice(),
                product.getStockQuantity(),
                product.getSku(),
                product.getBrand(),
                product.getMrp());
    }



    public record InventoryTotalAmountDto(java.math.BigDecimal totalAmount) {}

    public record ProductCreateRequest(
            @NotBlank String name,
            @NotBlank String category,
            @NotNull BigDecimal unitPrice,
            String sku,
            String brand,
            String description,
            String subCategory,
            String hsnCode,
            BigDecimal gstRate,
            BigDecimal mrp,
            BigDecimal wholesalePrice,
            String unitOfMeasure,
            String packSize,
            Integer minOrderQuantity,
            Integer maxOrderQuantity,
            Integer stockQuantity,
            Integer reorderLevel,
            String batchNumber,
            LocalDate manufactureDate,
            LocalDate expiryDate,
            Integer shelfLifeDays,
            String storageType,
            String originCountry,
            String originState,
            String originCity,
            String barcode,
            String imageUrl,
            String videoUrl,
            String tags,
            String ingredients,
            String allergenInfo,
            String certifications,
            Boolean returnable,
            Boolean codAvailable,
            String deliveryWindow,
            BigDecimal weightKg,
            BigDecimal lengthCm,
            BigDecimal widthCm,
            BigDecimal heightCm,
            Boolean fragile,
            Boolean coldChainRequired,
            String aiKeywords,
            String demandForecastNote,
            Boolean smartReorderEnabled,
            BigDecimal carbonScore,
            String sustainabilityNote,
            String productMetadataJson) {
        Product.ProductDetails details() {
            return new Product.ProductDetails(
                    sku,
                    brand,
                    description,
                    subCategory,
                    hsnCode,
                    gstRate,
                    mrp,
                    wholesalePrice,
                    unitOfMeasure,
                    packSize,
                    minOrderQuantity,
                    maxOrderQuantity,
                    stockQuantity,
                    reorderLevel,
                    batchNumber,
                    manufactureDate,
                    expiryDate,
                    shelfLifeDays,
                    storageType,
                    originCountry,
                    originState,
                    originCity,
                    barcode,
                    imageUrl,
                    videoUrl,
                    tags,
                    ingredients,
                    allergenInfo,
                    certifications,
                    returnable,
                    codAvailable,
                    deliveryWindow,
                    weightKg,
                    lengthCm,
                    widthCm,
                    heightCm,
                    fragile,
                    coldChainRequired,
                    aiKeywords,
                    demandForecastNote,
                    smartReorderEnabled,
                    carbonScore,
                    sustainabilityNote,
                    productMetadataJson);
        }
    }
}
