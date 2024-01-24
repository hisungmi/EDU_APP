# 학원 관련 데이터 및 학원생을 관리하는 ‘학원 관리 플랫폼 EDU’
### 📱EDUcation 개발 배경
1. 사용자별 사용 환경
- 기존 EDU Web 프로그램의 경우, 강사와 관리자에게 적합한 사용 환경.
- 또 다른 주 사용자인 학부모와 학생 유저의 프로그램 활용 환경 및 특성을 
 고려할 때, 애플리케이션 서비스를 제공하는 것이 적합하다고 판단.
- 웹 환경의 주 사용층인 관리자 유저와 비교했을 때, 모바일 환경과 이란 유
 저 특성에 최적화된 기능 및 UI 개발의 필요성을 느낌.
2. 사용자별 서비스 이용 유형
- 해당 유저의 경우, 데이터 열람이 주 사용 목적이므로 시간과 장소 제약 없
 는 서비스가 제공되어야 함.
- 지속적인 접속보다는 상시적인 접속이 특성이므로 매번 로그인을 통한 권한 
 확인 절차를 거치는 것은 비효율적임.
3. 사용자별 주 이용 서비스
- 학원에 배치될 키오스크와 연계하여 해당 장소에서만 진행되어야 하는 모바
 일 서비스 (출석체크 등) 필요.
4. 사용자 경험 고려
- 웹 프로그램을 기존 프로그램의 사용성 문제를 개선을 주목적으로 제작한 
 만큼, 애플리케이션도 사용자 경험을 고려하여 제작할 필요성을 느낌.
## 📝EDU 연구개발 목표
사교육 시장 규모가 계속해서 확대되는 추세에 따라 학원 관리 프로그램의 필요성도 강조되고 있다.
현재 높은 비중으로 사용되고 있는 학원 관리 프로그램은 2000년대에 설계되어 지속적으로 유지보수 되어 사용되고 있다. 오랜 기간 큰 변화 없이 사용된 만큼 노후화된 UI(User Interface)와 UX(User Experience) 구성이 유지되고 있다. 
기존 프로그램의 단점을 개선하여 효율적인 학원 데이터 및 업무 관리를 위한 새로운 관리 플랫폼의 개발을 목표로 한다. 나아가 관계자 외 사용자들의 편의성을 위한 어플리케이션도 개발하고자 한다.

## ✍️연구개발 내용
제공해야 할 데이터들을 설계하기 위해 학원 관계자의 조언을 받아 요구사항 분석을 진행하고 그에 맞게 학원 데이터를 효율적으로 입력, 출력할 수 있도록 데이터 모델링 작업을 먼저 수행하였다. 
기존 프로그램의 단점을 개선하기 위해 서비스 이용 기기에 적합한 기능을 제공할 수 있도록 UI 및 UX를 구성하였다.
이를 위해 서비스 이용 기기를 데스크탑, 키오스크, 태블릿, 모바일 총 4가지의 기기로 나누어 각 기기의 특성을 정리하였다.
<details>
 <summary>
  👀특성
 </summary>
 - 데이터 입력과 열람의 수월함
- 기기의 휴대성
- 제공 기능의 한정성
- 데이터 처리량
</details>

###### 데스크탑(웹) 서비스 - 학원 관계자를 주 사용층
###### 모바일(어플리케이션) 서비스 - 학원생과 학부모를 주 사용층
###### 태블릿 서비스 - 학원에 비치되는 키오스크 및 강의실마다 비치
## 🛜활용 분야
사교육이 이루어지는 학원에서 사용할 수 있다. 정해진 교육 과정이 있고 해당 과정의 수강을 원하는 교육생들이 있을 때, 관리자가 교육 과정에 교육생들을 직접 배치한다. 그리고 배치된 교육생들을 관리하는 교육자가 있는 환경에서 프로그램을 사용할 것으로 생각하고 설계되었다.
전체 과정을 관리자가 최종적으로 확인하는 과정을 거쳐 프로그램을 통해 일어나는 과정을 관리자가 필수적으로 인지할 수 있도록 하였다. 또한 어플리케이션은 학원에 다니는 학원생들과 자녀의 학업 관리를 위해 힘쓰는 학부모들은 관계자와 소통하고 학원 생활을 편리하게 관리할 수 있도록 하였다.
## 🌟기대효과
학원 관리 업무 특성 상 관리해야 할 정보들이 많은데, 이러한 정보들을 효율적으로 입력 및 출력할 수 있도록 하여 사용자의 프로그램 사용 시 피로도를 절감하여 업무 효율성을 증가를 기대할 수 있다. 학원을 관리하게 되는 관리자 이외 학원 이용 고객인 학부모와 학생 이용자에게도 직관적인 UI를 제공하여 필요한 정보를 쉽게 확인할 수 있도록 한다.
## 🎥구현 영상
[![Video Label](http://img.youtube.com/vi/wkHJjfJlmok/0.jpg)](https://youtu.be/wkHJjfJlmok)
##### 🎥발표 영상
[![Video Label](http://img.youtube.com/vi/DBk3ugJbSwM/0.jpg)](https://youtu.be/DBk3ugJbSwM)
[![Video Label](http://img.youtube.com/vi/kpkLQyLNy0Y/0.jpg)](https://youtu.be/kpkLQyLNy0Y)

## 📱EDUcation
#### 로딩 및 로그인
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/813bc819-b681-46a3-8b2a-95d8de76c2c2" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/38901ec5-9486-4652-99e6-b8a8bb476a72" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/0061e014-11ce-4fc3-bef8-b43739a2de38" width="200" height="400"/>

#### 시간표 열람 및 강의
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/41c12f69-ffa7-4907-9226-2325bd4e4db0" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/bb465ee3-d958-4a49-bd5f-8ae147700851" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/561a4bc2-479b-4630-b466-f312209e243d" width="200" height="400"/>

#### 건의사항
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/4b565b2e-d76d-48ca-b175-d9feb25ade14" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/b622a822-78f2-4d37-9348-6266c4d3bdb0" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/1dc40227-f293-42ed-b970-bdef26ab5d92" width="200" height="400"/>

#### 메뉴 및 프로필
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/1692e357-aa25-481e-bdc1-729b55336e60" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/32b65e47-cd41-4a3c-a6a4-85a567130cfc" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/aca22821-e480-4b24-8c06-84e23e6e886e" width="200" height="400"/>

#### 출결 현황
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/73f306c6-4929-4c20-ae1c-23ed01cfd12d" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/803226ce-f869-4bad-b4c0-54e8d0dec08e" width="200" height="400"/>

#### 과제 관리
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/bda94eaa-151f-4bf6-9b26-3d6473990bd1" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/68ac91d1-be0b-4997-85df-bf126ee88327" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/bca45234-e4f2-49df-9f4e-b7e0b02b4322" width="200" height="400"/>

#### 공지 및 로그아웃
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/cdbfa84a-626c-4ef4-b528-2ec30122480a" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/87ea9ef6-e695-48e0-b3bf-ad400b304511" width="200" height="400"/>

## 👨🏻‍👩🏻‍👧🏻‍👦🏻학부모용 페이지
#### 자녀 선택 및 자녀 시간표 열람
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/29598b23-8839-41ce-b290-396a8bcc385d" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/a8d0c73e-eb68-48dc-ae48-6eced73d34bf" width="200" height="400"/>
<img src="https://github.com/hisungmi/EDU_APP/assets/104122239/b202f0ab-328c-40bb-a2bb-015ab268d65f" width="200" height="400"/>

## 🔍개발언어
![js](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
