tween = require 'tween'

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function is_even(i)
	return i % 2 == 0
end

function love.load()
	lg = love.graphics
	font = lg.setNewFont("font.ttf", 24)
	lg.setBackgroundColor(237, 222, 217)
	lg.setLineWidth(6)
	love.graphics.setLineStyle("smooth")
	beep = love.audio.newSource("switch.wav", static)
	beep:setVolume(0.1)
	backgroundMusic = love.audio.newSource("bgmusic.wav", static)
	love.audio.play(backgroundMusic)
	backgroundMusic:setLooping(true)

	red = {{241,142,162}, {250, 92, 110}}
	cyan = {{113,186,206}, {42, 138, 173}}
	purple = {{220, 145, 179}, {182, 87, 132}}
	blue = {{126,145,162}, {45, 73, 120}}
	orange = {{246,176,132}, {255, 135, 64}}
	grey = {{160, 160, 160}, {80, 80, 80}}

	X = 0
	Y = 0
	Y_content = 0
	t1 = 0

	hexaNavAuthorised = true
	itemnav = false

	global = { x = 0 }
	global2 = { x = 0 }
	reflect = { x = 0 }
	panel = { x = 0, color = {255, 255, 255} }	
	shadow = { x = 0, color = {0, 0, 0, 0.2*255} }
	W = 25

	timeformat = "%H:%M"

	arrow = lg.newImage("arrow.png")
	clock = lg.newImage("clock.png")

	cores = {
		{
			name = "Settings",
			core_icon = lg.newImage("icons/Settings.png"),
			content_icon = lg.newImage("icons/Settings-content.png"),
			color = grey,
			items = {
				{ 	name = "Set",
					active = true },
				{ 	name = "Final Fantasy VII" },
				{ 	name = "Xenogears" },
				{ 	name = "Suikoden 2" },
				{ 	name = "Suikoden 2" },
			},
		},
		{
			name = "PlayStation",
			core_icon = lg.newImage("icons/PlayStation.png"),
			content_icon = lg.newImage("icons/PlayStation-content.png"),
			color = red,
			items = {
				{ 	name = "Crash Bandicoot",
					active = true },
				{ 	name = "Final Fantasy VII" },
				{ 	name = "Xenogears" },
				{ 	name = "Suikoden 2" },
				{ 	name = "Suikoden 2" },
			},
		},
		{
			name = "Game Boy Color",
			core_icon = lg.newImage("icons/Game Boy Color.png"),
			content_icon = lg.newImage("icons/Game Boy Color-content.png"),
			color = cyan,
			items = {
				{ 	name = "Pokemon Or",
					active = true },
				{ 	name = "New Super Mario Bros" },
			},
		},
		{
			name = "PC-FX",
			core_icon = lg.newImage("icons/PC-FX.png"),
			content_icon = lg.newImage("icons/PC-FX-content.png"),
			color = red,
			items = {
				{ 	name = "Cutie Honey FX", 
					active = true },
				{ 	name = "Tenchi Muyo! Ryo-Ohki FX" },
			},
		},
		{
			name = "Super NES",
			core_icon = lg.newImage("icons/Super NES.png"),
			content_icon = lg.newImage("icons/Super NES-content.png"),
			color = red,
			items = {
				{ 	name = "Super Bomberman", 
					active = true },
				{ 	name = "Secret of Mana" },
				{ 	name = "Super Metroid" },
				{ 	name = "The Legend of Zelda" },
				{ 	name = "Tactics Ogre" },
			},
		},
		{
			name = "Master System",
			core_icon = lg.newImage("icons/Master System.png"),
			content_icon = lg.newImage("icons/Master System-content.png"),
			color = blue,
			items = {
				{ 	name = "Sonic Chaos", 
					active = true },
				{ 	name = "Zool" },
				{ 	name = "Wonderboy 3" },
				{ 	name = "Alex kid" },
			},
		},
		{
			name = "Arcade (various)",
			core_icon = lg.newImage("icons/Arcade (various).png"),
			content_icon = lg.newImage("icons/Arcade (various)-content.png"),
			color = orange,
			items = {
				{ 	name = "Space Invaders", 
					active = true },
				{ 	name = "Ms. Pac Man" },
			},
		},
		{
			name = "Game Boy Advance",
			core_icon = lg.newImage("icons/Game Boy Advance.png"),
			content_icon = lg.newImage("icons/Game Boy Advance-content.png"),
			color = cyan,
			items = {
				{ 	name = "Final Fantasy Tactics Advance", 
					active = true },
			},
		},
		{
			name = "Megadrive",
			core_icon = lg.newImage("icons/Megadrive.png"),
			content_icon = lg.newImage("icons/Megadrive-content.png"),
			color = red,
			items = {
				{ 	name = "Sonic 2", 
					active = true },
				{ 	name = "Sonic 3" },
				{ 	name = "Gunstar Heroes" },
				{ 	name = "Piersolar" },
			},
		},
		{
			name = "Virtual Boy",
			core_icon = lg.newImage("icons/Virtual Boy.png"),
			content_icon = lg.newImage("icons/Virtual Boy-content.png"),
			color = blue,
			items = {
				{ 	name = "3D Tetris", 
					active = true },
				{ 	name = "Virtual Boy Wario Land" },
			},
		},
		{
			name = "Saturn",
			core_icon = lg.newImage("icons/Saturn.png"),
			content_icon = lg.newImage("icons/Saturn-content.png"),
			color = red,
			items = {
				{ 	name = "Daytona", 
					active = true },
				{ 	name = "Virtua Fighter" },
			},
		},
		{
			name = "Quake",
			core_icon = lg.newImage("icons/Quake.png"),
			content_icon = lg.newImage("icons/Quake-content.png"),
			color = orange,
			items = {
				{ 	name = "Quake", 
					active = true },
				{ 	name = "Hexen II" },
			},
		},
		{
			name = "PSP",
			core_icon = lg.newImage("icons/PSP.png"),
			content_icon = lg.newImage("icons/PSP-content.png"),
			color = cyan,
			items = {
				{ 	name = "Metal Gear Solid : Peace Walker", 
					active = true },
				{ 	name = "Kingdom Hearts : Birth By Sleep" },
			},
		},
		{
			name = "SG-1000",
			core_icon = lg.newImage("icons/SG-1000.png"),
			content_icon = lg.newImage("icons/SG-1000-content.png"),
			color = blue,
			items = {
				{ 	name = "GP World", 
					active = true },
				{ 	name = "Sökoban" },
			},
		},
		{
			name = "Nintendo DS",
			core_icon = lg.newImage("icons/Nintendo DS.png"),
			content_icon = lg.newImage("icons/Nintendo DS-content.png"),
			color = cyan,
			items = {
				{ 	name = "New Super Mario Bros.", 
					active = true },
				{ 	name = "Mario Kart DS" },
			},
		},
		{
			name = "NES",
			core_icon = lg.newImage("icons/NES.png"),
			content_icon = lg.newImage("icons/NES-content.png"),
			color = blue,
			items = {
				{ 	name = "Mario Bros.", 
					active = true },
				{ 	name = "Final Fantasy 3" },
				{ 	name = "Mario Bros." },
			},
		},
		{
			name = "Odyssey 2",
			core_icon = lg.newImage("icons/Odyssey 2.png"),
			content_icon = lg.newImage("icons/Odyssey 2-content.png"),
			color = orange,
			items = {
				{ 	name = "Tennis", 
					active = true },
				{ 	name = "Ski" },
			},
		},
		{
			name = "Jaguar",
			core_icon = lg.newImage("icons/Jaguar.png"),
			content_icon = lg.newImage("icons/Jaguar-content.png"),
			color = red,
			items = {
				{ 	name = "Alien vs Predator", 
					active = true },
				{ 	name = "Atari Kart" },
			},
		},
		{
			name = "Neo Geo Pocket (Color)",
			core_icon = lg.newImage("icons/Neo Geo Pocket (Color).png"),
			content_icon = lg.newImage("icons/Neo Geo Pocket (Color)-content.png"),
			color = cyan,
			items = {
				{ 	name = "Sonic Pocket Adventure", 
					active = true },
				{ 	name = "Pocket Tennis" },
			},
		},
		{
			name = "Atari 7800",
			core_icon = lg.newImage("icons/Atari 7800.png"),
			content_icon = lg.newImage("icons/Atari 7800-content.png"),
			color = blue,
			items = {
				{ 	name = "Fatal Run", 
					active = true },
				{ 	name = "Double Dragon" },
			},
		},
		{
			name = "Neo Geo",
			core_icon = lg.newImage("icons/Neo Geo.png"),
			content_icon = lg.newImage("icons/Neo Geo-content.png"),
			color = red,
			items = {
				{ 	name = "Metal Slug", 
					active = true },
				{ 	name = "Metal Slug 2" },
				{ 	name = "Metal Slug 3" },
				{ 	name = "Metal Slug 4" },
				{ 	name = "Metal Slug 5" },
				{ 	name = "Metal Slug X" },
				{ 	name = "Bomberman" },
			},
		},
		{
			name = "Amiga",
			core_icon = lg.newImage("icons/Amiga.png"),
			content_icon = lg.newImage("icons/Amiga-content.png"),
			color = orange,
			items = {
				{ 	name = "Agony", 
					active = true },
				{ 	name = "Dungeon Master" },
				{ 	name = "Dungeon Master 2" },
			},
		},
	}

	pitch = math.round(#cores/2)

end

function love.update(dt)
	tween.update(dt)
	time = love.timer.getTime()
	if is_even(math.floor(time*2)) then
		timeformat = "%H %M"
	else
		timeformat = "%H:%M"
	end
	W = 25 + math.cos(time*4) * 5

	if hexaNavAuthorised then

		Y_content = 0

		if love.keyboard.isDown("right") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			X = X + 1
			if X > 2 and X < pitch - 2 then
				tween(0.2, global,  { x = global.x - 195 }, 'outSine')
				tween(0.2, reflect, { x = reflect.x - 100 }, 'outSine')
			end
		end

		if love.keyboard.isDown("left") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			X = X - 1
			if X > 1 and X < pitch - 3 then
				tween(0.2, global,  { x = global.x + 195 }, 'outSine')
				tween(0.2, reflect, { x = reflect.x + 100 }, 'outSine')
			end
		end

		if love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			Y = Y + 1
		end

		if love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			Y = Y - 1
		end

		if X < 0 then
			love.audio.play(beep)
			X = pitch-1
			tween(0.2, global,  { x = -(pitch-5)*195 }, 'outSine')
			tween(0.2, reflect, { x = -(pitch-5)*100 }, 'outSine')
		end
		if Y < 0 then
			love.audio.play(beep)
			Y = 1
		end
		if Y > 1 then
			love.audio.play(beep)
			Y = 0
		end
		if X >= pitch or Y*pitch+X >= #cores then
			love.audio.play(beep)
			X = 0
			tween(0.2, global,  { x = 0 }, 'outSine')
			tween(0.2, reflect, { x = 0 }, 'outSine')
		end
	else
		if love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			Y_content = Y_content + 1
		end
		if love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.25 then
			love.audio.play(beep)
			t1 = love.timer.getTime()
			Y_content = Y_content - 1
		end
		if Y_content > #item - 1 then
			Y_content = 0
		end
		if Y_content < 0 then
			Y_content = #item - 1
		end
	end

end

function draw_hexa(x, y, core_icon, color, active, empty)

	local coords = {
		  65+x, -110+y,
		 130+x,    0+y,
		  65+x,  110+y,
		 -65+x,  110+y,
		-130+x,    0+y,
		 -65+x, -110+y
	}

	if empty == true then
		lg.setColor(246, 234, 232)
		lg.polygon('line', coords)
		return
	end

	if active == 1 then
		lg.setLineWidth(W)
		lg.setColor(0, 0, 0, 255*0.2)
		lg.polygon('line', coords)
		lg.setLineWidth(6)
	end

	lg.setColor(color[active+1])

	lg.polygon('fill', coords)

	lg.setColor(255, 255, 255)
	lg.polygon('line', coords)

	lg.draw(core_icon, x, y, 0, 0.5, 0.5, 124, 124)
end

function love.draw()

	-- Dessin des reflets en background

	lg.setColor(255, 255, 255, 255*0.2)

	for i=0,1 do
		lg.polygon('fill',
			524+reflect.x + global2.x /2 +i*1793, 0,
			595+reflect.x + global2.x /2 +i*1793, 0,
			145+reflect.x + global2.x /2 +i*1793, 1080,
			 74+reflect.x + global2.x /2 +i*1793, 1080)
		lg.polygon('fill',
			668+reflect.x + global2.x /2 +i*1793, 0,
			833+reflect.x + global2.x /2 +i*1793, 0,
		   	383+reflect.x + global2.x /2 +i*1793, 1080,
			218+reflect.x + global2.x /2 +i*1793, 1080)
		lg.polygon('fill',
		   1204+reflect.x + global2.x /2 +i*1793, 0,
		   1522+reflect.x + global2.x /2 +i*1793, 0,
		   1072+reflect.x + global2.x /2 +i*1793, 1080,
			754+reflect.x + global2.x /2 +i*1793, 1080)
		lg.polygon('fill',
		   1603+reflect.x + global2.x /2 +i*1793, 0,
		   1731+reflect.x + global2.x /2 +i*1793, 0,
		   1281+reflect.x + global2.x /2 +i*1793, 1080,
		   1153+reflect.x + global2.x /2 +i*1793, 1080)
	end


	-- Dessin des hexagones de fond

	for y=0,1 do
		for x=0,30 do

			local offset = 0
			if is_even(x) then
				offset = 110
			end
			draw_hexa(
				234 + x*195 + global.x + global2.x,
				-y*220 + lg.getHeight()/2 + offset + 31,
				nil,
				{0, 0, 0},
				0, true
			)
		end
	end


	-- Dessin des hexagones des cores

	for y=0,1 do
		for x=0,pitch-1 do
			local i = y*pitch + x + 1
			local core = cores[i]
			if core then
				local offset = 0
				if is_even(x) then
					offset = 110
				end
				draw_hexa(
					234 + x*195 + global.x + global2.x,
					-y*220 + lg.getHeight()/2 + offset + 31,
					core.core_icon,
					core.color,
					0
				)
			end
		end
	end

	-- Dessin de l'hexagone en surbrillance

	local i = Y*pitch + X + 1
	local core = cores[i]
	local offset = 0

	if is_even(X) then
		offset = 110
	end

	draw_hexa(
		234 + X*195 + global.x + global2.x,
		-Y*220 + lg.getHeight()/2 + offset + 31,
		core.core_icon,
		core.color,
		1
	)


	-- Dessin du footer

	lg.setColor(255, 255, 255)
	lg.rectangle('fill', 0, lg.getHeight()-40, lg.getWidth(), 40)
	lg.setColor(128, 128, 128)
	lg.print("Lakka", 95, lg.getHeight()-37)

	lg.setColor(255, 255, 255)
	lg.draw(arrow, 185, lg.getHeight()-40)
	lg.setColor(core.color[2])
	lg.print(core.name, 231, lg.getHeight()-37)

	if itemnav then
		local text_width = font:getWidth(core.name)
		local item = core.items[Y_content + 1]

		lg.setColor(255, 255, 255)
		lg.draw(arrow, 261 + text_width, lg.getHeight()-40)	
		lg.setColor(core.color[2])
		lg.print(item.name, 307 + text_width, lg.getHeight()-37)
	end

	lg.setColor(128, 128, 128)
	lg.printf(os.date(timeformat, os.time()), 0, lg.getHeight()-37, 1920-137, 'right')
	lg.setColor(255, 255, 255)
	lg.draw(clock, 1920-122, lg.getHeight()-33)


	-- Dessin de la sidebar

	lg.setColor(shadow.color)
	lg.rectangle('fill', lg.getWidth() + shadow.x, 0, 10, lg.getHeight())
	lg.setColor(panel.color)
	lg.rectangle('fill', lg.getWidth() + panel.x, 0, 450, lg.getHeight())
	lg.setColor(242, 242, 242)
	lg.rectangle('fill', lg.getWidth() + panel.x, 0, 2, lg.getHeight())

	lg.setColor(255, 255, 255, 255*0.1)

	-- Dessin des reflets

	lg.polygon('fill',
		1557 + 450 + panel.x, 0,
		1577 + 450 + panel.x, 0,
		1472 + 450 + panel.x, 252,
		1472 + 450 + panel.x, 204)

	lg.polygon('fill',
		1598 + 450 + panel.x, 0,
		1658 + 450 + panel.x, 0,
		1472 + 450 + panel.x, 446,
		1472 + 450 + panel.x, 301)

	lg.polygon('fill',
		1920 + 450 + panel.x, 377,
		1920 + 450 + panel.x, 551,
		1697 + 450 + panel.x, 1080,
		1626 + 450 + panel.x, 1080)

	lg.polygon('fill',
		1920 + 450 + panel.x, 619,
		1920 + 450 + panel.x, 692,
		1757 + 450 + panel.x, 1080,
		1727 + 450 + panel.x, 1080)


	lg.setColor(255, 255, 255)

	-- Dessin du header de la sidebar

	lg.draw(core.content_icon, 1577 + 450 + panel.x, 148, 0, 0.5, 0.5, 124, 124)

	lg.setNewFont("font.ttf", 30)
	local width, lines = font:getWrap(core.name, 160)
	if lines == 1 then

		lg.printf(core.name, 1653 + 450 + panel.x, 124, 208, left)

	else

		lg.printf(core.name, 1653 + 450 + panel.x, 107, 208, left)		

	end
	lg.setNewFont("font.ttf", 24)

	lg.polygon('fill',
		1535 + 450 + panel.x, 245,
		1861 + 450 + panel.x, 245,
		1861 + 450 + panel.x, 247,
		1535 + 450 + panel.x, 247)

	-- Listing des ROMs

	item = core.items

	for i=0, #item - 1 do
		local subitem = item[i + 1]

		if i == Y_content then
			subitem.active = true
		else
			subitem.active = false
		end

		if subitem.active then
			lg.setColor(255, 255, 255)
		else
			lg.setColor(255, 255, 255, 0.5*255)
		end
		lg.print(subitem.name, 1535 + 450 + panel.x, 298 + i*48)
		lg.setColor(255, 255, 255)
	end

	lg.polygon('fill',
		1535 + 450 + panel.x, 245 + 2 * 48 + #item * 48,
		1861 + 450 + panel.x, 245 + 2 * 48 + #item * 48,
		1861 + 450 + panel.x, 247 + 2 * 48 + #item * 48,
		1535 + 450 + panel.x, 247 + 2 * 48 + #item * 48)
end



function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == "x" then
		local i = Y*pitch + X + 1
		local core = cores[i]
		itemnav = true
		if core.name ~= "Settings" then
			hexaNavAuthorised = false
			tween(0.1, panel, { x = - 450 }, 'outSine')
			tween(0.1, shadow, { x = - 460 }, 'outSine')
			tween(0.1, global2, { x = - 70 }, 'outSine')
			panel.color = core.color[2]
		end
	end

	if key == "w" then
		hexaNavAuthorised = true
		itemnav = false
		tween(0.1, panel, { x = 0 }, 'outSine')
		tween(0.1, shadow, { x = 0 }, 'outSine')
		tween(0.1, global2, { x = 0 }, 'outSine')
	end
end
