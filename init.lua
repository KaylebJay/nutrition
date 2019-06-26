-- Init and registration
hb.register_hudbar("nutrition",0xFFFFFF,"Nutrition",,12,12,false)

-- Init hudbar for new users
minetest.register_on_joinplayer(function(player)
hb.init_hudbar(player,"nutrition",12)
)

-- Chatcommand: take a break
minetest.register_chatcommand("break",{
  params="",
  description="Take a break and continue working",
  func=function(name,param)
    if not mineest.get_player_by_name(name) then return end
    minetest.show_formspec(minetest.get_player_by_name(name),"nutrition:breakform",nutrition.breakform)
  end,
})

-- Privilege
minetest.register_privilege("nobreak","Can survive without taking a break")

-- A simple formspec that makes users click to take a "break"
nutrition.breakform = "size[4,3]button_exit[1,1;2,1;exit;Take a break]"
