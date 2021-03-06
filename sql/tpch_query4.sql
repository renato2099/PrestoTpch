select
	o_orderpriority,
	count(*) as order_count
from
(
select 	o_orderpriority, o_orderkey

from	orders as o,
        lineitem l
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate <  date '1993-07-01' + interval '3' month
	and l_orderkey = o_orderkey
	and l_commitdate < l_receiptdate
group by
	o_orderpriority, o_orderkey
) as tmp

group by
	o_orderpriority
order by
	o_orderpriority
