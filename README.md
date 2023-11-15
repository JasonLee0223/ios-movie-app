# 🎥 MovieApp (영화 앱)
> `TMDB`, `영화진흥원위원회`, `Kakao` Open API를 사용하여 영화 서비스 앱 구현하기

| 주제 | 항목 |
|:--|:--|
| ■ 언어 | Swift |
| ■ 개발 기간 | 2023.05.01 - 2023.06.01 (Swift - Concurrency 사용) <br/> 2023.8.10 ~ ing |
| ■ 스킬 | Swift-Concurrency, Delegate, AutoLayout, <br/> Refresh Control, CollectionView, Compositional Layout|
| ■ 라이브러리 | RxSwift, RxCocoa, Snapkit, Alamofire |
| ■ 디자인 패턴 | MVVM |

## 🪧 목차

- [🎥 MovieApp (영화 앱)](#-movieapp-영화-앱)
  - [🪧 목차](#-목차)
  - [📱 실행 결과 (Swift - Concurrency 사용)](#-실행-결과-swift---concurrency-사용)
  - [\[리펙토링 중\] 📱 실행 결과 (RxSwift, RxCocoa)](#리펙토링-중--실행-결과-rxswift-rxcocoa)
  - [1. 기능](#1-기능)
    - [🖥️ 홈 화면](#️-홈-화면)
    - [🖥️ 상세 화면](#️-상세-화면)
  - [2. 트러블 슈팅](#2-트러블-슈팅)
    - [🟡 (작성 예정) 2-1. 3가지의 다른 API를 호출하기 위한 방법](#-작성-예정-2-1-3가지의-다른-api를-호출하기-위한-방법)
    - [🔴 (작성 예정) 2-2. Swift-Concurrency(async-await)을 사용한 비동기 로직 구현](#-작성-예정-2-2-swift-concurrencyasync-await을-사용한-비동기-로직-구현)
    - [🟢 2-3. NSCache의 메모리 캐싱을 통한 이미지 관리](#-2-3-nscache의-메모리-캐싱을-통한-이미지-관리)
    - [🔴 (작성 예정) 2-4. RxSwift를 통한 리펙토링](#-작성-예정-2-4-rxswift를-통한-리펙토링)





---

## 📱 실행 결과 (Swift - Concurrency 사용)

<p float="left>
<img src = "https://user-images.githubusercontent.com/92699723/283105286-f16f01e7-8c1f-45ce-ae06-e62e9844bd30.png" width = 20%>
<img src = "https://user-images.githubusercontent.com/92699723/283096095-1d768102-f615-471f-96c2-0950daba1092.png" width = 20%>
<img src = "https://user-images.githubusercontent.com/92699723/283096116-72098cf3-5470-4df6-a370-f695e210b7fd.jpeg" width = 20%>
</p>

---

## [리펙토링 중] 📱 실행 결과 (RxSwift, RxCocoa)

---

## 1. 기능
### 🖥️ 홈 화면
- 총 3가지 섹션을 사용하여 영화 정보를 나타냅니다.
  - 이번 주 영화 트랜드 / 오늘 영화 트렌드
  - 한국 박스오피스 영화 스틸 컷
  - 한국 박스오피스 영화 순위
- 각 영화 포스터를 터치하면 상세화면으로 넘어갑니다.

### 🖥️ 상세 화면
- 홈 화면에서 터치한 영화의 상세 정보를 보여줍니다.
  - 관람 등급 
  - 영화 제목 (한영)
  - 개봉 일자 및 국가
  - 영화 장르 및 상영 시간
  - 줄거리
    - `더보기↓`를 통해 3줄 이상 되는 줄거리를 확인할 수 있습니다.
- 감독 및 등장인물

--- 

## 2. 트러블 슈팅

해결과정에서 체감한 난이도를 아래와 같이 표현합니다.

|난이도|이모지|
|:---:|:---|
|상|🔴|
|중|🟡|
|하|🟢|

### 🟡 (작성 예정) 2-1. 3가지의 다른 API를 호출하기 위한 방법
### 🔴 (작성 예정) 2-2. Swift-Concurrency(async-await)을 사용한 비동기 로직 구현
### 🟢 2-3. NSCache의 메모리 캐싱을 통한 이미지 관리

[Velog - [iOS] NSCache를 사용한 이미지 캐싱](https://velog.io/@jaonlee0223/iOS-NSCache%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%9C-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%BA%90%EC%8B%B1)

### 🔴 (작성 예정) 2-4. RxSwift를 통한 리펙토링
