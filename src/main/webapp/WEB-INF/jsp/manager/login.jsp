<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<!DOCTYPE html>
<html lang="en" class="fullscreen-bg">
<head>
    <title>后台登录</title>
    <jsp:include page="/WEB-INF/jsp/pub/head_meta.jsp"/>
    <jsp:include page="/WEB-INF/jsp/pub/head_script.jsp"/>
    <link rel="shortcut icon" href="${pageIcon}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/linearicons/style.css">
    <!-- MAIN CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/static/css/manager/main.css">
    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/public/static/js/jquery.cookie.js"></script>
    <script src="${pageContext.request.contextPath}/public/static/js/jquery.base64.js"></script>
    <script src="${pageContext.request.contextPath}/plugins/gt/gt.js"></script>
    <script language="javascript" type="text/javascript">
        function setCookie() { //设置cookie
            var loginCode = $("#username").val(); //获取用户名信息
            var pwd = $("#password").val(); //获取登陆密码信息
            var checked = $("input[type='checkbox']").is(':checked');//获取“是否记住密码”复选框
            if (checked) { //判断是否选中了“记住密码”复选框
                $.cookie("username", loginCode);//调用jquery.cookie.js中的方法设置cookie中的用户名
                $.cookie("pwd", $.base64.encode(pwd));//调用jquery.cookie.js中的方法设置cookie中的登陆密码，并使用base64（jquery.base64.js）进行加密
            } else {
                $.cookie("pwd", null);
            }
            return (loginCode.trim()!=="" && pwd.trim()!=="");
        }
        function getCookie() { //获取cookie
            var loginCode = $.cookie("username"); //获取cookie中的用户名
            var pwd = $.cookie("pwd"); //获取cookie中的登陆密码
            var pwdlength = $.base64.decode(pwd).length;
            if (pwdlength != 0) {//密码存在的话把“记住用户名和密码”复选框勾选住
                //alert("123");
                $("[type='checkbox']").attr("checked", "true");
            }
            if (loginCode) {//用户名存在的话把用户名填充到用户名文本框
                $("#username").val(loginCode);
            }
            if (pwd) {//密码存在的话把密码填充到密码文本框
                $("#password").val($.base64.decode(pwd));
            }
        }
        // 加载验证码
        var handler = function (captchaObj) {
            $("#submit").click(function (e) {
                var result = captchaObj.getValidate();
                if (!result) {
                    $("#notice2").show();
                    setTimeout(function () {
                        $("#notice2").hide();
                    }, 2000);
                } else {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/verifyLogin',
                        type: 'POST',
                        dataType: 'json',
                        data: {
                            username: $('#username').val(),
                            password: $('#password').val(),
                            geetest_challenge: result.geetest_challenge,
                            geetest_validate: result.geetest_validate,
                            geetest_seccode: result.geetest_seccode
                        },
                        success: function (data) {
                            if (data.status === 'success') {
                                alert('登录成功');
                            } else if (data.status === 'fail') {
                                alert('登录失败');
                            }
                        }
                    })
                }
                e.preventDefault();
            });
            // 将验证码加到id为captcha的元素里，同时会有三个input的值用于表单提交
            captchaObj.appendTo("#captcha");
            captchaObj.onReady(function () {
                $("#wait").hide();
            });
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/initCaptcha?t=" + (new Date()).getTime(), // 加随机数防止缓存
            type: "get",
            dataType: "json",
            success: function (data) {
                initGeetest({
                    gt: data.gt,
                    challenge: data.challenge,
                    new_captcha: data.new_captcha, // 用于宕机时表示是新验证码的宕机
                    offline: !data.success, // 表示用户后台检测极验服务器是否宕机，一般不需要关注
                    product: "popup", // 产品形式，包括：float，popup
                    width: "100%"
                }, handler);
            }
        });
    </script>
</head>
<body style="height: 100%;" onload="getCookie();">
    <div id="wrapper" style="height: 100%;">
        <div class="vertical-align-wrap">
            <div class="vertical-align-middle">
                <div class="auth-box ">
                    <div class="left">
                        <div class="content">
                            <div class="header">
                                <div class="logo text-center" style="color: red;">${requestScope.msg}</div>
                                <p class="lead">账号登录</p>
                            </div>
                            <form class="form-auth-small" method="POST" action="${pageContext.request.contextPath}/admin/login" onsubmit="return setCookie()">
                                <div class="form-group">
                                    <label for="username" class="control-label sr-only">登录名</label>
                                    <input type="text" class="form-control" name="username" id="username" placeholder="登录账号">
                                </div>
                                <div class="form-group">
                                    <label for="password" class="control-label sr-only">密码</label>
                                    <input type="password" class="form-control" name="password" id="password" placeholder="Password">
                                </div>
                                <div>
                                    <div id="captcha">
                                        <p id="wait" class="show">正在加载验证码......</p>
                                    </div>
                                </div>
                                <div class="form-group clearfix">
                                    <label class="fancy-checkbox element-left">
                                        <input type="checkbox">
                                        <span>记住密码</span>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">登录</button>
                                <div class="bottom">
                                    <span class="helper-text"><i class="fa fa-lock"></i> <a href="#">忘记密码?</a></span>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="right">
                        <div class="overlay"></div>
                        <div class="content text">
                            <h1 class="heading">影音播放系统后台登录</h1>
                            <p>欢迎来到影音的世界</p>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>