<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <h1 class="text-center">독서기록장 쓰기</h1>
        <form action="write.jsp" method="POST">
            <div class="mb-3">
                <label for="inputTitle" class="form-label">책 제목</label>
                <input type="text" class="form-control" id="inputTitle" placeholder="제목을 입력하세요. 50자까지 입력가능합니다."
                       name="title" maxlength="50">
            </div>
            <div class="mb-3">
                <label for="inputContext" class="form-label">독서기록장 내용</label>
                <textarea class="form-control" id="inputContext" rows="10" name="context" maxlength="4000"></textarea>
            </div>
            <button class="btn btn-primary float-end" type="submit">작성하기</button>
        </form>
    </section>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>
