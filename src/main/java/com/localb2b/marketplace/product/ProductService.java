package com.localb2b.marketplace.product;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.inventory.InventoryItem;
import com.localb2b.marketplace.inventory.InventoryRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final InventoryRepository inventoryRepository;

    public ProductService(ProductRepository productRepository, InventoryRepository inventoryRepository) {
        this.productRepository = productRepository;
        this.inventoryRepository = inventoryRepository;
    }

    @Transactional
    public Product create(CurrentUser currentUser, ProductApiController.ProductCreateRequest request) {
        if (currentUser.role() != UserRole.ROLE_DISTRIBUTOR) {
            throw new IllegalStateException("Only distributors can create products");
        }
        Product.ProductDetails details = request.details();
        Product product = new Product(currentUser.userId(), details.sku(), request.name(), request.category(), request.unitPrice(), details.stockQuantity(), details);
        product.updateDetails(details);
        Product saved = productRepository.save(product);
        if (request.stockQuantity() != null) {
            inventoryRepository.save(new InventoryItem(saved.getId(), Math.max(0, request.stockQuantity())));
        }
        return saved;
    }

    @Transactional(readOnly = true)
    public Page<Product> search(String query, Pageable pageable) {
        return query == null || query.isBlank()
                ? productRepository.findAll(pageable)
                : productRepository.findByNameContainingIgnoreCase(query, pageable);
    }

    @Transactional(readOnly = true)
    public Page<Product> search(Long distributorUserId, String query, Pageable pageable) {
        if (distributorUserId == null) {
            return search(query, pageable);
        }
        return query == null || query.isBlank()
                ? productRepository.findByDistributorUserId(distributorUserId, pageable)
                : productRepository.findByDistributorUserIdAndNameContainingIgnoreCase(distributorUserId, query, pageable);
    }

    @Transactional(readOnly = true)
    public List<Product> productsByDistributor(Long distributorUserId) {
        if (distributorUserId == null) {
            return List.of();
        }
        return productRepository.findByDistributorUserId(distributorUserId);
    }


    @Transactional(readOnly = true)
    public List<Product> myProducts(CurrentUser currentUser) {
        return productRepository.findByDistributorUserId(currentUser.userId());
    }
}
