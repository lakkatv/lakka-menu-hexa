tween = require 'tween'

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function love.load()
	lg = love.graphics
	lg.setNewFont("font.ttf", 24)
	lg.setBackgroundColor(237, 222, 217)
	lg.setLineWidth(6)
	love.graphics.setLineStyle("smooth")

	red = {{241,142,162}, {250, 92, 110}}
	cyan = {{113,186,206}, {42, 138, 173}}
	purple = {{220, 145, 179}, {182, 87, 132}}
	blue = {{126,145,162}, {45, 73, 120}}
	orange = {{246,176,132}, {255, 135, 64}}

	X = 0
	Y = 0
	t1 = 0

	global = { x = 0 }
	reflect = { x = 0 }
	panel = { x = 0, color = {255, 255, 255} }
	W = 25

	timeformat = "%H:%M"

	arrow = lg.newImage("arrow.png")

	cores = {
		{
			name = "Settings",
			icon = lg.newImage("icons/settings.png"),
			color = purple,
		},
		{
			name = "PlayStation",
			icon = lg.newImage("icons/PlayStation.png"),
			color = red,
		},
		{
			name = "Game Boy Game Boy Color",
			icon = lg.newImage("icons/Game Boy Game Boy Color.png"),
			color = cyan,
		},
		{
			name = "PC-FX",
			icon = lg.newImage("icons/PC-FX.png"),
			color = red,
		},
		{
			name = "Super Nintendo Entertainment System",
			icon = lg.newImage("icons/Super Nintendo Entertainment System.png"),
			color = red,
		},
		{
			name = "Sega 8 16bit (Various)",
			icon = lg.newImage("icons/Sega 8 16bit (Various).png"),
			color = blue,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Sega 8 16bit (Various)",
			icon = lg.newImage("icons/Sega 8 16bit (Various).png"),
			color = blue,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Sega 8 16bit (Various)",
			icon = lg.newImage("icons/Sega 8 16bit (Various).png"),
			color = blue,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
		{
			name = "Arcade (various)",
			icon = lg.newImage("icons/Arcade (various).png"),
			color = orange,
		},
	}

	pitch = math.round(#cores/2)
	print(pitch)
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

	if love.keyboard.isDown("right") and love.timer.getTime() > t1 + 0.25 then
		t1 = love.timer.getTime()
		X = X + 1
		if X > 2 and X < pitch - 2 then
			tween(0.2, global,  { x = global.x - 195 }, 'outSine')
			tween(0.2, reflect, { x = reflect.x - 100 }, 'outSine')
		end
	end

	if love.keyboard.isDown("left") and love.timer.getTime() > t1 + 0.25 then
		t1 = love.timer.getTime()
		X = X - 1
		if X > 1 and X < pitch - 3 then
			tween(0.2, global,  { x = global.x + 195 }, 'outSine')
			tween(0.2, reflect, { x = reflect.x + 100 }, 'outSine')
		end
	end

	if love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.25 then
		t1 = love.timer.getTime()
		Y = Y + 1
	end

	if love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.25 then
		t1 = love.timer.getTime()
		Y = Y - 1
	end

	if X < 0 then
		X = pitch-1
		tween(0.2, global,  { x = -(pitch-5)*195 }, 'outSine')
		tween(0.2, reflect, { x = -(pitch-5)*100 }, 'outSine')
	end
	if Y < 0 then
		Y = 1
	end
	if Y > 1 then
		Y = 0
	end
	if X >= pitch or Y*pitch+X >= #cores then
		X = 0
		tween(0.2, global,  { x = 0 }, 'outSine')
		tween(0.2, reflect, { x = 0 }, 'outSine')
	end

end

function draw_hexa(x, y, color, icon, active, empty)

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

	lg.draw(icon, x, y, 0, 0.5, 0.5, 124, 124)
end

function is_even(i)
	return i % 2 == 0
end

function love.draw()
	lg.setColor(255, 255, 255, 255*0.2)
	lg.polygon('fill',
		300+reflect.x, 0,
		350+reflect.x, 0,
		150+reflect.x, 900,
		100+reflect.x, 900)
	lg.polygon('fill',
		400+reflect.x, 0,
		500+reflect.x, 0,
		300+reflect.x, 900,
		200+reflect.x, 900)
	lg.polygon('fill',
		 800+reflect.x, 0,
		1100+reflect.x, 0,
		 900+reflect.x, 900,
		 600+reflect.x, 900)
	lg.polygon('fill',
		1150+reflect.x, 0,
		1250+reflect.x, 0,
		1050+reflect.x, 900,
		 950+reflect.x, 900)
	lg.polygon('fill',
		1650+reflect.x, 0,
		1700+reflect.x, 0,
		1500+reflect.x, 900,
		1450+reflect.x, 900)

	for y=0,1 do
		for x=0,30 do

			local offset = 0
			if is_even(x) then
				offset = 110
			end
			draw_hexa(
				260 + x*195 + global.x,
				y*220 + lg.getHeight()/2 + offset - 180,
				{0, 0, 0},
				nil,
				0, true
			)
		end
	end

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
					260 + x*195 + global.x,
					y*220 + lg.getHeight()/2 + offset - 180,
					core.color,
					core.icon,
					0
				)
			end
		end
	end

	local i = Y*pitch + X + 1
	local core = cores[i]
	local offset = 0
	if is_even(X) then
		offset = 110
	end
	draw_hexa(
		260 + X*195 + global.x,
		Y*220 + lg.getHeight()/2 + offset - 180,
		core.color,
		core.icon,
		1
	)

	lg.setColor(panel.color)
	lg.rectangle('fill', lg.getWidth() + panel.x, 0, 400, lg.getHeight())

	lg.setColor(255, 255, 255)
	lg.rectangle('fill', 0, lg.getHeight()-40, lg.getWidth(), 40)
	lg.setColor(128, 128, 128)
	lg.print("Lakka", 110, lg.getHeight()-37)
	lg.setColor(255, 255, 255)
	lg.draw(arrow, 203, lg.getHeight()-40)
	lg.setColor(core.color[2])
	lg.print(core.name, 250, lg.getHeight()-37)
	lg.setColor(128, 128, 128)

	lg.printf(os.date(timeformat, os.time()), 0, lg.getHeight()-37, 1440-110, 'right')
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == " " then
		local i = Y*pitch + X + 1
		local core = cores[i]
		tween(0.2, panel, { x = - 400 }, 'outSine')
		panel.color = core.color[2]
	end
end