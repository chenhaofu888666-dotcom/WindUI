--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // /  
    |__/|__/_/_//_/\_,_/\____/___/
    
    v1.6.57  |  2025-10-27  |  Roblox UI Library for scripts
    
    This script is NOT intended to be modified.
    To view the source code, see the `src/` folder on the official GitHub repository.
    
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()return{
Dialog="Accent",

Background="Accent",
Hover="Text",

WindowBackground="Background",

TopbarButtonIcon="Icon",
TopbarTitle="Text",
TopbarAuthor="Text",
TopbarIcon="Text",

TabBackground="Hover",
TabTitle="Text",
TabIcon="Icon",

ElementBackground="Text",
ElementTitle="Text",
ElementDesc="Text",
ElementIcon="Icon",
}end function a.b()
local b=game:GetService"RunService"local d=
b.Heartbeat
local e=game:GetService"UserInputService"
local f=game:GetService"TweenService"
local g=game:GetService"LocalizationService"
local h=game:GetService"HttpService"

local i="https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local j=loadstring(
game.HttpGetAsync and game:HttpGetAsync(i)
or h:GetAsync(i)
)()
j.SetIconsType"lucide"

local l

local m={
Font="rbxassetid://12187365364",
Localization=nil,
CanDraggable=true,
Theme=nil,
Themes=nil,
Icons=j,
Signals={},
Objects={},
LocalizationObjects={},
FontObjects={},
Language=string.match(g.SystemLocaleId,"^[a-z]+"),
Request=http_request or(syn and syn.request)or request,
DefaultProperties={
ScreenGui={
ResetOnSpawn=false,
ZIndexBehavior="Sibling",
},
CanvasGroup={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
Frame={
BorderSizePixel=0,
BackgroundColor3=Color3.new(1,1,1),
},
TextLabel={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
RichText=true,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},TextButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Text="",
AutoButtonColor=false,
TextColor3=Color3.new(1,1,1),
TextSize=14,
},
TextBox={
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=Color3.new(0,0,0),
ClearTextOnFocus=false,
Text="",
TextColor3=Color3.new(0,0,0),
TextSize=14,
},
ImageLabel={
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
},
ImageButton={
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
AutoButtonColor=false,
},
UIListLayout={
SortOrder="LayoutOrder",
},
ScrollingFrame={
ScrollBarImageTransparency=1,
BorderSizePixel=0,
},
VideoFrame={
BorderSizePixel=0,
}
},
Colors={
Red="#e53935",
Orange="#f57c00",
Green="#43a047",
Blue="#039be5",
White="#ffffff",
Grey="#484848",
},
ThemeFallbacks=a.load'a'
}

function m.Init(p)
l=p
end

function m.AddSignal(p,r)
local u=p:Connect(r)
table.insert(m.Signals,u)
return u
end

function m.DisconnectAll()
for p,r in next,m.Signals do
local u=table.remove(m.Signals,p)
u:Disconnect()
end
end

function m.SafeCallback(p,...)
if not p then
return
end

local r,u=pcall(p,...)
if not r then
if l and l.Window and l.Window.Debug then local
v, x=u:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..u)

return l:Notify{
Title="DEBUG Mode: Error",
Content=not x and u or u:sub(x+1),
Duration=8,
}
end
end
end

function m.Gradient(p,r)
if l and l.Gradient then
return l:Gradient(p,r)
end

local u={}
local v={}

for x,z in next,p do
local A=tonumber(x)
if A then
A=math.clamp(A/100,0,1)
table.insert(u,ColorSequenceKeypoint.new(A,z.Color))
table.insert(v,NumberSequenceKeypoint.new(A,z.Transparency or 0))
end
end

table.sort(u,function(A,B)return A.Time<B.Time end)
table.sort(v,function(A,B)return A.Time<B.Time end)

if#u<2 then
error"ColorSequence requires at least 2 keypoints"
end

local A={
Color=ColorSequence.new(u),
Transparency=NumberSequence.new(v),
}

if r then
for B,C in pairs(r)do
A[B]=C
end
end

return A
end

function m.SetTheme(p)
m.Theme=p
m.UpdateTheme(nil,true)
end

function m.AddFontObject(p)
table.insert(m.FontObjects,p)
m.UpdateFont(m.Font)
end

function m.UpdateFont(p)
m.Font=p
for r,u in next,m.FontObjects do
u.FontFace=Font.new(p,u.FontFace.Weight,u.FontFace.Style)
end
end

function m.GetThemeProperty(p,r)
local function getValue(u,v)
local x=v[u]

if not x then return nil end

if type(x)=="string"and string.sub(x,1,1)=="#"then
return Color3.fromHex(x)
end

if typeof(x)=="Color3"then
return x
end

if type(x)=="table"and x.Color and x.Transparency then
return x
end

if type(x)=="function"then
return x()
end

return nil
end

local u=getValue(p,r)
if u then
return u
end

local v=m.ThemeFallbacks[p]
if v then
u=getValue(v,r)
if u then
return u
end
end

u=getValue(p,m.Themes.Dark)
if u then
return u
end

if v then
u=getValue(v,m.Themes.Dark)
if u then
return u
end
end

return nil
end

function m.AddThemeObject(p,r)
m.Objects[p]={Object=p,Properties=r}
m.UpdateTheme(p,false)
return p
end

function m.AddLangObject(p)
local r=m.LocalizationObjects[p]
local u=r.Object
local v=currentObjTranslationId
m.UpdateLang(u,v)
return u
end

function m.UpdateTheme(p,r)
local function ApplyTheme(u)
for v,x in pairs(u.Properties or{})do
local z=m.GetThemeProperty(x,m.Theme)
if z then
if typeof(z)=="Color3"then
local A=u.Object:FindFirstChild"WindUIGradient"
if A then
A:Destroy()
end

if not r then
u.Object[v]=z
else
m.Tween(u.Object,0.08,{[v]=z}):Play()
end
elseif type(z)=="table"and z.Color and z.Transparency then
u.Object[v]=Color3.new(1,1,1)

local A=u.Object:FindFirstChild"WindUIGradient"
if not A then
A=Instance.new"UIGradient"
A.Name="WindUIGradient"
A.Parent=u.Object
end

A.Color=z.Color
A.Transparency=z.Transparency

for B,C in pairs(z)do
if B~="Color"and B~="Transparency"and A[B]~=nil then
A[B]=C
end
end
end
else
local A=u.Object:FindFirstChild"WindUIGradient"
if A then
A:Destroy()
end
end
end
end

if p then
local u=m.Objects[p]
if u then
ApplyTheme(u)
end
else
for u,v in pairs(m.Objects)do
ApplyTheme(v)
end
end
end

function m.SetLangForObject(p)
if m.Localization and m.Localization.Enabled then
local r=m.LocalizationObjects[p]
if not r then return end

local u=r.Object
local v=r.TranslationId

local x=m.Localization.Translations[m.Language]
if x and x[v]then
u.Text=x[v]
else
local z=m.Localization and m.Localization.Translations and m.Localization.Translations.en or nil
if z and z[v]then
u.Text=z[v]
else
u.Text="["..v.."]"
end
end
end
end

function m.ChangeTranslationKey(p,r,u)
if m.Localization and m.Localization.Enabled then
local v=string.match(u,"^"..m.Localization.Prefix.."(.+)")
if v then
for x,z in ipairs(m.LocalizationObjects)do
if z.Object==r then
z.TranslationId=v
m.SetLangForObject(x)
return
end
end

table.insert(m.LocalizationObjects,{
TranslationId=v,
Object=r
})
m.SetLangForObject(#m.LocalizationObjects)
end
end
end

function m.UpdateLang(p)
if p then
m.Language=p
end

for r=1,#m.LocalizationObjects do
local u=m.LocalizationObjects[r]
if u.Object and u.Object.Parent~=nil then
m.SetLangForObject(r)
else
m.LocalizationObjects[r]=nil
end
end
end

function m.SetLanguage(p)
m.Language=p
m.UpdateLang()
end

function m.Icon(p)
return j.Icon(p)
end

function m.AddIcons(p,r)
return j.AddIcons(p,r)
end

function m.New(p,r,u)
local v=Instance.new(p)

for x,z in next,m.DefaultProperties[p]or{}do
v[x]=z
end

for A,B in next,r or{}do
if A~="ThemeTag"then
v[A]=B
end
if m.Localization and m.Localization.Enabled and A=="Text"then
local C=string.match(B,"^"..m.Localization.Prefix.."(.+)")
if C then
local F=#m.LocalizationObjects+1
m.LocalizationObjects[F]={TranslationId=C,Object=v}

m.SetLangForObject(F)
end
end
end

for C,F in next,u or{}do
F.Parent=v
end

if r and r.ThemeTag then
m.AddThemeObject(v,r.ThemeTag)
end
if r and r.FontFace then
m.AddFontObject(v)
end
return v
end

function m.Tween(p,r,u,...)
return f:Create(p,TweenInfo.new(r,...),u)
end

function m.NewRoundFrame(p,r,u,v,A,B)
local function getImageForType(C)
return C=="Squircle"and"rbxassetid://80999662900595"
or C=="SquircleOutline"and"rbxassetid://117788349049947"
or C=="SquircleOutline2"and"rbxassetid://117817408534198"
or C=="Squircle-Outline"and"rbxassetid://117817408534198"
or C=="Shadow-sm"and"rbxassetid://84825982946844"
or C=="Squircle-TL-TR"and"rbxassetid://73569156276236"
or C=="Squircle-BL-BR"and"rbxassetid://93853842912264"
or C=="Squircle-TL-TR-Outline"and"rbxassetid://136702870075563"
or C=="Squircle-BL-BR-Outline"and"rbxassetid://75035847706564"
or C=="Square"and"rbxassetid://82909646051652"
or C=="Square-Outline"and"rbxassetid://72946211851948"
end

local function getSliceCenterForType(C)
return C~="Shadow-sm"and Rect.new(256
,256
,256
,256

)or Rect.new(512,512,512,512)
end

local C=m.New(A and"ImageButton"or"ImageLabel",{
Image=getImageForType(r),
ScaleType="Slice",
SliceCenter=getSliceCenterForType(r),
SliceScale=1,
BackgroundTransparency=1,
ThemeTag=u.ThemeTag and u.ThemeTag
},v)

for F,G in pairs(u or{})do
if F~="ThemeTag"then
C[F]=G
end
end

local function UpdateSliceScale(H)
local J=r~="Shadow-sm"and(H/(256))or(H/512)
C.SliceScale=math.max(J,0.0001)
end

local H={}

function H.SetRadius(J,L)
UpdateSliceScale(L)
end

function H.SetType(J,L)
r=L
C.Image=getImageForType(L)
C.SliceCenter=getSliceCenterForType(L)
UpdateSliceScale(p)
end

function H.UpdateShape(J,L,M)
if M then
r=M
C.Image=getImageForType(M)
C.SliceCenter=getSliceCenterForType(M)
end
if L then
p=L
end
UpdateSliceScale(p)
end

function H.GetRadius(J)
return p
end

function H.GetType(J)
return r
end

UpdateSliceScale(p)

return C,B and H or nil
end

local p=m.New local r=
m.Tween

function m.SetDraggable(u)
m.CanDraggable=u
end



function m.Drag(u,v,A)
local B
local C,F,G
local H={
CanDraggable=true
}

if not v or type(v)~="table"then
v={u}
end

local function update(J)
if not C or not H.CanDraggable then return end

local L=J.Position-F
m.Tween(u,0.02,{Position=UDim2.new(
G.X.Scale,G.X.Offset+L.X,
G.Y.Scale,G.Y.Offset+L.Y
)}):Play()
end

for J
