<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/components/lib.jsp" %>

<html>
<head>
    <title>Admin page</title>
    <%@ include file="/WEB-INF/views/components/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/components/header.jsp" %>
<div class="content">
    <%@ include file="/WEB-INF/views/admin/side_bar.jsp" %>
    <div class="main-content">

        <div class="tariff_list edit-tariff-page">
            <table class="striped">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Duration</th>
                    <th>Service</th>
                    <th>Function</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${tariffPage.total > 0}">
                    <c:forEach var="tariff" items="${tariffPage.tariffList}">
                        <form method="get"
                              action="${pageContext.request.contextPath}/InternetProvider/updateTariff">
                            <tr>
                                <input type="text" name="id" value="${tariff.id}" hidden>
                                <td><input name="name" type="text" value="${tariff.name}"></td>
                                <td><input name="description" type="text" value="${tariff.description}"></td>
                                <td><input name="price" type="text" value="${tariff.price}"></td>
                                <td><input name="duration" type="text" value="${tariff.duration}"></td>
                                <td>
                                    <select name="serviceId">
                                        <c:forEach var="service" items="${tariffPage.serviceList}">
                                            <option value="${service.id}" ${tariff.service.name.equals(service.name) ? "selected" : ""}>
                                                    ${service.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input name="page" value="${tariffPage.page}" hidden>
                                    <input name="page" value="${tariffPage.pageSize}" hidden>
                                    <button class="btn-small" type="submit">update</button>
                                </td>
                        </form>
                        <form method="get"
                              action="${pageContext.request.contextPath}/InternetProvider/deleteTariff">
                            <td>
                                <input type="text" name="id" value="${tariff.id}" hidden>
                                <input name="page"
                                       value="${tariffPage.total % tariffPage.pageSize == 1 && tariffPage.total != 1 ? tariffPage.page-1 : tariffPage.page}"
                                       hidden>
                                <input name="page" value="${tariffPage.pageSize}" hidden>
                                <button class="btn-small" type="submit">delete</button>
                            </td>
                        </form>
                        </tr>
                    </c:forEach>
                </c:if>
                <form method="post"
                      action="${pageContext.request.contextPath}/InternetProvider/createTariff">
                    <tr>
                        <td><input name="name" type="text"></td>
                        <td><input name="description" type="text"></td>
                        <td><input name="price" type="text"></td>
                        <td><input name="duration" type="text"></td>
                        <td>
                            <select name="serviceId">
                                <c:forEach var="service" items="${tariffPage.serviceList}">
                                    <option value="${service.id}">
                                            ${service.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td colspan="2">
                            <input name="page"
                                   value="${tariffPage.total % tariffPage.pageSize == 0 && tariffPage.total != 0? tariffPage.page+1 : tariffPage.page}"
                                   hidden>
                            <input name="page" value="${tariffPage.pageSize}" hidden>
                            <button class="btn-small">add</button>
                        </td>
                    </tr>
                </form>
                </tbody>
            </table>
            <c:if test="${tariffPage.getTotal() > 0}">
                <div class="tariff-pagination">
                    <ul class="pagination">

                        <c:forEach begin="0" end="${(Math.ceil(tariffPage.getTotal() / tariffPage.getPageSize()))-1}"
                                   varStatus="i">
                            <li class="${tariffPage.page ==  i.index ? "active" : ""}">
                                <a href="${pageContext.request.contextPath}/InternetProvider/getTariffList?page=${i.index}&size=5">${i.index+1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <p class="center-align red-text text-darken-2 warning__message">${requestScope.get("errorMessage")}</p>
            <p class="center-align green-text text-darken-2 successful__message">${requestScope.get("successMessage")}</p>
        </div>
    </div>
</div>
</body>
</html>