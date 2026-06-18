package com.example.library.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    /**
     * 提供共用的 WebClient Bean，供 GeminiApiService 呼叫 Gemini REST API。
     * baseUrl 不在此處固定，改由呼叫端組裝完整 URL，方便切換不同模型/版本。
     */
    @Bean
    public WebClient webClient() {
        return WebClient.builder()
                .codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(2 * 1024 * 1024)) // 2MB，避免大型回應被截斷
                .build();
    }
}
