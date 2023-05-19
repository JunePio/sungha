package com.gn.sungha.common;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

@Data
public class UserVo implements UserDetails{
    private int id;
    private String username;
    private String password;
    private String name;
    private String email;
    private String telNo ;
    private String userState;
    private String organizationId;
    private String confirmState;
    private String confirmDateTime;
    private String role;
    private String cancelDateTime;
    private String regDateTime;
    private String modDateTime;
    private String lastLoginDateTime;



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(this.role));
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    // 시큐리티의 userName
    // -> 따라서 인증할 때 id를 봄
    @Override
    public String getUsername() {
        return this.username;
    }

    // Vo의 userName !
    public String getUserName(){
        return this.username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
