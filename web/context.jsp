<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dbpkg.Util" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    request.setCharacterEncoding("UTF-8");
    String idx;

    if (Util.getParamNN(request.getParameter("idx")).equals("")) {
        idx = "0";
    } else {
        idx = Util.getParamNN(request.getParameter("idx"));
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
        <h1 class="text-center">독서기록장 보기</h1>
        <%
            try {
                String sql_create_table = "declare begin execute immediate 'CREATE TABLE BOOK (IDX INT PRIMARY KEY NOT NULL, TITLE VARCHAR2(50) NOT NULL, CONTEXT VARCHAR2(4000) NOT NULL, DATETIME DATE NOT NULL)'; exception when others then if SQLCODE = -955 then null; else raise; end if; end;";
                String sql_context = "SELECT TITLE, CONTEXT FROM BOOK WHERE IDX = " + idx;

                Connection conn = Util.getConnection();
                Statement stmt = conn.createStatement();

                stmt.execute(sql_create_table);
                ResultSet rs_context = stmt.executeQuery(sql_context);

                if (rs_context.next()) {
        %>
        <div class="mb-3">
            <label for="readTitle" class="form-label">책 제목</label>
            <input type="text" class="form-control" id="readTitle" value="<%= rs_context.getString("TITLE") %>"
                   readonly>
        </div>
        <div class="mb-3">
            <label for="readContext" class="form-label">독서기록장 내용</label>
            <textarea class="form-control" id="readContext" rows="10" readonly><%= rs_context.getString("CONTEXT") %></textarea>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-warning" role="alert">
            독서기록장을 찾을 수 없습니다!
        </div>
        <%
            }
            rs_context.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <div class="alert alert-primary" role="alert">
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
