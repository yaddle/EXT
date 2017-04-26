local lolVersion = "7.8"
local scrVersion = "0.3.18"

local scrName = "F**k you Shaco!"

local shacoEnabled = false
local friendlyMode = false
local timer = 0
local drawing = false
local shacoHero = -1
local shacoObj

local menuIcon = "http://i.imgur.com/M6jflXG.png"

local PMenu = MenuElement({type = MENU, id = "PMenu", name = "F**k you Shaco | Beta", leftIcon = menuIcon})
PMenu:MenuElement({id = "Enabled", name = "Enabled", value = true})

PMenu:MenuElement({type = MENU, id = "Drawing", name = "Drawing"})
PMenu.Drawing:MenuElement({id = "Enemy", name = "Draw Enemy Shaco", value = true, tooltip = "Draw for Enemy Shaco(s)"})
PMenu.Drawing:MenuElement({id = "Friendly", name = "Draw Friend Shaco", value = false, tooltip = "Draw for Friendy Shaco(s)"})
PMenu.Drawing:MenuElement({id = "Always", name = "Always Draw", value = false, tooltip = "Always draw the Shaco (true) \nOR only draw during Shaco Ult (flase)"})
--PMenu.Drawing:MenuElement({id = "Shape", name = "Draw Style", value = 1, drop = {"Box", "Circle"}, tooltip = "The Shape Drawn Over Shaco"})

function OnLoad()
	local scrNameVar = scrName.." "..scrVersion
	shacoEnabled = false
	for i=1,Game.HeroCount(),1 do
		--print(Game.Hero(i).charName)
		if Game.Hero(i).charName == "Shaco" then
			shacoEnabled = true
			shacoHero = i
			shacoObj = Game.Hero(i)
		end
	end
	if shacoEnabled then
		if Game.Hero(shacoHero).isEnemy then
			print(scrNameVar.." | Enemy Shaco Found")
		else
			print(scrNameVar.." | Friend Shaco Found")
			--print("Friendly Mode Enabled")
			friendlyMode = true;
		end
	else
		print(scrNameVar.." | No Shaco")
	end 
end

function OnTick()
	if not shacoEnabled then return end
	if not PMenu.Enabled:Value() then return end
	print(TimeSinceShacoR())
end

function OnDraw()
	if not shacoEnabled then return end
	if not PMenu.Enabled:Value() then return end
	local hero2D = shacoObj.pos:To2D()
	if friendlyMode then
		if PMenu.Drawing.Friendly:Value() then
			if (TimeSinceShacoR() < 10 and TimeSinceShacoR() >= 0) or Menu.Drawing.Always:Value() then
				Draw.Rect(hero2D.x - 75, hero2D.y - 140, 150, 200, Draw.Color(100,0,255,0))
			end
		else

		end
	else
		if (TimeSinceShacoR() < 10 and TimeSinceShacoR() >= 0) or PMenu.Drawing.Always:Value() then
			Draw.Rect(hero2D.x - 75, hero2D.y - 140, 150, 200, Draw.Color(100,0,255,0))
		end
	end
end

function TimeSinceShacoR()
	return Game.Timer() - shacoObj:GetSpellData(3).castTime
end