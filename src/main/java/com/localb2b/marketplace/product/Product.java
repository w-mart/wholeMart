package com.localb2b.marketplace.product;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "products")
public class Product extends BaseEntity {
    @Column(nullable = false)
    private Long distributorUserId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String category;

    @Column(nullable = false, precision = 12, scale = 2)
    private BigDecimal unitPrice;

    private String sku;
    private String brand;
    private String description;
    private String subCategory;
    private String hsnCode;
    private BigDecimal gstRate = BigDecimal.ZERO;
    private BigDecimal mrp;
    private BigDecimal wholesalePrice;
    private String unitOfMeasure;
    private String packSize;
    private Integer minOrderQuantity;
    private Integer maxOrderQuantity;
    private Integer stockQuantity;
    private Integer reorderLevel;
    private String batchNumber;
    private LocalDate manufactureDate;
    private LocalDate expiryDate;
    private Integer shelfLifeDays;
    private String storageType;
    private String originCountry;
    private String originState;
    private String originCity;
    private String barcode;
    private String imageUrl;
    private String videoUrl;
    private String tags;
    private String ingredients;
    private String allergenInfo;
    private String certifications;
    private Boolean returnable;
    private Boolean codAvailable;
    private String deliveryWindow;
    private BigDecimal weightKg;
    private BigDecimal lengthCm;
    private BigDecimal widthCm;
    private BigDecimal heightCm;
    private Boolean fragile;
    private Boolean coldChainRequired;
    private String aiKeywords;
    private String demandForecastNote;
    private Boolean smartReorderEnabled;
    private BigDecimal carbonScore;
    private String sustainabilityNote;
    @Column(columnDefinition = "text")
    private String productMetadataJson;

    protected Product() {
    }

    public Product(Long distributorUserId, String name, String category, BigDecimal unitPrice) {
        this.distributorUserId = distributorUserId;
        this.name = name;
        this.category = category;
        this.unitPrice = unitPrice;
    }

    public void updateDetails(ProductDetails details) {
        this.sku = details.sku();
        this.brand = details.brand();
        this.description = details.description();
        this.subCategory = details.subCategory();
        this.hsnCode = details.hsnCode();
        this.gstRate = details.gstRate() == null ? BigDecimal.ZERO : details.gstRate();
        this.mrp = details.mrp();
        this.wholesalePrice = details.wholesalePrice();
        this.unitOfMeasure = details.unitOfMeasure();
        this.packSize = details.packSize();
        this.minOrderQuantity = details.minOrderQuantity();
        this.maxOrderQuantity = details.maxOrderQuantity();
        this.stockQuantity = details.stockQuantity();
        this.reorderLevel = details.reorderLevel();
        this.batchNumber = details.batchNumber();
        this.manufactureDate = details.manufactureDate();
        this.expiryDate = details.expiryDate();
        this.shelfLifeDays = details.shelfLifeDays();
        this.storageType = details.storageType();
        this.originCountry = details.originCountry();
        this.originState = details.originState();
        this.originCity = details.originCity();
        this.barcode = details.barcode();
        this.imageUrl = details.imageUrl();
        this.videoUrl = details.videoUrl();
        this.tags = details.tags();
        this.ingredients = details.ingredients();
        this.allergenInfo = details.allergenInfo();
        this.certifications = details.certifications();
        this.returnable = details.returnable();
        this.codAvailable = details.codAvailable();
        this.deliveryWindow = details.deliveryWindow();
        this.weightKg = details.weightKg();
        this.lengthCm = details.lengthCm();
        this.widthCm = details.widthCm();
        this.heightCm = details.heightCm();
        this.fragile = details.fragile();
        this.coldChainRequired = details.coldChainRequired();
        this.aiKeywords = details.aiKeywords();
        this.demandForecastNote = details.demandForecastNote();
        this.smartReorderEnabled = details.smartReorderEnabled();
        this.carbonScore = details.carbonScore();
        this.sustainabilityNote = details.sustainabilityNote();
        this.productMetadataJson = details.productMetadataJson();
    }

    public Long getDistributorUserId() {
        return distributorUserId;
    }

    public String getName() {
        return name;
    }

    public String getCategory() {
        return category;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public String getSku() { return sku; }
    public String getBrand() { return brand; }
    public String getDescription() { return description; }
    public String getSubCategory() { return subCategory; }
    public String getHsnCode() { return hsnCode; }
    public BigDecimal getGstRate() { return gstRate; }
    public BigDecimal getMrp() { return mrp; }
    public BigDecimal getWholesalePrice() { return wholesalePrice; }
    public String getUnitOfMeasure() { return unitOfMeasure; }
    public String getPackSize() { return packSize; }
    public Integer getMinOrderQuantity() { return minOrderQuantity; }
    public Integer getMaxOrderQuantity() { return maxOrderQuantity; }
    public Integer getStockQuantity() { return stockQuantity; }
    public Integer getReorderLevel() { return reorderLevel; }
    public String getBatchNumber() { return batchNumber; }
    public LocalDate getManufactureDate() { return manufactureDate; }
    public LocalDate getExpiryDate() { return expiryDate; }
    public Integer getShelfLifeDays() { return shelfLifeDays; }
    public String getStorageType() { return storageType; }
    public String getOriginCountry() { return originCountry; }
    public String getOriginState() { return originState; }
    public String getOriginCity() { return originCity; }
    public String getBarcode() { return barcode; }
    public String getImageUrl() { return imageUrl; }
    public String getVideoUrl() { return videoUrl; }
    public String getTags() { return tags; }
    public String getIngredients() { return ingredients; }
    public String getAllergenInfo() { return allergenInfo; }
    public String getCertifications() { return certifications; }
    public Boolean getReturnable() { return returnable; }
    public Boolean getCodAvailable() { return codAvailable; }
    public String getDeliveryWindow() { return deliveryWindow; }
    public BigDecimal getWeightKg() { return weightKg; }
    public BigDecimal getLengthCm() { return lengthCm; }
    public BigDecimal getWidthCm() { return widthCm; }
    public BigDecimal getHeightCm() { return heightCm; }
    public Boolean getFragile() { return fragile; }
    public Boolean getColdChainRequired() { return coldChainRequired; }
    public String getAiKeywords() { return aiKeywords; }
    public String getDemandForecastNote() { return demandForecastNote; }
    public Boolean getSmartReorderEnabled() { return smartReorderEnabled; }
    public BigDecimal getCarbonScore() { return carbonScore; }
    public String getSustainabilityNote() { return sustainabilityNote; }
    public String getProductMetadataJson() { return productMetadataJson; }

    public record ProductDetails(
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
    }
}
