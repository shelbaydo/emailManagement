<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${ctx}/static/images/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${user.userName}
                    <c:if test="${user.role == 0}">
                       ---管理员
                    </c:if>
                </p>

                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search...">
                <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
            </div>
        </form>
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <c:if test="${user.role == 0}">
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">功能菜单</li>
                <li class="active treeview">
                    <a href="#">
                        <i class="fa fa-apple"></i> <span>用户管理</span>
                        <span class="pull-right-container">
                              <i class="fa fa-angle-left pull-right"></i>
                            </span>
                    </a>
                    <ul class="treeview-menu">
<<<<<<< HEAD
                        <li><a href="${ctx}/app/list"><i class="fa fa-circle-o"></i> 全部用户</a></li>
=======
                        <li><a href="${pageContext.request.contextPath}/user/list"><i class="fa fa-circle-o"></i> 全部用户</a></li>
>>>>>>> origin/master
                    </ul>
                </li>
                <li class="active treeview">
                    <a href="#">
                        <i class="fa fa-book"></i> <span>非法邮件管理</span>
                        <span class="pull-right-container">
                              <i class="fa fa-angle-left pull-right"></i>
                            </span>
                    </a>
                    <ul class="treeview-menu">
<<<<<<< HEAD
                        <li><a href="${ctx}/DevUserDetail"><i class="fa fa-circle-o"></i> 全部非法邮件</a></li>
                    </ul>
                </li>
            </ul>
        </c:if>
        <c:if test="${user.role == 1}">
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">功能菜单</li>
                <li class="active treeview">
                    <a href="#">
                        <i class="fa fa-apple"></i> <span>信件管理</span>
                        <span class="pull-right-container">
                              <i class="fa fa-angle-left pull-right"></i>
                            </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="${ctx}/writeEmail"><i class="fa fa-circle-o"></i> 写信</a></li>
                    </ul>
                    <ul class="treeview-menu">
                        <li><a href="${ctx}/EmailBox"><i class="fa fa-circle-o"></i> 收件箱</a></li>
                    </ul>
                    <ul class="treeview-menu">
                        <li><a href="${ctx}/sent"><i class="fa fa-circle-o"></i> 已发送</a></li>
                    </ul>
                </li>
                <li class="active treeview">
                    <a href="#">
                        <i class="fa fa-book"></i> <span>用户中心</span>
                        <span class="pull-right-container">
                              <i class="fa fa-angle-left pull-right"></i>
                            </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="${ctx}/UserDetail"><i class="fa fa-circle-o"></i> 修改密码</a></li>
=======
                        <li><a href="${pageContext.request.contextPath}/email/list"><i class="fa fa-circle-o"></i> 全部非法邮件</a></li>
>>>>>>> origin/master
                    </ul>
                </li>
            </ul>
        </c:if>
    </section>
    <!-- /.sidebar -->
</aside>