set serveroutput on
declare
    V_KNA child.knownas%type := '&ChildNickName';
    V_RID room.roomid%type := '&RoomType';
    V_KNOWNASINT integer;
    V_ROOMINT integer;
begin
    select count(*) into V_KNOWNASINT from child where knownas = V_KNA;
    select count(*) into V_ROOMINT from room where roomid = V_RID;
    if(V_KNOWNASINT = 1) then
        dbms_output.put_line('yes, the child ' || V_KNA || ' is in our creche');
    else
        dbms_output.put_line('no, the child ' || V_KNA || ' is not in our creche');
    end if;
    if(V_ROOMINT = 1) then
        dbms_output.put_line('yes, we have the room ' || V_RID );
    else
        dbms_output.put_line('no, we don''t have the room ' || V_RID );
    end if;
    if(V_KNOWNASINT = 1 and V_ROOMINT = 1) then
        update child set room_roomid = V_RID where knownas = V_KNA;
        dbms_output.put_line('the child ' || V_KNA || ' has move to the ' || V_RID || ' room');
    else
        dbms_output.put_line('can''t move the child ' || V_KNA || ' to the ' || V_RID || ' room');
    end if;
end;