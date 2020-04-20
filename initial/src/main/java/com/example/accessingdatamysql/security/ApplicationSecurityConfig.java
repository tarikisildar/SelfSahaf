package com.example.accessingdatamysql.security;

import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.auth.UserDetailsServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.util.concurrent.TimeUnit;

import static com.example.accessingdatamysql.security.UserRole.ADMIN;
import static com.example.accessingdatamysql.security.UserRole.SELLER;
import static com.example.accessingdatamysql.security.UserRole.USER;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class ApplicationSecurityConfig extends WebSecurityConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;
    private final UserDetailsServiceImp userDetailsServiceImp;

    @Autowired
    public ApplicationSecurityConfig(PasswordEncoder passwordEncoder,
                                     UserDetailsServiceImp userDetailsServiceImp) {
        this.passwordEncoder = passwordEncoder;
        this.userDetailsServiceImp = userDetailsServiceImp;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(daoAuthenticationProvider());
    }

    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setPasswordEncoder(passwordEncoder);
        provider.setUserDetailsService(userDetailsServiceImp);
        return provider;
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new AuthenticationFailiureHandlerImp();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // TODO : edit antMatchers for all apis

        http
                .csrf().disable()
                .authorizeRequests()
                    .antMatchers("/swagger-ui.html/**").permitAll()
                    .antMatchers("/user/add").permitAll()
                    //.antMatchers("/user/**").permitAll()
                    .antMatchers("/product/getBooks", "/product/getSellerBooks").permitAll()
                    .antMatchers("/product/addCategory").hasAnyRole(ADMIN.name())
                    .antMatchers("/product/**").hasAnyRole(USER.name(), ADMIN.name(), SELLER.name())
                    .antMatchers("/user/**").hasAnyRole(USER.name(), ADMIN.name(), SELLER.name())
                    .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                    .loginPage("/login").permitAll()
                    .defaultSuccessUrl("/product/getBooks", true)
                    .passwordParameter("password")
                    .usernameParameter("email")
                    .failureHandler(authenticationFailureHandler())
                .and()
                .rememberMe()
                    .tokenValiditySeconds((int) TimeUnit.DAYS.toSeconds(21))
                    .key("somethingverysecured")
                    .rememberMeParameter("remember-me")
                .and()
                .logout()
                    .logoutUrl("/logout")
                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"))
                    .clearAuthentication(true)
                    .invalidateHttpSession(true)
                    .deleteCookies("JSESSIONID", "remember-me")
                    .logoutSuccessUrl("/login");
    }


}
