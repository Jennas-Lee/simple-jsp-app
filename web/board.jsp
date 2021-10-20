<%@ page import="dbpkg.Util" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head lang="ko">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/bootstrap.min.js"></script>

    <title>게시판</title>
</head>
<body>
<div class="container">
    <h1 class="text-center mt-2">게시판</h1>
    <%
        request.setCharacterEncoding("UTF-8");
        String page_no = Util.getParamNN(request.getParameter("page_no"));
        Connection conn = Util.getConnection();
        Statement stmt = conn.createStatement();
    %>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Title</th>
            <th scope="col">Name</th>
        </tr>
        </thead>
        <tbody>
        <%
            String sql = "SELECT * FROM ( " +
                    "SELECT A.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT " +
                    "FROM ( SELECT * FROM PAGE_PRAC ORDER BY ID DESC ) A ) " +
                    "WHERE RNUM >= 10 * ( " + page_no + " - 1 ) + 1 AND RNUM <= " + page_no + " * 10";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
        %>
        <tr>
            <th scope="row"><%= rs.getString("id") %>
            </th>
            <td><%= rs.getString("title") %>
            </td>
            <td><%= rs.getString("name") %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <%
        String sql2 = "SELECT COUNT(ID) CNT FROM PAGE_PRAC";
        Statement stmt2 = conn.createStatement();
        ResultSet rs2 = stmt2.executeQuery(sql2);

        rs2.next();

        int pageno = (int) Math.ceil(rs2.getDouble("CNT") / 10);
    %>
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <li class="page-item">
                <a class="page-link" href="board.jsp?page_no=1" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <% for (int i = 1; i <= pageno; i++) { %>
            <li class="page-item <%= page_no.equals(Integer.toString(i)) ? "active" : "" %>"><a class="page-link" href="board.jsp?page_no=<%= i %>"><%= i %>
            </a></li>
            <% } %>
            <li class="page-item">
                <a class="page-link" href="board.jsp?page_no=<%= pageno %>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
</body>
</html>
