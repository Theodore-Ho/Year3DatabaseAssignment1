/*  A-B
    childs not in the infant room*/
select childname from child
minus
select childname from child where room_roomid = 'infant1';

/*  A¡ÉB
    child name contains both "s" and "i"*/
select childname from child where childname like '%s%'
intersect
select childname from child where childname like '%i%';

/*  A¡ÈB
    child name contains "s" or "i"*/
select childname from child where childname like '%s%' or childname like '%i%';

/*  A XOR B
    child name contains "s" or "i" but not both*/
select childname from child where childname like '%s%' or childname like '%i%'
minus
select childname from child where childname like '%s%'
intersect
select childname from child where childname like '%i%';

/*  A - ?A
    name of child who has session staff "Donald Trump" cared only*/
select childname from child where childid in
(select child_childid from log where staff_staffid in
(select staffid from staff where staffname = 'Donald Trump'))
minus
select childname from child where childid in
(select child_childid from log where staff_staffid in
(select staffid from staff where staffname <> 'Donald Trump'));

/*  relational divide
    name of child who has all session staff cared with*/
select childname from child where not exists
(select * from staff where not exists 
(select * from log where log.staff_staffid = staff.staffid and log.child_childid = child.childid));

/*  inner join  */
select staffname,childname from staff inner join log
on staff.staffid = log.staff_staffid inner join child
on log.child_childid = child.childid order by staffname asc;

/*  left join  */
select staffname,childname from staff left join log
on staff.staffid = log.staff_staffid left join child
on log.child_childid = child.childid order by staffname asc;

/*  full join  */
select staffname,childname from staff full outer join log
on staff.staffid = log.staff_staffid full outer join child
on log.child_childid = child.childid order by staffname asc;

/*  aggregation include having
    count the amount of child in each room, display the rooms has child number > 1*/
select roomid, count(child.room_roomid) as nums
from room join child on child.room_roomid = room.roomid
group by roomid having count(child.room_roomid) > 1;

/*  sub-queries
    select child name who did the goals that allowed min age month > 5*/
select childname from child where room_roomid in
(select roomid from room where roomid in
(select room_roomid from room_goals where goal_goalid in
(select goalid from goal where goal_minage_months > 5)));