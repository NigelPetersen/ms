 with closed_orders_w_acc_info as (
    select 
        t1.openedOrderID, 
        t1.account, 
        position, 
        indexToken, 
        t1.maxSize, 
        cumNetPnl,
        cumNetPnl/t1.maxSize as profit_pct, 
        nRebalances, 
        t1.liquidated, 
        duration,
        nTrades,
        lossRatioPct,
        gainTrades,
        lossTrades,
        netPnL,
        avgCollateral,
        avgLever,
        avgSize,
        avgLossPct,
        avgProfitPct,
        maxLossPct,
        avgHold,
        avgRebalances,
        t2.liquidated as ever_liquidated
    from closed_orders as t1
    left join account_orders_events t2 on
    t1.openedOrderID = t2.openedOrderID
)
select
    count(*) as cnt,
    avg(nTrades) as NTr,
    avg(lossRatioPct) as LRP,
    avg(lossTrades) as lT,
    avg(gainTrades) as GT,
    avg(netPnl) as netPnl,
    avg(gainTrades/nTrades*100) as GTP,
    avg(avgCollateral) as col,
    avg(avgLever) as lev,
    avg(avgSize) as size,
    avg(avgLossPct) as avg_LPCT,
    avg(maxLossPct) as max_LPCT,
    avg(avgProfitPct) as ProfitPct,
    avg(avgHold) as avgHold,
    avg(avgRebalances) as avgReb,
    avg(liquidated) as liq
from closed_orders_w_acc_info
where profit_pct > 0.05;