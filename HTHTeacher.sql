/*
    HTH 계정 생성 후
    +버튼 클릭 후
    이름 : HTHTeacher
    사용자 이름 : hth
    비밀번호    : 1234
    호스트 이름 : 접속할 ip 주소 cmd에 ipconfig 입력
    포트        : 1521, 방화벽 인바운드, 아웃바운드에 포트 1521 추가 필요
    SID         : xe
*/

INSERT INTO MYCLASS 
 VALUES (8, '윤동재', '010-9848-5936', 'ehdwo1008@naver.com', SYSDATE);
 COMMIT;
 
 SELECT * FROM MYCLASS
 ORDER BY 번호 ASC;