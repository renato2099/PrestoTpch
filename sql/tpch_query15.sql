select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier s,
	(select
		l_suppkey as supplier_no,
		sum(l_extendedprice * (1 - l_discount)) as total_revenue
	from
		lineitem l
	where
		l_shipdate >= date '1996-01-01'
		and l_shipdate < date '1996-04-01'
	group by l_suppkey)revenue_cached,
	(select
		max(total_revenue) as max_revenue
	from
		(select
		l_suppkey as supplier_no,
		sum(l_extendedprice * (1 - l_discount)) as total_revenue
	from
		lineitem l
	where
		l_shipdate >= date '1996-01-01'
		and l_shipdate < date '1996-04-01'
	group by l_suppkey))max_revenue_cached
where
	s_suppkey = supplier_no
	and total_revenue = max_revenue 
order by s_suppkey
