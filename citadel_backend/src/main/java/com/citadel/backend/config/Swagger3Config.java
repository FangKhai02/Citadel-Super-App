package com.citadel.backend.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import io.swagger.v3.oas.annotations.servers.Server;
import org.springframework.context.annotation.Configuration;

@OpenAPIDefinition(
        info = @Info(
                title = "${swagger.info.title}",
                description = "${swagger.info.description} (${server.env} Environment)",
                version = "${swagger.info.version}",
                license = @License(name = "API License", url = "${swagger.info.license.url}")
        ),
        servers = {@Server(url = "${project.url}", description = "Default Server URL")}
)

@Configuration
public class Swagger3Config {
}
