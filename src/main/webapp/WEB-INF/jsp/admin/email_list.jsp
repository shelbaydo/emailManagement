<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Email | 控制面板</title>
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
                非法邮件信息管理
                <small></small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li class="active">非法邮件信息管理</li>
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
                                    <div class="col-sm-5 col-xs-12">
                                        <div class="form-group">
                                            <label for="sender" class="col-sm-4 control-label">发件人</label>

                                            <div class="col-sm-8">
                                                <input id="sender" class="form-control" placeholder="发件人">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5 col-xs-12">
                                        <div class="form-group">
                                            <label for="receiver" class="col-sm-4 control-label">收件人</label>

                                            <div class="col-sm-8">
                                                <input id="receiver" class="form-control" placeholder="收件人">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row form-horizontal">
                                    <div class="col-sm-5 col-xs-12">
                                        <div class="form-group">
                                            <label for="title" class="col-sm-4 control-label">标题</label>

                                            <div class="col-sm-8">
                                                <input id="title" class="form-control" placeholder="标题">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5 col-xs-12">
                                        <div class="form-group">
                                            <label for="status" class="col-sm-4 control-label">邮件状态</label>

                                            <div class="col-sm-8">
                                                <select id="status" class="form-control">
                                                    <option value="">--请选择--</option>
                                                    <option value="0">未读</option>
                                                    <option value="1">已读</option>
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
                            <h3 class="box-title">非法邮件列表</h3>
                        </div>
                        <div class="box-body">
                            <button class="btn btn-primary btn-sm" onclick="$('.box-info-search').css('display') === 'none' ? $('.box-info-search').show('fast') : $('.box-info-search').hide('fast')"><i class="fa fa-search">搜索</i></button>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body table-responsive">
                            <table id="dataTable" class="table table-hover">
                                <thead>
                                <tr>
                                    <th>发送人</th>
                                    <th>收件人</th>
                                    <th>邮件标题</th>
                                    <th>附件路径</th>
                                    <th>是否已读</th>
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
            {"data": "sender.userName"},
            {"data": "receiver.userName"},
            {"data": "emailTitle"},
            {"data": "emailAttach"},
            {
                "data": "isRead",
                "render": function ( data, type, full, meta ) {
                    if (data === 0)
                        return "未读";
                    else
                        return "已读";
                }
            },
            {
                "data": function (row, type, val, meta) {
                    return '<button class="btn btn-danger btn-sm" onclick="deleteCheck(\'' + row.emailId + '\')"><i class="fa fa-trash-o"> 删除</i></button>&nbsp;&nbsp;&nbsp;';
                }
            }
        ];
        dataTable = App.initDataTables("${pageContext.request.contextPath}/email/page", columns);
    });
    //搜索
    function search() {
        var sender = $("#sender").val();
        var receiver = $("#receiver").val();
        var title = $("#title").val();
        var status = $("#status").val();
        //查询参数
        var param = {
            "sender.userName": sender,
            "receiver.userName": receiver,
            "emailTitle": title,
            "isRead": status
        };
        if (sender === '') {
            delete param["sender.userName"];
        }
        if (receiver === '') {
            delete param["receiver.userName"];
        }
        if (title === '') {
            delete param.emailTitle;
        }
        if (status === '') {
            delete param.isRead;
        }
        // console.log(param);
        if (param !== {}) {
            //设置参数，重新加载
            dataTable.settings()[0].ajax.data = param;
            dataTable.ajax.reload();
        }
    }
    //删除
    function deleteCheck(id) {
        if(confirm("您确认删除该邮件吗？")){
            $.ajax({
                type: "GET",
                dataType: "JSON",
                url: "${pageContext.request.contextPath}/email/delete/"+id,
                success: function (msg) {
                    if (msg["message"] === "success") {
                        dataTable.ajax.reload();
                        alert("删除邮件成功");
                    } else {
                        alert("删除邮件失败");
                    }
                }
            })
        }
    }
</script>
</body>
</html>