<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dbpkg.Util" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    request.setCharacterEncoding("UTF-8");
    String title = Util.getParamNN(request.getParameter("title"));
    String page_no;

    if (Util.getParamNN(request.getParameter("page")).equals("")) {
        page_no = "1";
    } else {
        page_no = Util.getParamNN(request.getParameter("page"));
    }

%>
<!DOCTYPE html>
<html class="h-100">
<head>
    <%@ include file="head.jsp" %>
</head>
<body class="container d-flex flex-column h-100">
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<main role="main" class="mt-2">
    <section>
        <h1 class="text-center">독서기록장 검색</h1>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">제목</th>
                <th scope="col">날짜</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection conn = Util.getConnection();
                Statement stmt = conn.createStatement();

                String sql_create_table = "declare begin execute immediate 'CREATE TABLE BOOK (IDX INT PRIMARY KEY NOT NULL, TITLE VARCHAR2(50) NOT NULL, CONTEXT VARCHAR2(4000) NOT NULL, DATETIME DATE NOT NULL)'; exception when others then if SQLCODE = -955 then null; else raise; end if; end;";
                String sql_list = "SELECT * FROM ( " +
                        "SELECT A.*, ROWNUM AS RNUM, COUNT(*) OVER() AS TOTCNT " +
                        "FROM ( SELECT * FROM BOOK WHERE TITLE LIKE '%" + title + "%' ORDER BY IDX DESC ) A ) " +
                        "WHERE RNUM >= 10 * ( " + page_no + " - 1 ) + 1 AND RNUM <= " + page_no + " * 10";
                String sql_count = "SELECT COUNT(IDX) CNT FROM BOOK WHERE TITLE LIKE '%" + title + "%'";

                try {
                    stmt.execute(sql_create_table);

                    ResultSet rs_list = stmt.executeQuery(sql_list);

                    while (rs_list.next()) {
            %>
            <tr>
                <th scope="row"><%= rs_list.getInt("IDX") %>
                </th>
                <td><a href="context.jsp?idx=<%= rs_list.getInt("IDX") %>"
                       class="text-black text-decoration-none"><%= rs_list.getString("TITLE") %>
                </a></td>
                <td><%= rs_list.getString("DATETIME") %>
                </td>
            </tr>
            <%
                }
                    rs_list.close();
            %>
            </tbody>
        </table>
        <%
            ResultSet rs_count = stmt.executeQuery(sql_count);

            rs_count.next();

            int pageno = (int) Math.ceil(rs_count.getDouble("CNT") / 10);
            rs_count.close();
        %>
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="board.jsp?page_no=1" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <% for (int i = 1; i <= pageno; i++) { %>
                <li class="page-item <%= page_no.equals(Integer.toString(i)) ? "active" : "" %>">
                    <a class="page-link" href="board.jsp?page_no=<%= i %>"><%= i %>
                    </a>
                </li>
                <% } %>
                <li class="page-item">
                    <a class="page-link" href="board.jsp?page_no=<%= pageno %>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <%
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <div class="alert alert-danger" role="alert">
            오류가 발생했습니다.
        </div>
        <%
            }
        %>
    </section>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>
