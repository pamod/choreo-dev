package org.wso2.demo;

import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


import java.util.Collections;

@Configuration
public class SwaggerConfig {
    @Bean
    public GroupedOpenApi api() {
        return GroupedOpenApi.builder()
                .group("loyalty-public")
                .pathsToMatch("/loyalty/**")
                .build();
    }

    @Bean
    public OpenAPI apiInfo() {
        return new OpenAPI()
                .info(new Info().title("Loyalty Points API")
                        .description("Calculate Loyalty Points for Given User")
                        .version("v0.0.1")
                        .license(new License().name("Apache 2.0").url("http://loyalty.org")))
                .externalDocs(new ExternalDocumentation()
                        .description("Loyalty Wiki Documentation")
                        .url("https://loyalty.wiki.github.org/docs"));
    }
}
