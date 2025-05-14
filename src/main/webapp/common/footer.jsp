<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div class="footer-wrapper">
        <footer class="footer">
            <div class="footer-left">
                <h4>이용약관 &nbsp;&nbsp;&nbsp; 개인정보처리방침</h4>
                <div class="business-info">
                    (주)세컨드트랙&nbsp;&nbsp;&nbsp;&nbsp;대표: 김방구&nbsp;&nbsp;&nbsp;&nbsp;사업자등록번호: 419-81-02900
                    <a href="#" onclick="toggleModal()">사업자정보확인</a><br>
                    통신판매업: 제 2023-고양일산서-0955 호<br>
                    사업장소재지: 경기도 고양시 일산동구 중앙로 1261번길 77, 704호 B113 (장항동, 메트로폴리스)
                    <p style="margin-top:10px;">© SECONDTRACK Corp. | 1.0.0</p>
                </div>
            </div>

            <div class="footer-right">
                <h4>고객센터 031-931-5878</h4>
                <p>운영시간 평일 10:00 - 19:00 (토,일,공휴일 휴무)<br>점심시간 평일 13:00 - 14:00</p>
                <a class="faq-button" href="#">자주 묻는 질문</a>
                <div class="social-icons">
                    <img src="chat.png" alt="채팅">
                    <img src="insta.png" alt="인스타">
                    <img src="blog.png" alt="블로그">
                </div>
            </div>
        </footer>
    </div>

    <!-- 모달 -->
    <div class="modal" id="bizModal">
        <div class="modal-content">
            <p><strong>(주)세컨드트랙</strong> &nbsp;&nbsp;&nbsp;&nbsp;| 김재니</p>
            <p>사업자등록번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 419-81-02900</p>
            <p>통신판매업 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 제 2023-고양일산서-0955 호</p>
            <p>사업장소재지 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 경기도 고양시 일산동구 중앙로 1261번길 77,
                704호 B113 (장항동, 메트로폴리스)</p>
            <button onclick="toggleModal()">확인</button>
        </div>
    </div>
    <script>
        function toggleModal() {
            document.getElementById('bizModal').classList.toggle('show');
        }
    </script>
