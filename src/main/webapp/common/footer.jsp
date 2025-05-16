<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div class="footer-wrapper">
        <footer class="footer">
            <div class="footer-left">
                <h4>이용약관 &nbsp;&nbsp;&nbsp; 개인정보처리방침</h4>
                <div class="business-info">
                    (주)원숭이와춤을&nbsp;&nbsp;&nbsp;&nbsp;대표: 왕징판&nbsp;&nbsp;&nbsp;&nbsp;사업자등록번호: 041-01-00410
                    <a href="#" onclick="toggleModal()">사업자정보확인</a><br>
                    통신판매업: 제 0410-서울특별시-0410 호<br>
                    사업장소재지: 서울 종로구 율곡로10길 105 디아망타워 4층
                    <p style="margin-top:10px;">© DUICK Corp. | 1.0.0</p>
                </div>
            </div>

            <div class="footer-right">
                <h4>고객센터 031-123-1234</h4>
                <p>운영시간 안쉽니다<br>점심시간 평일 13:00 - 14:00</p>
                <a class="faq-button" href="#">자주 묻는 질문</a>
                <div class="social-icons">
                    <!-- <img src="chat.png" alt="채팅">
                    <img src="insta.png" alt="인스타">
                    <img src="blog.png" alt="블로그"> -->
                </div>
            </div>
        </footer>
    </div>

    <!-- 모달 -->
    <div class="modal" id="bizModal">
        <div class="modal-content">
            <p><strong>(주)원숭이와춤을</strong> &nbsp;&nbsp;&nbsp;&nbsp;| 왕징판</p>
            <p>사업자등록번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 041-01-00410</p>
            <p>통신판매업 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 제 0410-서울특별시-0410 호</p>
            <p>사업장소재지 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 서울 종로구 율곡로10길 105 디아망타워 4층</p>
            <button onclick="toggleModal()">확인</button>
        </div>
    </div>

    <script>
        

        function toggleModal() {
            document.getElementById('bizModal').classList.toggle('show');
        }
    </script>
