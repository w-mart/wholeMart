package com.localb2b.marketplace.integration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.localb2b.marketplace.auth.dto.AuthDtos.AuthResponse;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class SuspensionIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void suspendBlocksRefreshToken() throws Exception {
        String retailerMobile = "777" + System.currentTimeMillis();
        String adminMobile = "666" + (System.currentTimeMillis() + 1);

        Map<String, Object> retailerLogin = Map.of(
                "mobile", retailerMobile,
                "role", "ROLE_RETAILER",
                "name", "Retailer Test");
        String retailerLoginJson = objectMapper.writeValueAsString(retailerLogin);
        String retailerResp = mockMvc.perform(post("/api/v1/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(retailerLoginJson))
                .andExpect(status().is2xxSuccessful())
                .andReturn().getResponse().getContentAsString();
        AuthResponse retailerAuth = objectMapper.readValue(retailerResp, AuthResponse.class);

        Map<String, Object> adminLogin = Map.of(
                "mobile", adminMobile,
                "role", "ROLE_ADMIN",
                "name", "Admin Test");
        String adminLoginJson = objectMapper.writeValueAsString(adminLogin);
        String adminResp = mockMvc.perform(post("/api/v1/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(adminLoginJson))
                .andExpect(status().is2xxSuccessful())
                .andReturn().getResponse().getContentAsString();
        AuthResponse adminAuth = objectMapper.readValue(adminResp, AuthResponse.class);

        mockMvc.perform(post("/api/v1/admin/users/" + retailerAuth.userId() + "/suspend")
                        .header("Authorization", "Bearer " + adminAuth.accessToken()))
                .andExpect(status().is2xxSuccessful());

        Map<String, String> refreshReq = Map.of("refreshToken", retailerAuth.refreshToken());
        String refreshJson = objectMapper.writeValueAsString(refreshReq);
        mockMvc.perform(post("/api/v1/auth/refresh-token")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(refreshJson))
                .andExpect(status().is4xxClientError());
    }
}
