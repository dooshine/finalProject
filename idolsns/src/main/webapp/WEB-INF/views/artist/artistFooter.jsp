<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- develope-css -->
    <style>
        .develope-back-forestgreen {
            background: forestgreen;
            min-height: 300px;
        }
        .develope-back-aqua {
            background: aquamarine;
            min-height: 300px;
        }
    </style>
            </div>
            <!-- 오른쪽 어사이드 -->
            <div class="col-3 container ps-5 pe-4">
                <!-- 캘린더 -->
                <div class="row develope-back-forestgreen">
                    <h1>캘린더</h1>
                </div>
                <!-- 캘린더 내 일정 -->
                <div class="row develope-back-aqua">
                    <h1>캘린더 내 일정</h1>
                </div>
            </div>
        </div>
        
        </section>
        <hr>
        <footer>
            <h1>푸터</h1>
            <h2>세션 memberId: ${sessionScope.memberId}</h2>
            <h2>세션 memberLevel: ${sessionScope.memberLevel}</h2>
        </footer>
    </main>
    <!-- 부트스트랩 js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>