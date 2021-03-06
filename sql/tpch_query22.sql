select
	cntrycode,
	count(1) as numcust,
	sum(c_acctbal) as totacctbal
from (
	select cntrycode, c_acctbal, avg_acctbal from
	(select avg(c_acctbal)as avg_acctbal from customer c where c_acctbal > 0.00 and substr(c_phone, 1, 2) IN ('13', '31', '23', '29', '30', '18', '17')) as ct1
	cross join (
			select cntrycode, c_acctbal from (select o_custkey from orders o group by o_custkey) ot
			right outer join (select c_acctbal, c_custkey, substr(c_phone, 1, 2) as cntrycode from customer c where substr(c_phone, 1, 2) IN ('13', '31', '23', '29', '30', '18', '17')) ct
			on ct.c_custkey = ot.o_custkey
			where ot.o_custkey is null
	) as ct2
	where c_acctbal > avg_acctbal
)a
group by
	cntrycode
order by
	cntrycode;
