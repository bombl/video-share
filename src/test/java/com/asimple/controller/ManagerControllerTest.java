package com.asimple.controller;

import com.asimple.App;
import com.asimple.util.LogUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * @ProjectName video
 * @description 后台管理测试
 * @author Asimple
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = App.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ManagerControllerTest {

    @Resource
    private Manager manager;

    @Test
    public void testSome() {
        Object object = manager.createVipCode("1");
        System.out.println(object);
    }

}
