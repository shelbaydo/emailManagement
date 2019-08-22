<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                                    <option value="0">非法用户</option>
                                                    <option value="1">合法用户</option>
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
                                                    <option value="0">管理员</option>
                                                    <option value="1">普通用户</option>
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
                            <button class="btn btn-primary btn-sm"
                                    onclick="$('.box-info-search').css('display') === 'none' ? $('.box-info-search').show('fast') : $('.box-info-search').hide('fast')">
                                <i class="fa fa-search">搜索</i></button>
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

<script>
    var dataTable;
    $(function () {
        //初始化DataTables
        var columns = [
            {"data": "userName"},
            {
                "data": "isActive",
                "render": function ( data, type, full, meta ) {
                    if (data === 0)
                        return "非法用户";
                    else
                        return "合法用户";
                }
            },
            {
                "data": "role",
                "render": function ( data, type, full, meta ) {
                    // alert(data);
                    if (data === 0)
                        return "管理员";
                    else
                        return "普通用户";
                }
            },
            {
                "data": function (row, type, val, meta) {
                    return '<button class="btn btn-danger btn-sm" onclick="lock(\'' + row.id + '\' ,\'' + row.isActive + '\' ,\'' + row.role + '\' )"><i class="fa fa-lock"> 锁定</i></button>&nbsp;&nbsp;&nbsp;' +
                        '<button class="btn btn-primary btn-sm" onclick="unlock(\'' + row.id + '\' ,\'' + row.isActive + '\' ,\'' + row.role + '\' )"><i class="fa fa-unlock-alt"> 解除</i></button>&nbsp;&nbsp;&nbsp;';
                }
            }
        ];
        dataTable = App.initDataTables("${pageContext.request.contextPath}/user/page", columns);
    });
    //搜索
    function search() {
        var username = $("#username").val();
        var status = $("#status").val();
        var role = $("#role").val();
        //查询参数
        var param = {
            "userName": username,
            "isActive": status,
            "role": role
        };
        if (username === '') {
            delete param.username;
        }
        if (status === '') {
            delete param.isActive;
        }
        if (role === '') {
            delete param.role;
        }
        console.log(param);
        if (param !== {}) {
            //设置参数，重新加载
            dataTable.settings()[0].ajax.data = param;
            dataTable.ajax.reload();
        }
    }
    //锁定
    function lock(id, isActive, isAdmin) {
        if (isAdmin === '0') {
            alert("无法对管理员账号进行该操作");
            return;
        }
        if (isActive === '0') {
            alert("当前用户状态为：非法用户，无法再次锁定");
        } else {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/user/lock/" + id,
                dataType: 'json',
                success: function (msg) {
                    // alert(msg["message"]);
                    if (msg["message"] === "success") {
                        dataTable.ajax.reload();
                        alert("锁定用户成功");
                    } else {
                        alert("锁定用户失败");
                    }
                }
            });
        }
    }
    //解除锁定
    function unlock(id, isActive, isAdmin) {
        if (isAdmin === '0') {
            alert("无法对管理员账号进行该操作");
            return;
        }
        if (isActive === '1') {
            alert("当前用户状态为：合法用户，无法解除锁定");
        } else {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/user/unlock/" + id,
                dataType: 'json',
                success: function (msg) {
                    // alert(msg["message"]);
                    if (msg["message"] === "success") {
                        dataTable.ajax.reload();
                        alert("解除锁定成功");
                    } else {
                        alert("解除锁定失败");
                    }
                }
            });
        }
    }
</script>
</body>
</html>