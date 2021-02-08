surface.CreateFont( "Trebuchet42", {
	font = "Trebuchet24",
	size = 42,
	weight = 500,
})

surface.CreateFont( "Trebuchet16", {
	font = "Trebuchet24",
	size = 16,
	weight = 500,
})

surface.CreateFont( "Trebuchet12", {
	font = "Trebuchet24",
	size = 12,
	weight = 500,
})

surface.CreateFont( "PointshopFont", {
	font = "Verdana",
	extended = true,
	size = 25,
} )

surface.CreateFont( "PointsPS2", {
	font = "Verdana",
	extended = true,
	size = 16,
} )

hook.Add( "HUDPaint", "DrawZHUD", function()
    
    local ply = LocalPlayer()
    
    surface.SetDrawColor( 50, 50, 50, 255 )
	surface.DrawRect( 10, ScrH()-160, 384, 150)
	
	surface.SetDrawColor( 150, 150, 150, 255 )
	surface.DrawRect( 10, ScrH()-160, 384, 30)
	
	draw.DrawText( ply:Name(),"Trebuchet24", 20, ScrH()-157, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT )
	draw.DrawText( ply:GetUserGroup(),"Trebuchet24", 380, ScrH()-157,team.GetColor( ply:Team() ), TEXT_ALIGN_RIGHT )
	
	local HealthColor = Color(0,0,0,255)
	local plyHealth = ply:Health()
	
	if plyHealth < 0 then
	    plyHealth = 0
	end
	
    if plyHealth > 100 then
	    plyHealth = 100
	end
	
	if plyHealth >= 70 then
	   HealthColor = Color(0,255,0,255)
	elseif plyHealth > 20 then
	   HealthColor = Color(255,255,0,255)
	elseif plyHealth <= 20 then
	   HealthColor = Color(255,0,0,255)
	end
	
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect( 17, ScrH()-123, 370, 28, 3)
	
	surface.SetDrawColor(HealthColor)
	surface.DrawRect( 20, ScrH()-120, plyHealth * 3.64, 22)
	draw.DrawText( "Health : "..ply:Health().."%" ,"Trebuchet24", 200, ScrH()-121, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	
	local plyArmor = ply:Armor()
	
	if plyArmor > 255 then
	    plyArmor = 100
	end
	
    surface.SetDrawColor(0 ,0, 0, 255)
	surface.DrawOutlinedRect( 17, ScrH()-90, 370, 28, 3)
	
	surface.SetDrawColor(0, 0, 225, 255)
	surface.DrawRect( 20, ScrH()-87, plyArmor * 3.64, 22)
	draw.DrawText( "Armor : "..ply:Armor().."%" ,"Trebuchet24", 200, ScrH()-88, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )
	
	-- Kills / Deaths counter
	
	draw.DrawText( "Kills : "..ply:Frags() ,"Trebuchet24", 25, ScrH()-50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	
	draw.DrawText( "Deaths : "..ply:Deaths() ,"Trebuchet24", 380, ScrH()-50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT )
	
	local k = ply:Frags()
	local d = ply:Deaths()
	local kdr = "--   "
	if d ~= 0 then
	   kdr = k / d
	   local y, z = math.modf( kdr )
	   z = string.sub( z, 1, 5 )
	   if y ~= 0 then kdr = string.sub( y + z, 1, 5 ) else kdr = z end
	   kdr = kdr .. ":1"
	   if k == 0 then kdr = k .. ":" .. d end
	end
	
	draw.DrawText( "Ratio : "..kdr ,"Trebuchet16", 200, ScrH()-45, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	
	draw.DrawText( "zHUD Version : v1.0" ,"Trebuchet12", 20, ScrH()-25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
	
	-- Pointshop2 counter
	
	if ply.PS2_Wallet then
	    surface.SetDrawColor(50, 50, 50, 255)
	    surface.DrawRect(0, 0, 350 ,70)
	
	    surface.SetDrawColor(150, 150, 150, 255)
	    surface.DrawRect(0, 0, 350, 30)
	
	    draw.DrawText("Pointshop", "PointshopFont", 150, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	    draw.DrawText("2", "PointshopFont", 205, 0, Color(255, 200, 0, 255), TEXT_ALIGN_CENTER)
	
	    draw.DrawText("Points : "..ply.PS2_Wallet.points, "PointsPS2", 10, 42, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	    draw.DrawText("Premium Points : "..ply.PS2_Wallet.premiumPoints, "PointsPS2", 170, 42, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	end
	
	-- Ammo HUD
	
	if IsValid(ply:GetActiveWeapon()) then
	    if ( ply:GetActiveWeapon():GetPrintName() != nil ) then
	        surface.SetDrawColor(Color(50, 50, 50, 255))
	        surface.DrawRect(ScrW()-210, ScrH()-120, 200, 110)
	    
	        surface.SetDrawColor(150, 150, 150, 255)
	        surface.DrawRect(ScrW()-210, ScrH()-120, 200, 30)
	        draw.DrawText( ply:GetActiveWeapon():GetPrintName(), "Trebuchet24", ScrW()-112, ScrH()-117, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER )
	    end
	    
	    if (ply:GetActiveWeapon():Clip1() != -1) then
	        draw.DrawText( ply:GetActiveWeapon():Clip1() .. " / " .. ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()), "Trebuchet42", ScrW()-112, ScrH()-77, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	    else
	        draw.DrawText( ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()), "Trebuchet42", ScrW()-112, ScrH()-77, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	    end
	end
	
	if(!ply:Alive()) then
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect( ScrW()/2.5, 75, 300,100)
        draw.DrawText("You are dead", "Trebuchet42", ScrW()/2, 100, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER)
    end
end)

-- Disable default HUD
hook.Add( "HUDShouldDraw", "HideDefaultHUD", function( name )
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if name == v then
            return false
        end
    end
end)