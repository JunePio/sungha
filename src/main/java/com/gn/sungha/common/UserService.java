package com.gn.sungha.common;


import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;


@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService{
    SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:sss");
    Date time = new Date();
    String localTime = format.format(time);

    private final UserMapper userMapper;

    @Transactional
    public int joinUser(UserVo userVo){
        int result = 0;
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
        userVo.setRole("USER");
        userVo.setRegDateTime(localTime);
        userVo.setModDateTime(localTime);
        result = userMapper.saveUser(userVo);
        return result;
    }

    @Override
    public UserVo loadUserByUsername(String userId) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
        UserVo userVo = userMapper.getUserAccount(userId);
        if (userVo == null){
            throw new UsernameNotFoundException("User not authorized.");
        }
        return userVo;
    }

}
