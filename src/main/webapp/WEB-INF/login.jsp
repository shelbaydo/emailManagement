<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<html>
<head>
    <title>内部邮件管理系统 | 用户登录</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${ctx}/static/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${ctx}/static/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${ctx}/static/bower_components/Ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${ctx}/static/dist/css/AdminLTE.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="${ctx}/static/plugins/iCheck/square/blue.css">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="./index.jsp"><b>内部邮件管理系统</b></a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">内部邮件管理系统用户登录</p>

        <form action="${ctx}/login" method="post" id="normal_form">
            <div class="form-group has-feedback">
                <input id="userName" name="userName" type="text" class="form-control" placeholder="用户名"  value="${userName}">
                <c:if test="${error eq 'userName_fail'}">
                    <span id="userName_span" style="color: red" >用户名不存在</span>
                </c:if>
            </div>
            <div class="form-group has-feedback">
                <input id="password" type="password" class="form-control" placeholder="密码" name="password" value="${password}">
                <c:if test="${error eq 'pwd_fail'}">
                    <span id="pwd_span" style="color: red" >密码错误</span>
                </c:if>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="验证码" name="code" id="code" onblur="checkCode()">
                <span id="code_span" style="color: red"></span>
            </div>
            <div>
                <img id="captchaImg" style="CURSOR: pointer" onclick="changeCaptcha()"
                     title="看不清楚?请点击刷新验证码!" align='absmiddle' src="${ctx}/captchaServlet"
                     height="18" width="55">
            </div>
            <div class="row">
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="button" class="btn btn-primary btn-block btn-flat" onclick="normal_login();">登录</button>
                </div>
                <!-- /.col -->
            </div>
        </form>
        <a href="${ctx}/to_register" class="text-center">注册账号</a>
    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="${pageContext.request.contextPath}/static/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${pageContext.request.contextPath}/static/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="${pageContext.request.contextPath}/static/plugins/iCheck/icheck.min.js"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' /* optional */
        });
    });

    //更换验证码
    function changeCaptcha() {
        $("#captchaImg").attr('src', '${ctx}/captchaServlet?t=' + (new Date().getTime()));
    }
    //验证码校验
    var flag_c = false;
    function checkCode() {
        var code = $("#code").val();
        code = code.replace(/^\s+|\s+$/g,"");
        if(code == ""){
            $("#code_span").text("请输入验证码！").css("color","red");
            flag_c = false;
        }else{
            $.ajax({
                type: 'post',
                url: '${ctx}/checkCode',
                data: {"code": code},
                dataType: 'json',
                success: function (data) {
                    var val = data['message'];
                    if (val == "success") {
                        flag_c = true;
                    }else {
                        $("#code_span").text("验证码错误！").css("color","red");
                        flag_c = false;
                    }
                }
            });
        }
        return flag_c;
    }
    function normal_login() {
            $("#normal_form").submit();
    }
</script>
<jsp:include page="./jsp/includes/footer.jsp"/>
</body>
</html>
