select
	cntrycode,
	count(1) as numcust,
	sum(acctbal) as totacctbal
from (
	select
		cntrycode,
		acctbal,
		avg_acctbal
	from
		(select
			avg(acctbal) as avg_acctbal
		from
			(select
					c.acctbal,
					c.custkey,
					substr(c.phone, 1, 2) as cntrycode
				from
					customer c
				where
					substr(c.phone, 1, 2) = '13' or
					substr(c.phone, 1, 2) = '31' or
					substr(c.phone, 1, 2) = '23' or
					substr(c.phone, 1, 2) = '29' or
					substr(c.phone, 1, 2) = '30' or
					substr(c.phone, 1, 2) = '18' or
					substr(c.phone, 1, 2) = '17')
		) ct1 
		cross join (
			select
				cntrycode,
				acctbal
			from
				(select o.custkey from orders o group by o.custkey) ot
			right outer join (select
									c.acctbal,
									c.custkey,
									substr(c.phone, 1, 2) as cntrycode
								from
									customer c
								where
									substr(c.phone, 1, 2) = '13' or
									substr(c.phone, 1, 2) = '31' or
									substr(c.phone, 1, 2) = '23' or
									substr(c.phone, 1, 2) = '29' or
									substr(c.phone, 1, 2) = '30' or
									substr(c.phone, 1, 2) = '18' or
									substr(c.phone, 1, 2) = '17') ct
			on ct.custkey = ot.custkey
			where
				ot.custkey is null
		) ct2
) a
where
	acctbal > avg_acctbal
group by
	cntrycode
order by
	cntrycode
