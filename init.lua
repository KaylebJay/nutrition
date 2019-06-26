-- Init and registration
hb.register_hudbar("tiredness",0xFFFFFF,"Tiredness",12,12,false)

-- Init hudbar for new users
minetest.register_on_joinplayer(function(player)
hb.init_hudbar(player,"tiredness",12)

-- Chatcommand: take a break
minetest.register_chatcommand("break",{
  params="",
  description="Take a break and continue working",
  func=function(name,param)
    if not mineest.get_player_by_name(name) then return end
    nutrition.breakform(minetest.get_player_by_name(name))
  end,
})

-- Privilege
minetest.register_privilege("health_bypass","Can always survive without health problems.")

-- A simple formspec that makes users click to take a "break"
nutrition.breakform = function(player)
  minetest.show_formspec(player,"nutrition:breakform","size[3,3]button[0.5,0.5;2,1;break;Take a break]button_exit[0.5,1.5;2,1;exit;Done]")
  -- hb.change_hudbar(player,"tiredness",hb.get_hudbar_state(player,"tiredness").value+1)
end
minetest.register_on_player_receive_fields(function(player,formname,fields)
if formname=="nutrition:breakform" and fields["break"]==true then hb.change_hudbar(player,"tiredness",hb.get_hudbar_state(player,"tiredness").value+1) end
end

-- Counter: makes the user more tired by increasing "tiredness" every 10 mins (600s)
-- I don't know what the opposite of "tiredness" is. If you know, please tell me.
local timer=0
minetest.register_globalstep(function(dtime)
  timer = timer + dtime;
  if timer >= 600 then
  timer = 0
  for _,player in ipairs(minetest.get_connected_players()) do
    if not minetest.get_player_privs(player:get_player_name()).health_bypass then
      if not hb.get_hudbar_state(player,"tiredness").value==0 then hb.change_hudbar(player,"tiredness",hb.get_hudbar_state(player,"tiredness").value-1) end
      if hb.get_hudbar_state(player,"tiredness").value==0 then nutrition.breakform(player) end
    end
  end
  end
end
