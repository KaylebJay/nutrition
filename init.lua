-- Init and registration
hb.register_hudbar("nutrition",0xFFFFFF,"Nutrition",,12,12,false)

-- Init hudbar for new users
minetest.register_on_joinplayer(function(player)
hb.init_hudbar(player,"nutrition",12)
)
