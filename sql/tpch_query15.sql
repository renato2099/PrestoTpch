select
	s.suppkey,
	s.name,
	s.address,
	s.phone,
	total_revenue
from
	supplier s,
	(select
		l.suppkey as supplier_no,
		sum(l.extendedprice * (1 - l.discount)) as total_revenue
	from
		lineitem l
	where
		l.shipdate >= date '1996-01-01'
		and l.shipdate < date '1996-04-01'
	group by l.suppkey)revenue_cached,
	(select
		max(total_revenue) as max_revenue
	from
		(select
		l.suppkey as supplier_no,
		sum(l.extendedprice * (1 - l.discount)) as total_revenue
	from
		lineitem l
	where
		l.shipdate >= date '1996-01-01'
		and l.shipdate < date '1996-04-01'
	group by l.suppkey))max_revenue_cached
where
	s.suppkey = supplier_no
	and total_revenue = max_revenue 
order by s.suppkey
