package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.product.Product;
import com.localb2b.marketplace.product.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class ProductTool implements AiTool {

    private final ProductService productService;
    private final AiSecurityValidator securityValidator;

    public ProductTool(ProductService productService, AiSecurityValidator securityValidator) {
        this.productService = productService;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "product";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.PRODUCTS || intent == Intent.CREATE;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);

            String query = (String) request.params().getOrDefault("query", "");
            int size = ((Number) request.params().getOrDefault("size", 20)).intValue();
            var pageable = PageRequest.of(0, Math.max(1, Math.min(size, 50)));

            // If distributor, scope to their catalog; if retailer/admin, allow broader search.
            Page<Product> page;
            if (user.role() == com.localb2b.marketplace.user.UserRole.ROLE_DISTRIBUTOR) {
                page = productService.search(user.userId(), query, pageable);
            } else {
                page = productService.search(query, pageable);
            }

            List<Product> products = page.getContent();

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched products",
                    Map.of("products", products, "total", page.getTotalElements())
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

