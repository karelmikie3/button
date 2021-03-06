local buttonTable = {}

function createButtons()
 return buttonTable
end

function addButton(bt,name,x,y,w,h,state,v,ca,cia)
 if state == nil then
  state = false
 end
 local tbt = {
 ["state"] = state,
 ["name"] = name,
 ["visi"] = v,
 ["bx"] = x,
 ["bw"] = w,
 ["by"] = y,
 ["bh"] = h,
 ["coloractive"] = ca,
 ["colorinactive"] = cia,
 }
 table.insert(bt, tbt)
 return bt
end

function buttonEvent(bt)
 if term.isColor() then
  for i in ipairs(bt) do
   if bt[i]["visi"] then
    if bt[i]["state"] == true then
     if bt[i]["coloractive"] then 
 	  color = bt[i]["coloractive"]
 	 else
 	  color = colors.lime
     end
    else 
     if bt[i]["coloractive"] then
	  color = bt[i]["colorinactive"]
	 else
      color = colors.red
	 end
    end
    local x,y = bt[i]["bx"],bt[i]["by"]
    local w,h = bt[i]["bw"]-1,bt[i]["bh"]-1
    for xpos = x,(x+w) do
     for ypos = y,(y+h) do
      paintutils.drawPixel(xpos,ypos,color)
     end
     term.setCursorPos((x+(w/2+1))-#bt[i]["name"]/2,(y+(h/2)))
     print(bt[i]["name"])
    end
    term.setBackgroundColor(colors.black)
   end
  end
 else
  error("screen is not color",0)
 end
 
 while true do
  event,mbutton,x,y = os.pullEvent("mouse_click")
  
  for i = 1, #bt do
   if bt[i]["visi"] then
    if x >= bt[i]["bx"] and x <= bt[i]["bx"] + bt[i]["bw"]-1 then
     if y >= bt[i]["by"] and y <= bt[i]["by"] + bt[i]["bh"]-1 then
       return bt[i]["name"], bt[i]["state"]
     end 
    end
   end
  end
 end
end
