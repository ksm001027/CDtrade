# 🐵 원숭이와 춤을 | CD 중고거래 및 앨범 리뷰 플랫폼

> 중고 CD 거래와 앨범 리뷰를 통합한 음악 기반 커뮤니티 플랫폼


## 📌 프로젝트 개요

- **기간**: 2025.04.21 ~ 2025.05.14  
- **참여 인원**: 5인 팀 프로젝트 (팀장: 김다영)  
- **역할**: API 설계 및 개발, 앨범 관련 전체 기능 구현, HTML/CSS 레이아웃  

> “원숭이와 춤을”은 음악 애호가를 위한 중고 CD 거래 + 앨범 리뷰 기반 플랫폼입니다.  
> 사용자는 CD를 거래할 수 있을 뿐 아니라, 앨범에 리뷰를 남기고, 이를 기반으로 취향에 맞는 앨범을 추천받을 수 있습니다.


## 💡 주요 기능

- **중고 CD 거래** – 앨범 판매 등록, 상세 조회 및 구매 가능
- **앨범 리뷰** – 별점+텍스트 기반의 리뷰 등록/수정/삭제/조회
- **추천 시스템** – 협업 필터링 기반 사용자 맞춤 앨범 추천
- **마이컬렉션/위시리스트** – 앨범을 저장하고 즐겨찾는 개인화 기능
- **앨범 목록** – 베스트/장르별/키워드별 탐색 및 필터링/정렬 제공
- **최신 리뷰 피드** – 무한스크롤 기반으로 리뷰 흐름 제공


## 🧰 기술 스택

| 영역 | 기술 |
|------|------|
| Frontend | HTML, CSS, JavaScript, jQuery |
| Backend | Java (JSP), Servlet, MyBatis |
| DB | Oracle |
| 개발 도구 | Eclipse, SQL Developer, Tomcat |
| 협업 도구 | Git, GitHub, SourceTree |
| 외부 API | 알라딘 Open API (앨범 정보 수집) |

## ERD 

<img width="2422" height="1748" alt="Image" src="https://github.com/user-attachments/assets/822fff3d-d925-4d33-b1e7-9220afd6b4bf" />

## 🖥 주요 화면 미리보기
<table>
  <tr>
    <td valign="top">
      <br>
      - 메인페이지 (추천 앨범 / 최신 등록 / 장르별 탐색)
      <br><br>
      <img width="500" height="1000" alt="Image" src="https://github.com/user-attachments/assets/1716ba54-69bf-42bc-96f4-a9706f9e0e51" />
    </td>
    <td valign="top">
      <br>
      - 앨범 상세페이지 (판매글, 리뷰, 거래내역, 위시리스트, 마이컬렉션)
      <br><br>
      <img width="500" height="3624" alt="Image" src="https://github.com/user-attachments/assets/fedb24c5-e333-4c8f-999a-192dd71e090b" />
    </td>
  </tr>
  <tr>
    <td valign="top">
      <br>
      - 앨범 목록 페이지 (무한스크롤 + 정렬 필터)
      <br><br>
      <img width="500" height="1954" alt="Image" src="https://github.com/user-attachments/assets/7761ad75-5376-48a3-8bf9-092ccc770078" />
    </td>
    <td valign="top">
      <br>
      - 최신 리뷰 페이지
      <br><br>
      <img width="500" height="2050" alt="Image" src="https://github.com/user-attachments/assets/0399ecc5-6604-496e-b212-0d891d7167ea" />
    </td>
  </tr>
   <tr>
    <td valign="top">
      <br>
      - 위시리스트 및 마이컬렉션 페이지 
      <br><br>
      <img width="500" height="874" alt="Image" src="https://github.com/user-attachments/assets/02087d75-f43a-48d2-99fa-e6a15ebf97c0" />
      <br><br>
      <img width="500" height="958" alt="Image" src="https://github.com/user-attachments/assets/691b26ee-bfea-4dcd-8bf3-929c61650704" />
    </td>
    <td valign="top">
      <br>
      - 사용자 업로드 기반 판매 상품 목록 패이지
      <br><br>
      <img width="500" height="993" alt="Image" src="https://github.com/user-attachments/assets/4ca84870-2825-4d35-9140-f252e08308a1" />
    </td>
  </tr>
</table>

- 베스트/장르별/키워드별 앨범 탐색 화면
- 마이컬렉션, 위시리스트, 최신리뷰 피드
