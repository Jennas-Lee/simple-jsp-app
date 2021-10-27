<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dbpkg.Util" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    request.setCharacterEncoding("UTF-8");

    String title = Util.getParamNN(request.getParameter("title"));
    String context = Util.getParamNN(request.getParameter("context"));

    Connection conn = Util.getConnection();
    Statement stmt = conn.createStatement();

    try {
        String sql_create_table = "declare begin execute immediate 'CREATE TABLE BOOK (IDX INT PRIMARY KEY NOT NULL, TITLE VARCHAR2(50) NOT NULL, CONTEXT VARCHAR2(4000) NOT NULL, DATETIME DATE NOT NULL)'; exception when others then if SQLCODE = -955 then null; else raise; end if; end;";
        String sql_count = "SELECT COUNT(IDX) CNT FROM BOOK";

        stmt.execute(sql_create_table);
        ResultSet rs_count = stmt.executeQuery(sql_count);
        rs_count.next();

        String sql_insert = "INSERT INTO BOOK VALUES ('" + rs_count.getInt("CNT") + "', '" + title + "', '" + context + "', sysdate)";
        stmt.execute(sql_insert);

        stmt.close();
        conn.close();
%>
<script>
    alert('독서기록장 등록이 완료되었습니다.');
    location.href = '/list.jsp';
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script>
    alert('오류가 발생했습니다.');
    window.history.back();
</script>
<%
    }
%>