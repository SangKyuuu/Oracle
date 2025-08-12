/*
    25/08/12
    최상규
    9장 트랜잭션 실습
*/

-- 실습1
select * from account;

update account set acc_balance = acc_balance - 10000 where acc_no = '101-11-1001';

update account set acc_balance = acc_balance + 10000 where acc_no = '101-11-1003';

select * from account;

commit; -- 작업확정

-- 실습2

update account set acc_balance = acc_balance - 10000 where acc_no = '101-11-1001';

update account set acc_balance = acc_balance + 10000 where acc_no = '101-11-1003';

select * from account;

rollback; -- 작업취소

-- 실습3
show autocommit; -- autocommit 여부

set autocommit on;

update account set acc_balance = acc_balance - 10000 where acc_no = '101-11-1001';

update account set acc_balance = acc_balance + 10000 where acc_no = '101-11-1003';

select * from account;

set autocommit off;

