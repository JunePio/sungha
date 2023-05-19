package com.gn.sungha.common;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface UserMapper {
    // 로그인
    UserVo getUserAccount(String userId);

    // 회원가입
    int saveUser(UserVo userVo);

}
