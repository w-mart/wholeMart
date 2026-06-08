package com.localb2b.marketplace.security;

import com.localb2b.marketplace.user.UserAccount;
import com.localb2b.marketplace.user.UserRole;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class JwtService {
    private final ObjectMapper objectMapper;
    private final String secret;
    private final long accessMinutes;
    private final long refreshDays;

    public JwtService(ObjectMapper objectMapper,
                      @Value("${localb2b.auth.jwt-secret}") String secret,
                      @Value("${localb2b.auth.access-token-minutes}") long accessMinutes,
                      @Value("${localb2b.auth.refresh-token-days}") long refreshDays) {
        this.objectMapper = objectMapper;
        this.secret = secret;
        this.accessMinutes = accessMinutes;
        this.refreshDays = refreshDays;
    }

    public String createAccessToken(UserAccount user) {
        return createToken(user, Instant.now().plusSeconds(accessMinutes * 60));
    }

    public String createRefreshToken(UserAccount user) {
        return createToken(user, Instant.now().plusSeconds(refreshDays * 24 * 60 * 60));
    }

    public MarketplacePrincipal parse(String token) {
        try {
            String[] parts = token.split("\\.");
            if (parts.length != 3 || !signature(parts[0], parts[1]).equals(parts[2])) {
                throw new IllegalArgumentException("Invalid token signature");
            }
            Map<?, ?> claims = objectMapper.readValue(base64Decode(parts[1]), Map.class);
            long exp = ((Number) claims.get("exp")).longValue();
            if (Instant.now().getEpochSecond() > exp) {
                throw new IllegalArgumentException("Token expired");
            }
            Long userId = ((Number) claims.get("sub")).longValue();
            UserRole role = UserRole.valueOf(claims.get("role").toString());
            String mobile = claims.get("mobile").toString();
            return new MarketplacePrincipal(userId, role, mobile);
        } catch (Exception ex) {
            throw new IllegalArgumentException("Invalid token", ex);
        }
    }

    private String createToken(UserAccount user, Instant expiresAt) {
        try {
            Map<String, Object> header = Map.of("alg", "HS256", "typ", "JWT");
            Map<String, Object> claims = new LinkedHashMap<>();
            claims.put("sub", user.getId());
            claims.put("role", user.getRole().name());
            claims.put("mobile", user.getMobile());
            claims.put("exp", expiresAt.getEpochSecond());
            String encodedHeader = base64Encode(objectMapper.writeValueAsBytes(header));
            String encodedClaims = base64Encode(objectMapper.writeValueAsBytes(claims));
            return encodedHeader + "." + encodedClaims + "." + signature(encodedHeader, encodedClaims);
        } catch (Exception ex) {
            throw new IllegalStateException("Unable to create token", ex);
        }
    }

    private String signature(String header, String claims) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
        return base64Encode(mac.doFinal((header + "." + claims).getBytes(StandardCharsets.UTF_8)));
    }

    private String base64Encode(byte[] bytes) {
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private byte[] base64Decode(String value) {
        return Base64.getUrlDecoder().decode(value);
    }
}
