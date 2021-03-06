select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem l
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1' year
	and l_discount between 0.05 and 0.07
	and l_quantity < 24
