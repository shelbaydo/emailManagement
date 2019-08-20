<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>User | 控制面板</title>
    <jsp:include page="../includes/header.jsp"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <jsp:include page="../includes/nav.jsp"/>
    <jsp:include page="../includes/menu.jsp"/>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                用户信息管理
                <small></small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li class="active">用户信息管理</li>
            </ol>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${baseResult != null}">
                        <div class="alert alert-${baseResult.status == 200 ? "success" : "danger"} alert-dismissible">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                ${baseResult.message}
                        </div>
                    </c:if>
                    <div class="box box-info box-info-search" style="display: none">
                        <div class="box-header">
                            <h3 class="box-title">高级搜索</h3>
                            <div class="box-body">
                                <div class="row form-horizontal">
                                    <div class="col-sm-4 col-xs-12">
                                        <div class="form-group">
                                            <label for="username" class="col-sm-4 control-label">用户名称</label>

                                            <div class="col-sm-8">
                                                <input id="username" class="form-control" placeholder="用户名称">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-xs-12">
                                        <div class="form-group">
                                            <label for="status" class="col-sm-4 control-label">用户状态</label>

                                            <div class="col-sm-8">
                                                <select id="status" class="form-control">
                                                    <option value="">--请选择--</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-xs-12">
                                        <div class="form-group">
                                            <label for="role" class="col-sm-4 control-label">用户类型</label>

                                            <div class="col-sm-8">
                                                <select id="role" class="form-control">
                                                    <option value="">--请选择--</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer">
                                <button class="btn btn-info pull-right" onclick="search();">搜索</button>
                            </div>
                        </div>
                    </div>

                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">用户列表</h3>
                        </div>
                        <div class="box-body">
                            <button class="btn btn-primary btn-sm" onclick="$('.box-info-search').css('display') == 'none' ? $('.box-info-search').show('fast') : $('.box-info-search').hide('fast')"><i class="fa fa-download">搜索</i></button>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body table-responsive">
                            <table id="dataTable" class="table table-hover">
                                <thead>
                                <tr>
                                    <th>用户名</th>
                                    <th>用户状态</th>
                                    <th>用户类型</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${userList}" var="user">
                                        <tr>
                                            <td>${user.userName}</td>
                                            <td><c:if test="${user.isActive == 0}">非法用户</c:if><c:if test="${user.isActive == 1}">合法用户</c:if></td>
                                            <td><c:if test="${user.role == 0}">管理员</c:if><c:if test="${user.role == 1}">普通用户</c:if></td>
                                            <td><button class="btn btn-danger btn-sm" onclick=""><i class="fa fa-trash-o">锁定</i></button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-primary btn-sm" onclick=""><i class="fa fa-trash-o">解除</i></button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </section>
    </div>
</div>
<!-- /.content-wrapper -->
<jsp:include page="../includes/copyright.jsp"/>
<jsp:include page="../includes/footer.jsp"/>

</body>
</html>