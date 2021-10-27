<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="list.jsp">독서기록장 목록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="writepage.jsp">독서기록장 쓰기</a>
                </li>
            </ul>
            <form class="d-flex" action="search.jsp" method="GET">
                <input class="form-control me-2" type="search" placeholder="독서기록장 검색" aria-label="Search" name="title">
                <button class="btn btn-outline-success" type="submit"><span>검색</span></button>
            </form>
        </div>
    </div>
</nav>