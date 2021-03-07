--[[ FileName: AnimationTemplate.lua ]]
--[[ Author: Godcat567/GodCat856 ]]

print(0xFEAEFDDCABBF) --idfk lOl
print[[
	Animation Template By Godcat567/GodCat856
	You Can't Use "if math.random(1,somenumber) == 1 then" with tweens
	if you try to then it will not work

	Also make sure to deeply look into this template
	for all the easing styles and easing directions
	Happy Scripting

Sincerly - Godcat567/GodCat856
]]
print[[
		How To Use This |
						v
		1. Define Your Motor Variables & Use SetJointTween() to Reset The Motor6D's To Their Origin C0 & C1
		2. Take A Look At How Each Animation Was Made (This Might Help When Using The CFrames)
		3. Try Using SetJointTween() to Create The Desired Animation You Want, Ex. SetJointTween(MotorVariableHere, {C0 = CFrames Go Here},"Quad","Out",.1) <-- Use The Function For Each Motor
		without defining them inside the "while (not false) do end" loop
		Also MAKE YOUR ANIMATIONS WITHOUT STEALING THEM FROM OTHER SCRIPTS (I Am Serious)
]]
wait(1/60)

--[[ Defining Variables ]]

Plr = game:GetService("Players"):FindFirstChild("Username Here")
PlrGui = Plr.PlayerGui
Character = Plr.Character
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
Humanoid = Character:FindFirstChildOfClass('Humanoid')

--[[ Joint Setup ]]

Neck = Torso.Neck
RootJoint = RootPart.RootJoint
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
--Tail = Character["Black Cyber Critter Tail"].Handle.AccessoryWeld

EulerRootCF = CFrame.fromEulerAnglesXYZ(-1.57,0,3.14) --CFrame.Angles(math.rad(-90),0,math.rad(180))
NeckCF = CFrame.new(0,1,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180))
RightShoulderCF = CFrame.new(-0.5,0,0)*CFrame.Angles(0,math.rad(90),0)
LeftShoulderCF = CFrame.new(0.5,0,0)*CFrame.Angles(0,math.rad(-90),0)
--TailCF = CFrame.new(0,-.75,.5)*CFrame.fromEulerAnglesXYZ(-3.14,0,3.14)

DefaultWelds = {
	C0 = {
		RJC0 = CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,0,0),
		NKC0 = CFrame.new(0,1,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180)),
		RSC0 = CFrame.new(1,0.5,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),
		LSC0 = CFrame.new(-1,0.5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),
		RHC0 = CFrame.new(1,-1,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),
		LHC0 = CFrame.new(-1,-1,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),
	},
	C1 = {
		RJC1 = CFrame.fromEulerAnglesXYZ(-1.57,0,3.14)*CFrame.new(0,0,0),
		NKC1 = CFrame.new(0,-0.5,0)*CFrame.Angles(math.rad(-90),math.rad(0),math.rad(180)),
		RSC1 = CFrame.new(-0.5,0.5,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),
		LSC1 = CFrame.new(0.5,0.5,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),
		RHC1 = CFrame.new(0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(90),math.rad(0)),
		LHC1 = CFrame.new(-0.5,1,0)*CFrame.Angles(math.rad(0),math.rad(-90),math.rad(0)),
		
	},
}
--Default welds for anybody who does NOT know cframe

--[[ Killing Default Animations Initiated ]]

pcall(function()
	Character.Animate:Destroy()
	Humanoid.Animator:Destroy()
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do v:Stop() end
end)

--[[ Killing Default Animations Ended]]

--[[ Customizable Settings ]]

sinetick = 0
change = 1
Speed = 16
JumpPow = 80
IsAttacking = false
--[[ Artificial Heartbeat [Adapted By Nebula_Zoroark] ]]

AHB = Instance.new("BindableEvent")
FPS = 60
LastFrame = tick()
TimeFrame = 0
Frame = 1/FPS

game:GetService("RunService").Heartbeat:Connect(function(s,p)
	TimeFrame = TimeFrame + s
	if(TimeFrame>=Frame)then
		for i=1,math.floor(TimeFrame/Frame) do
			AHB:Fire()
		end
		LastFrame=tick()
		TimeFrame=TimeFrame-Frame*math.floor(TimeFrame/Frame)
	end
end)

function Swait(dur)
	if(dur == 0 or typeof(dur) ~= 'number') then
		AHB.Event:wait()
	else
		for i= 1, dur*FPS do
			AHB.Event:wait()
		end
	end
end

--[[ Functions ]]

function SetJointTween(Joint,TweenData,EasingType,DirectionType,AnimationTime)
	local EST = Enum.EasingStyle[EasingType]
	local DRT = Enum.EasingDirection[DirectionType]
	local InterpolationSpeed = 1
	local TI = TweenInfo.new(AnimationTime/InterpolationSpeed,EST,DRT,0,false,0)
	local MCF = TweenData
	local TAnim = game:service'TweenService':Create(Joint,TI,MCF)
	TAnim:Play()
end

--[[ Miscellaneous Stuff ]]

pcall(function()
	if Neck and RightShoulder and LeftShoulder and RightHip and LeftHip and RootJoint then
		Neck:Destroy()
		Neck = Instance.new("Motor6D")
		Neck.Parent = Torso
		Neck.Name = "Neck"
		Neck.Part0 = Torso
		Neck.Part1 = Head
		RootJoint:Destroy()
		RootJoint = Instance.new("Motor6D")
		RootJoint.Parent = RootPart
		RootJoint.Part0 = RootPart
		RootJoint.Part1 = Torso
		RootJoint.Name = "RootJoint"
		RightShoulder:Destroy()
		RightShoulder = Instance.new("Motor6D")
		RightShoulder.Parent = Torso
		RightShoulder.Part0 = Torso
		RightShoulder.Part1 = RightArm
		RightShoulder.Name = "Right Shoulder"
		LeftShoulder:Destroy()
		LeftShoulder = Instance.new("Motor6D")
		LeftShoulder.Parent = Torso
		LeftShoulder.Part0 = Torso
		LeftShoulder.Part1 = LeftArm
		LeftShoulder.Name = "Left Shoulder"
		RightHip:Destroy()
		RightHip = Instance.new("Motor6D")
		RightHip.Parent = Torso
		RightHip.Part0 = Torso
		RightHip.Part1 = RightLeg
		RightHip.Name = "Right Hip"
		LeftHip:Destroy()
		LeftHip = Instance.new("Motor6D")
		LeftHip.Parent = Torso
		LeftHip.Part0 = Torso
		LeftHip.Part1 = LeftLeg
		LeftHip.Name = "Left Hip"
	end
end)

SetJointTween(RootJoint,{C0 = DefaultWelds.C0.RJC0},"Quad","InOut",.1)
SetJointTween(Neck,{C0 = DefaultWelds.C0.NKC0},"Quad","InOut",.1)
SetJointTween(RightShoulder,{C0 = DefaultWelds.C0.RSC0},"Quad","InOut",.1)
SetJointTween(LeftShoulder,{C0 = DefaultWelds.C0.LSC0},"Quad","InOut",.1)
SetJointTween(RightHip,{C0 = DefaultWelds.C0.RHC0},"Quad","InOut",.1)
SetJointTween(LeftHip,{C0 = DefaultWelds.C0.LHC0},"Quad","InOut",.1)
SetJointTween(RootJoint,{C1 = DefaultWelds.C1.RJC1},"Quad","InOut",.1)
SetJointTween(Neck,{C1 = DefaultWelds.C1.NKC1},"Quad","InOut",.1)
SetJointTween(RightShoulder,{C1 = DefaultWelds.C1.RSC1},"Quad","InOut",.1)
SetJointTween(LeftShoulder,{C1 = DefaultWelds.C1.LSC1},"Quad","InOut",.1)
SetJointTween(RightHip,{C1 = DefaultWelds.C1.RHC1},"Quad","InOut",.1)
SetJointTween(LeftHip,{C1 = DefaultWelds.C1.LHC1},"Quad","InOut",.1)

local s = Instance.new("Sound")
s.Parent = Torso
s.SoundId = "rbxassetid://4627095401" --just a note you can use this id to fix the Achromatic mode on nebula's NGR cr thing
s.Pitch = 1
s.Volume = 2
s.Name = tostring(function() end):sub(10)
s.Looped = true
s:play()

EasingStyles = {
	["Back"] = "Back",
	["Bounce"] = "Bounce",
	["Circular"] = "Circular",
	["Cubic"] = "Cubic",
	["Elastic"] = "Elastic",
	["Exponential"] = "Exponential",
	["Linear"] = "Linear",
	["Quad"] = "Quad",
	["Quart"] = "Quart",
	["Quint"] = "Quint",
	["Sine"] = "Sine"
}

EasingDirections = {
	["In"] = "In",
	["InOut"] = "InOut",
	["Out"] = "Out"
}

--[[ Mouse Stuff ]]

--[[Mouse.KeyDown:Connect(function(k)
if k == "q" then
if Speed == 16 then
Speed = 50
elseif Speed == 50 then
Speed = 82
elseif Speed == 82 then
Speed = 16
end
end
end)

Mouse.KeyUp:Connect(function()
--lOl
end)--]]


--[[ Wrapper ]]

while (not false) do
	Swait()

	if(typeof(s) == "Instance")then
		s.Parent = Torso
		s.SoundId = "rbxassetid://4627095401"
		s.Pitch = 1
		s.Volume = 2
		s.Name = tostring(function() end):sub(10)
		s.Looped = true
		s.Playing = true
	elseif(typeof(s) ~= "Instance" or s.Parent ~= Torso or s.Parent == nil or s == nil) then
		local s = Instance.new("Sound")
		s.Parent = Torso
		s.SoundId = "rbxassetid://4627095401"
		s.Pitch = 1
		s.Volume = 2
		s.Name = tostring(function() end):sub(10)
		s.Looped = true
		s.Playing = true
	end

	if Character:FindFirstChildOfClass'Humanoid' == nil then
		Humanoid = Instance.new("Humanoid",Character)
	end
	local torvel = (RootPart.Velocity * Vector3.new(1, 0, 1)).magnitude
	local torsvertvel = RootPart.Velocity.Y
	local hflr,psflr = workspace:FindPartOnRayWithIgnoreList(Ray.new(RootPart.CFrame.p,((CFrame.new(RootPart.Position,RootPart.Position - Vector3.new(0,1,0))).lookVector).unit * (4)), {Character})
	spval = 25/(Humanoid.WalkSpeed/16)
	sinetick=sinetick+change
	Humanoid.WalkSpeed = Speed
	Humanoid.JumpPower = JumpPow
	Humanoid.Health = "NAN"
	Humanoid.MaxHealth = "NAN"

	local InterpolationSpeed = 0.1
	if torsvertvel > 1 and hflr == nil then
		Anima = "jump"
	elseif torsvertvel < -1 and hflr == nil then
		Anima = "fall"
	elseif Humanoid.Sit == true then
		Anima = "sit"	
	elseif torvel < 1 and hflr ~= nil  then
		Anima = "idle"
	elseif torvel > 2 and torvel < 22 and  hflr ~= nil  then
		Anima = "walk"
	elseif torvel >= 22 and hflr ~= nil then
		Anima = "run"	
	else
		Anima = ""	
	end

	--Footplanting Math :joy:
	local FwdDir = Humanoid.MoveDirection*RootPart.CFrame.lookVector
	local RigDir = Humanoid.MoveDirection*RootPart.CFrame.rightVector
	Vector = {
		X=math.clamp(RigDir.X+RigDir.Z,-Humanoid.WalkSpeed,Humanoid.WalkSpeed),
		Z=math.clamp(FwdDir.X+FwdDir.Z,-Humanoid.WalkSpeed,Humanoid.WalkSpeed)
	}
	Div = 1
	if(Vector.Z<0)then
		Div=math.clamp(-(1.25*Vector.Z),1,2)
	end
	Vector.X = Vector.X/Div
	Vector.Z = Vector.Z/Div
	ForWLV = Vector.X
	ForWLB = Vector.Z
	
	--[[if Plr.Name == "Godcat567" then
	SetJointTween(Tail,{C0 = TailCF*CFrame.Angles(math.rad(0),math.rad(20 * math.sin(sinetick/60*2.5)),math.rad(0))},"Quad","Out",InterpolationSpeed)
	end
	ignore this i only created the tail weld for the Black & White Cyber Critter Tails
	--]] 

	if IsAttacking == false then
		if Anima == "jump" then
			if torsvertvel <= 400 then
				SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,-.1 + .01 * math.cos(sinetick/22))*CFrame.Angles(math.rad(0 + torsvertvel/10),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			elseif torsvertvel > 400 then
				SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,-.1 + .01 * math.cos(sinetick/22))*CFrame.Angles(math.rad(-40),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			end
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad(-10),math.rad(0),math.rad(0 + torsvertvel/2))*RightShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.5,.5,0)*CFrame.Angles(math.rad(-10),math.rad(0),math.rad(0 - torsvertvel/2))*LeftShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-.5,-.5)*CFrame.Angles(math.rad(0),math.rad(90),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-1,-0)*CFrame.Angles(math.rad(0),math.rad(-90),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
		elseif Anima == "fall" then
			if torsvertvel >= -400 then
				SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,-.1 + .01 * math.cos(sinetick/22))*CFrame.Angles(math.rad(0 - torsvertvel/10),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			elseif torsvertvel < -400 then
				SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,-.1 + .01 * math.cos(sinetick/22))*CFrame.Angles(math.rad(40),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			end
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad(20),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad(80 - torsvertvel/2),math.rad(0),math.rad(0 - torsvertvel/5))*RightShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.5,.5,0)*CFrame.Angles(math.rad(80 - torsvertvel/2),math.rad(0),math.rad(0 + torsvertvel/5))*LeftShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-.5,-.5)*CFrame.Angles(math.rad(-10),math.rad(90),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-1,-0)*CFrame.Angles(math.rad(-20),math.rad(-90),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
		elseif Anima == "idle" then
			SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,0 + .05 * math.cos(sinetick/22/2))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad(0 + 2.5 * math.cos(sinetick/22/2)),math.rad(0),math.rad(0 + 20 * math.cos(sinetick/22/2)))},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(5 + 2.5 * math.cos(sinetick/22/2)))*RightShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.5,.5,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(-5 - 2.5 * math.cos(sinetick/22/2)))*LeftShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-1 - .05 * math.cos(sinetick/22/2),-0)*CFrame.Angles(math.rad(0),math.rad(87),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-1 - .05 * math.cos(sinetick/22/2),-0)*CFrame.Angles(math.rad(0),math.rad(-87),0)*CFrame.Angles(math.rad(0),0,0)},"Quad","Out",InterpolationSpeed)
		elseif Anima == "walk" then
			SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(-0.4 * 1 * ForWLV,-0.4 * (10/10) * ForWLB,-.185 + .155 * (10/10) * math.cos(sinetick/(12/2)))*CFrame.Angles(math.rad(5)*ForWLB,math.rad(5)*-ForWLV,math.rad(4*math.cos(sinetick/12)))},"Circular","Out",0.1)
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad((-ForWLB - -ForWLB/5 * math.cos(sinetick/(14/2)))*8),math.rad(0),math.rad((-ForWLV*45+-8 * math.cos(sinetick/12))))},"Circular","Out",0.1)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad((ForWLB - ForWLB/5 * math.cos(sinetick/12))*25 * math.cos(sinetick/12)),math.rad(0),math.rad(5))*RightShoulderCF},"Circular","Out",0.1)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.5,.5,0)*CFrame.Angles(math.rad((-ForWLB + ForWLB/5 * math.cos(sinetick/12))*25 * math.cos(sinetick/12)),math.rad(0),math.rad(-5))*LeftShoulderCF},"Circular","Out",0.1)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-.85 + .25 * (10/10) * math.sin(sinetick/12) / 2,(0.3 * 1 * math.cos(sinetick/12) / 2)*ForWLB)*CFrame.Angles(math.rad((-ForWLB + ForWLB/5 * math.cos(sinetick/12))*45 * math.cos(sinetick/12)-math.sin(sinetick/24)),math.rad(0),math.rad((ForWLV - ForWLV/5 * math.cos(sinetick/12))*40 * math.cos(sinetick/12)-math.sin(sinetick/24)))*CFrame.Angles(0,math.rad(90),0)},"Circular","Out",0.1)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-.85 - .25 * (10/10) * math.sin(sinetick/12) / 2,(-0.3 * 1 * math.cos(sinetick/12) / 2)*ForWLB)*CFrame.Angles(math.rad((ForWLB - ForWLB/5 * math.cos(sinetick/12))*45 * math.cos(sinetick/12)+math.sin(sinetick/24)),math.rad(0),math.rad((-ForWLV + ForWLV/5 * math.cos(sinetick/12))*40 * math.cos(sinetick/12)+math.sin(sinetick/24)))*CFrame.Angles(0,math.rad(-90),0)},"Circular","Out",0.1)
		elseif Anima == "run" then
			SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(-0.8 * (10/10) * ForWLV,-0.8 * (10/10) * ForWLB,-.185 + 0.155 * (10/10) * math.cos(sinetick/(6/2)))*CFrame.Angles(math.rad(25)*ForWLB,math.rad(10)*-ForWLV,math.rad(8*math.cos(sinetick/6)))},"Circular","Out",0.1)
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad((-ForWLB - -ForWLB/5 * math.cos(sinetick/7))*25),math.rad(0),math.rad((-ForWLV*45+-8 * math.cos(sinetick/6))))},"Circular","Out",0.1)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.5,.5,0)*CFrame.Angles(math.rad((ForWLB - ForWLB/5 * math.cos(sinetick/6))*80 * math.cos(sinetick/6)),math.rad(0),math.rad(5))*RightShoulderCF},"Circular","Out",0.1)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.5,.5,0)*CFrame.Angles(math.rad((-ForWLB + ForWLB/5 * math.cos(sinetick/6))*80 * math.cos(sinetick/6)),math.rad(0),math.rad(-5))*LeftShoulderCF},"Circular","Out",0.1)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-.85 + 0.25 * (10/10) * math.sin(sinetick/6) / 2, (0.6 * 1 * math.cos(sinetick/6) / 2)*ForWLB)*CFrame.Angles(math.rad((-ForWLB + ForWLB/5 * math.cos(sinetick/6))*85 * math.cos(sinetick/6)-math.sin(sinetick/12)),math.rad(0),math.rad((ForWLV - ForWLV/5 * math.cos(sinetick/6))*40 * math.cos(sinetick/6)-math.sin(sinetick/12)))*CFrame.Angles(0,math.rad(90),0)},"Circular","Out",0.1)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-.85 - 0.25 * (10/10) * math.sin(sinetick/6) / 2, (-0.6 * 1 * math.cos(sinetick/6) / 2)*ForWLB)*CFrame.Angles(math.rad((ForWLB - ForWLB/5 * math.cos(sinetick/6))*85 * math.cos(sinetick/6)+math.sin(sinetick/12)),math.rad(0),math.rad((-ForWLV + ForWLV/5 * math.cos(sinetick/6))*40 * math.cos(sinetick/6)+math.sin(sinetick/12)))*CFrame.Angles(0,math.rad(-90),0)},"Circular","Out",0.1)
		elseif Anima == "sit" then
			SetJointTween(RootJoint,{C0 = EulerRootCF*CFrame.new(0,0,0.5)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))},"Quad","Out",InterpolationSpeed)
			SetJointTween(Neck,{C0 = CFrame.new(0,1,0,-1,-0,-0,0,0,1,0,1,0)*CFrame.Angles(math.rad(0 - 2.3 * math.cos(sinetick/32)),math.rad(0 + 3.3 * math.cos(sinetick/77)),math.rad(0+10*math.cos(sinetick/91)))},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightShoulder,{C0 = CFrame.new(1.3,.5,-0.5)*CFrame.Angles(math.rad(20),math.rad(0),math.rad(-20))*RightShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftShoulder,{C0 = CFrame.new(-1.3,.5,-0.5)*CFrame.Angles(math.rad(20),math.rad(0),math.rad(20))*LeftShoulderCF},"Quad","Out",InterpolationSpeed)
			SetJointTween(RightHip,{C0 = CFrame.new(1,-1.5,0.5)*CFrame.Angles(math.rad(90),math.rad(90),0)*CFrame.Angles(math.rad(-3),0,0)},"Quad","Out",InterpolationSpeed)
			SetJointTween(LeftHip,{C0 = CFrame.new(-1,-1.5,0.5)*CFrame.Angles(math.rad(90),math.rad(-90),0)*CFrame.Angles(math.rad(-3),0,0)},"Quad","Out",InterpolationSpeed)
		end
	end
end

--[[ Script & Animations Ended ]]
