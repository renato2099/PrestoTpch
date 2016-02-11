select
	o_orderpriority,
	count(*) as order_count
from
	orders as o,
    lineitem l
where
	o_orderdate >= date '1996-05-01'
	and o_orderdate < date '1996-08-01'
	and l_orderkey = o_orderkey
	and l_commitdate < l_receiptdate
group by
	o_orderpriority
order by
	o_orderpriority
