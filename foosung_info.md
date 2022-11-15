# Foosung Server Information

> Foosung domain.  **https://example.com**

<br>

> 🔴 **: 실서버 정보** <br>
> 🟢 **: 개발서버 정보** <br>
> 🟡 **: 연동서버 정보**

<br>

## 실서버 정보

<br>

> 🔴 **Foosung application**
>> 
- **host**
    - 211.231.146.65
- **id/pw**
    - administrator / !flatm2

> 🔴 **Database Server**
>> 
- **host**
    - 211.231.146.66
- **id/pw**
    - administrator / !flatm2
- **SYS, SYSTEM PW**
    - Lims#066
- **DB ID/PW**
    - CM_ENF_USER / CM_ENF_USER
- **SID**
  - lims
- **DB port**
    - 22221

> 🔴 **Rdms Server**
>> 
1. **아산 수집서버**
    - **host**
        - 10.130.1.110
    - **id/pw**
        - administrator / !flatm2
    - **SYS, SYSTEM PW**
        - Rdms#110
    - **DB id/pw**
        - rdms / manager
    - **DB port**
        - 22221
2. **천안 수집서버**
    - **host**
        - 10.140.1.110
    - **ID/PW**
        - administrator / !flatm2
    - **SYS, SYSTEM PW**
        - Rdms#110
    - **DB id/pw**
        - rdms / manager
    - **DB port**
        - 22221

> 🟡 **SMTP Server**
>> 
- **host**
    - 211.231.146.160
- **port**
    - 25
- **발신자 메일**
    - sysadmin@enftech.com

> 🟡 **Sap MSSQL Server**
>> 
- **host**
    - 61.81.242.15
- **DB port**
    - 1433
- **DatabaseName**
    - ENF_QMS
- **DB id/pw**
    - limsadm / limsadm!


## 개발 서버 정보

> 🟢 **lims Database**
>> 
- **host**
    - 203.229.218.187
- **port**
    - 22221
- **SID**
    - iit
- **id/pw**
    - CM_ENF_USER / CM_ENF_USER
- **id/pw ( 실서버 데이터 동기화 되어있는 user )**
    - CM_ENF_MST_USER / CM_ENF_MST_USER

> 🟢 **Sap Database**
>> 
- **host**
    - 203.229.218.217
- **port**
    - 22223
- **DatabaseName**
    - ENF_SAP_MASTER
- **id/pw**
    - iit_user / iit3274!@