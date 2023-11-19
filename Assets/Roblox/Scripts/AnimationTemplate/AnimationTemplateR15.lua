--[[ FileName: R15_Template.lua ]]
--[[ Author: @Godcat567 ]]

task.wait()

print([[
	R15 Animation Template

	Author: Protofloof (@Godcat567)

	I Do Not Care If People Call This A "Rare" Script, I only Believe in Open Source, And Closed Source.
]])

-- Sources May Be Used From Other Scripts, Credits To Their Original Creators.
local Player = (typeof(owner) == "Instance" and owner) or game:GetService("Players"):FindFirstChild(owner.Name)
Player.Character.Archivable = true
local CharacterBackup = Player.Character:Clone()
CharacterBackup.Parent = nil
Player.Character = nil

if CharacterBackup:FindFirstChild("Animate") then
	CharacterBackup:FindFirstChild("Animate").Enabled = false;
	CharacterBackup:FindFirstChild("Animate"):Destroy()
end

Player.Character = CharacterBackup:Clone()
Player.Character.Parent = workspace

local Character = Player.Character
---------------------------------------------------
local LeftUpperArm = Character.LeftUpperArm
local LeftShoulder = Character.LeftUpperArm.LeftShoulder
local LeftLowerArm = Character.LeftLowerArm
local LeftElbow = Character.LeftLowerArm.LeftElbow
--------------------------------------------------------
local LeftUpperLeg = Character.LeftUpperLeg
local LeftHip = Character.LeftUpperLeg.LeftHip
local LeftLowerLeg = Character.LeftLowerLeg
local LeftKnee = Character.LeftLowerLeg.LeftKnee
local LeftAnkle = Character.LeftFoot.LeftAnkle
----------------------------------------------------------
local RightUpperArm = Character.RightUpperArm
local RightShoulder = Character.RightUpperArm.RightShoulder
local RightLowerArm = Character.RightLowerArm
local RightElbow = Character.RightLowerArm.RightElbow
----------------------------------------------------------
local RightUpperLeg = Character.RightUpperLeg
local RightHip = Character.RightUpperLeg.RightHip
local RightLowerLeg = Character.RightLowerLeg
local RightKnee = Character.RightLowerLeg.RightKnee
local RightAnkle = Character.RightFoot.RightAnkle
----------------------------------------------------------
local UpperTorso = Character.UpperTorso
local Waist = UpperTorso.Waist
local LowerTorso = Character.LowerTorso
local Root = Character.LowerTorso.Root
local RootPart = Character.HumanoidRootPart
local LeftHand = Character.LeftHand
local RightHand = Character.RightHand
local LeftFoot = Character.LeftFoot
local RightFoot = Character.RightFoot
local RightWrist= RightHand.RightWrist
local LeftWrist= LeftHand.LeftWrist
--------------------------------------------
local Head = Character.Head
local Neck = Character.Head.Neck
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
--[[ Settings ]]

local IsAttacking = false
local Timing = {
	Sine = 0;
	Change = 1;
	LastFrame = tick();
}
local Hitfloor = nil; -- Raycast Touching Instance
local Posfloor = nil; -- Raycast Getting Instance Normal
local Effects = Instance.new("Folder", Character)
Effects.Name = "Effects"
local Instance = setmetatable({
	new = function(type, data)
		local Instance = Instance.new(type)
		if data then
			if typeof(data) == "Instance" then
				Instance.Parent = data
			elseif typeof(data) == "table" then
				for index,data2 in pairs(data) do
					Instance[index] = data2
				end
			end
		end
		return Instance
	end
},{
	__index = Instance
})

local math = setmetatable({
	cotan = function(arg)
		return (math.sin(arg / 2) * math.cos(arg / 2))
	end,
	acotan = function(arg)
		return (math.asin(arg / 2) * math.acos(arg / 2))
	end,
}, {
	__index = math;
})

--[[ Artificial Heartbeat (Optimized In Luau By @Godcat567) ]]

local ArtificialHB = Instance.new("BindableEvent")
local FramesPerSecond = 60
local TimeFrame = 0
local AllowTossedFrames = true;
local TossRemainingFrames = true;
local LastCurrentFrame = tick()
local CurrentFrame = 1 / FramesPerSecond
ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:Connect(function(currentStep, deltaTime)
	TimeFrame += currentStep
	if(TimeFrame >= CurrentFrame) then
		if (AllowTossedFrames) then
			ArtificialHB:Fire()
			LastCurrentFrame = tick()
		else
			for i = 1, math.floor(TimeFrame / CurrentFrame) do
				ArtificialHB:Fire()
			end
			LastCurrentFrame = tick()
		end
		if (TossRemainingFrames) then
			TimeFrame = 0;
		else
			TimeFrame -= CurrentFrame * math.floor(TimeFrame / CurrentFrame)
		end
	end
end)

function Swait(dur)
	if(dur == 0 or dur == nil or typeof(dur) ~= 'number') then
		ArtificialHB.Event:wait()
	else
		for i= 1, dur * FramesPerSecond do
			ArtificialHB.Event:wait()
		end
	end
end

--[[ Functions ]]

function GetLimbs(Char)
	local LimbTable = {}
	for i, v in pairs(Char:GetChildren()) do
		if v:IsA("BasePart") then
			for i, v2 in pairs(v:GetChildren()) do
				if v2:IsA("Motor6D") then
					table.insert(LimbTable, {v, v2.Part1, v2, OrigC0 = v2.C0, OrigC1 = v2.C1})
				end
			end
		end
	end
	return LimbTable
end

local Limbs = GetLimbs(Character)

function GetC0(Motor)
	local returnedC0 = CFrame.new(0, 0, 0)
	for i = 1, #Limbs do
		local ChosenLimb = Limbs[i]
		if ChosenLimb[3] == Motor then
			returnedC0 = ChosenLimb.OrigC0
		end
	end
	return returnedC0
end

function GetC1(Motor)
	local returnedC1 = CFrame.new(0, 0, 0)
	for i = 1, #Limbs do
		local ChosenLimb = Limbs[i]
		if ChosenLimb[3] == Motor then
			returnedC1 = ChosenLimb.OrigC1
		end
	end
	return returnedC1
end

function SetTween(Inst, TweenData, EaseStyle, EaseDir, Time)
	local animSpeed = 1
	if IsAttacking then
		animSpeed = 3
	end
	
	if Inst.Name == "Bullet" then
		animSpeed = 1
	end
	
	local tweenInfo = TweenInfo.new(unpack({
		Time/animSpeed,
		EaseStyle,
		EaseDir,
		0,
		false,
		0
	}))
	local tweenInst = game:GetService("TweenService"):Create(Inst, tweenInfo, TweenData)
	return tweenInst:Play()
end

function AnimateChar(data)
	local AnimTime = (data.AnimTime or 0.1)
	local animStyle = (data.AnimStyle or Enum.EasingStyle.Quad)
	local animDirection = (data.AnimDirection or Enum.EasingDirection.Out)
	local RShoulder = (data.RSHC0 or data.RightShoulder or CFrame.new(0, 0, 0))
	local LShoulder = (data.LSHC0 or data.LeftShoulder or CFrame.new(0, 0, 0))
	local RootJoint = (data.RJC0 or data.RootJoint or CFrame.new(0, 0, 0))
	local Nck = (data.NKC0 or data.Neck or CFrame.new(0, 0, 0))
	local RHip = (data.RHC0 or data.RightHip or CFrame.new(0, 0, 0))
	local LHip = (data.LHC0 or data.LeftHip or CFrame.new(0, 0, 0))
	local Wst = (data.WSC0 or data.Waist or CFrame.new(0, 0, 0))
	local LElbow = (data.LEBC0 or data.LeftElbow or CFrame.new(0, 0, 0))
	local RElbow = (data.REBC0 or data.RightElbow or CFrame.new(0, 0, 0))
	local RWrist = (data.RWC0 or data.RightWrist or CFrame.new(0, 0, 0))
	local LWrist = (data.LWC0 or data.LeftWrist or CFrame.new(0, 0, 0))
	local RKnee = (data.RKC0 or data.RightKnee or CFrame.new(0, 0, 0))
	local LKnee = (data.LKC0 or data.LeftKnee or CFrame.new(0, 0, 0))
	local RAnkle = (data.RAC0 or data.RightAnkle or CFrame.new(0, 0, 0))
	local LAnkle = (data.LAC0 or data.LeftAnkle or CFrame.new(0, 0, 0))
	
	-- Right Arm
	SetTween(RightShoulder, {
		C0 = GetC0(RightShoulder) * RShoulder
	}, animStyle, animDirection, AnimTime)
	SetTween(RightElbow, {
		C0 = GetC0(RightElbow) * RElbow
	}, animStyle, animDirection, AnimTime)
	SetTween(RightWrist, {
		C0 = GetC0(RightWrist) * RWrist
	}, animStyle, animDirection, AnimTime)
	--
	-- Left Arm
	SetTween(LeftShoulder, {
		C0 = GetC0(LeftShoulder) * LShoulder
	}, animStyle, animDirection, AnimTime)
	SetTween(LeftElbow, {
		C0 = GetC0(LeftElbow) * LElbow
	}, animStyle, animDirection, AnimTime)
	SetTween(LeftWrist, {
		C0 = GetC0(LeftWrist) * LWrist
	}, animStyle, animDirection, AnimTime)
	--
	-- Head, Torso
	SetTween(Neck, {
		C0 = GetC0(Neck) * Nck
	}, animStyle, animDirection, AnimTime)
	SetTween(Waist, {
		C0 = GetC0(Waist) * Wst
	}, animStyle, animDirection, AnimTime)
	SetTween(Root, {
		C0 = GetC0(Root) * RootJoint
	}, animStyle, animDirection, AnimTime)
	--
	-- Right Leg
	SetTween(RightHip, {
		C0 = GetC0(RightHip) * RHip
	}, animStyle, animDirection, AnimTime)
	SetTween(RightKnee, {
		C0 = GetC0(RightKnee) * RKnee
	}, animStyle, animDirection, AnimTime)
	SetTween(RightAnkle, {
		C0 = GetC0(RightAnkle) * RAnkle
	}, animStyle, animDirection, AnimTime)
	--
	-- Left Leg
	SetTween(LeftHip, {
		C0 = GetC0(LeftHip) * LHip
	}, animStyle, animDirection, AnimTime)
	SetTween(LeftKnee, {
		C0 = GetC0(LeftKnee) * LKnee
	}, animStyle, animDirection, AnimTime)
	SetTween(LeftAnkle, {
		C0 = GetC0(LeftAnkle) * LAnkle
	}, animStyle, animDirection, AnimTime)
end

function RayCast(Data)
	local Origin = (Data.Origin or Vector3.new())
	local Direction = (Data.Direction or Vector3.new())
	local Range = (Data.Range or 9e99)
	local RaycastArgs = RaycastParams.new()
	RaycastArgs.FilterType = (Data.FilterType or Enum.RaycastFilterType.Exclude)
	RaycastArgs.IgnoreWater = (Data.IgnoreWater or true)
	RaycastArgs.FilterDescendantsInstances = (Data.Filter or {})
	return workspace:Raycast(Origin, Direction.Unit * Range, RaycastArgs)
end

function NewSound(data)
	local SoundId = "rbxassetid://" .. (data.SoundID or 0)
	local TimePosition = (data.TimePosition or 0)
	local Parent = (data.Parent or nil)
	local SoundVolume = (data.Volume or 1)
	local SoundPitch = (data.Pitch or 1)
	local IsLooped = (data.IsLooped or false)
	local EmitterSize = (data.EmitterSize or 10)
	local MaxDistance = (data.MaxDistance or 10000)
	local Playing = (data.Playing or true)
	local PlayOnRemove = (data.PlayOnRemove or false)
	local IsDebrisedAfterPlaying = (data.IsDebrisedAfter or false)
	local Name = (data.Name or "TerrorRemake_FXSound")
	local AutoPlay = (data.AutoPlay or false)
	local IsEchoAllowed = (data.AllowEcho or false)
	local EchoDelay = (data.EchoDelay or 0.15)
	local EchoDryLevel = (data.EchoDryLevel or 0)
	local EchoWetLevel = (data.EchoWetLevel or 0)
	local EchoFeedback = (data.EchoFeedback or 0)
	if SoundId ~= "rbxassetid://0" then
		local ActualSound = Instance.new("Sound")
		ActualSound.Parent = Parent
		ActualSound.Name = Name
		ActualSound.SoundId = SoundId
		ActualSound.Volume = SoundVolume
		ActualSound.PlaybackSpeed = SoundPitch
		ActualSound.Looped = IsLooped
		ActualSound.EmitterSize = EmitterSize
		ActualSound.MaxDistance = MaxDistance
		ActualSound.TimePosition = TimePosition
		ActualSound.PlayOnRemove = PlayOnRemove
		if AutoPlay and not Playing then
			coroutine.wrap(function()
				repeat Swait() until ActualSound.IsLoaded
				ActualSound.Playing = Playing
			end)()
		end
		if IsEchoAllowed then
			local ActualEchoEffect = Instance.new("EchoSoundEffect")
			ActualEchoEffect.Parent = ActualSound
			ActualEchoEffect.Delay = EchoDelay
			ActualEchoEffect.DryLevel = EchoDryLevel
			ActualEchoEffect.Feedback = EchoFeedback
			ActualEchoEffect.WetLevel = EchoWetLevel
		end
		if (IsDebrisedAfterPlaying and Playing and not IsLooped) or (AutoPlay and not IsLooped and IsDebrisedAfterPlaying) then
			repeat Swait() until ActualSound.Ended
			game:GetService("Debris"):AddItem(ActualSound, ActualSound.TimeLength + 5)
		end
		if Playing then
			ActualSound:Play()
		end
		if Playing and PlayOnRemove or AutoPlay and PlayOnRemove then
			ActualSound:Destroy()
		end
		if PlayOnRemove then
			ActualSound:Destroy()
		end
		return ActualSound
	end
end

function PreloadAssets(assetsList)
	game:GetService("ContentProvider"):PreloadAsync(assetsList, nil)
end

--[[ Miscellaneous Stuff ]]

if game.PlaceId == 4994196290 then
	--PreloadAssets({15258212182})
	
	local Sounda = NewSound({
		SoundID = 15258212182,
		Volume = 1,
		Pitch = 1,
		AutoPlay = true,
		IsDebrisedAfter = false,
		Playing = false,
		IsLooped = true,
		Parent = LowerTorso
	})
end

while Character.Parent ~= nil do
	Swait()
	Timing.Sine += (tick() - Timing.LastFrame) * 60 * Timing.Change
	Timing.LastFrame = tick()
	local RayResult = RayCast({
		Origin = RootPart.CFrame.Position,
		Direction = CFrame.new(RootPart.CFrame.Position, RootPart.CFrame.Position - Vector3.new(0, 1, 0)).LookVector,
		Range = 4,
		FilterType = Enum.RaycastFilterType.Exclude,
		Filter = {Character}
	})
	if RayResult then
		Hitfloor = RayResult.Instance
		Posfloor = RayResult.Normal
	end
	local Walking = (math.abs(RootPart.Velocity.X) > 1 or math.abs(RootPart.Velocity.Z) > 1)
	local State = ((Humanoid.PlatformStand and "Paralyzed") or (Humanoid.Sit and "Sit") or (not Hitfloor and RootPart.Velocity.Y < -1 and "Falling") or (not Hitfloor and RootPart.Velocity.Y < 1 and "Jumping") or (Hitfloor and Walking and "Walk") or Hitfloor and (RootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude < 1 and "Idle")
	local Div = 1;
	local ForwardVel = Walking and Humanoid.MoveDirection * RootPart.CFrame.LookVector or Vector3.new()
	local SideVel = Walking and Humanoid.MoveDirection * RootPart.CFrame.RightVector or Vector3.new()
	local Vector = {
		X = ForwardVel.X + ForwardVel.Z,
		Z = SideVel.X + SideVel.Z
	}
	if (Vector.Z < 0) then
		Div = math.clamp(-(1.25 * Vector.Z), 1, 2)
	end
	Vector.X /= Div
	Vector.Z /= Div
	ForwardVec = Vector.X
	SideVec = Vector.Z
	if State == "Idle" then
		--CreateEffect({
		--	Time = 30,
		--	FXType = "Sphere",
		--	StartSize = Vector3.new(0.2, 0, 0.2),
		--	EndSize = Vector3.new(0.5, 6, 0.5),
		--	StartTransparency = 0.3,
		--	EndTransparency = 1,
		--	CFrame = RootPart.CFrame * CFrame.new(math.random(-3,3), -10,math.random(-3,3)) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),
		--	VectorPos = RootPart.Position + Vector3.new(math.random(-3, 3), 10, math.random(-3, 3)),
		--	RadX = 0,
		--	RadY = 0,
		--	RadZ = 0,
		--	Material = "Neon",
		--	Color = Color3.fromRGB(128 + 128 * math.cos(Timing.Sine / 71), 128 + 75 * math.cos(Timing.Sine / 51.5), 128 + 92 * math.cos(Timing.Sine / 46.13)),
		--	FXSoundId = nil,
		--	FXVol = nil,
		--	FXPitch = nil,
		--	IsBoomerangMathUsed = true,
		--	PosBoomerang = 50,
		--	SizeBoomerang = 82
		--})
		AnimateChar({
			AnimTime = 0.1,
			AnimStyle = Enum.EasingStyle.Quad,
			AnimDirection = Enum.EasingDirection.Out,
			RootJoint = CFrame.new(0 - 0.23 * math.cos(Timing.Sine / 52.5), 1.2 + 1 * math.cos(Timing.Sine / 28), 0 + 0.2 * math.cos(Timing.Sine / 34)) * CFrame.Angles(math.rad(-2 + 4 * math.cos(Timing.Sine / 32)), math.rad(0), math.rad(0 - 2.2 * math.cos(Timing.Sine/98) + 3.1 * math.cos(Timing.Sine/86))),
			Neck = CFrame.Angles(math.rad(2 - 4.5 * math.cos(Timing.Sine / 58)), math.rad(0 + 3.1 * math.cos(Timing.Sine / 42) - 9 * math.cos(Timing.Sine / 26) + 0.4 * math.cos(Timing.Sine / 47)), math.rad(20 + 6.2 * math.cos(Timing.Sine / 76))),
			RightShoulder = CFrame.new(0, 0 + 0.05 * math.cos(Timing.Sine / 28), 0) * CFrame.Angles(math.rad(0), math.rad(0 - 2 * math.cos(Timing.Sine / 43)), math.rad(10 - 5 * math.cos(Timing.Sine / 28))),
			LeftShoulder = CFrame.new(0, 0 + 0.05 * math.cos(Timing.Sine / 28), 0) * CFrame.Angles(math.rad(0), math.rad(0 + 2 * math.cos(Timing.Sine / 43)), math.rad(-10 + 5 * math.cos(Timing.Sine / 28))),
			RightHip = CFrame.new(0, 0.2, -0.5) * CFrame.Angles(math.rad(-2.5 - 4.5 * math.cos(Timing.Sine/38)), math.rad(-20), math.rad(-6.2 - 3.45 * math.cos(Timing.Sine / 38.53))),
			LeftHip = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-4.25 - 2.3 * math.cos(Timing.Sine/22)), math.rad(20), math.rad(5.7 + 3.13 * math.cos(Timing.Sine / 32.91))),
			RightElbow = CFrame.Angles(math.rad(8.32 - 1.351 * math.cos(Timing.Sine / 37.2) + 9.23 * math.cos(Timing.Sine / 41.54)), math.rad(0), math.rad(0)),
			LeftElbow = CFrame.Angles(math.rad(8.51 - 1.351 * math.cos(Timing.Sine / 37.2) + 9.23 * math.cos(Timing.Sine / 41.54)), math.rad(0), math.rad(0)),
			Waist = CFrame.Angles(math.rad(-2 + 4 * math.cos(Timing.Sine / 32)), math.rad(0), math.rad(0)),
			RightKnee = CFrame.Angles(math.rad(-12.32 - 4.42 * math.cos(Timing.Sine / 42.21)), math.rad(0), math.rad(0)),
			LeftKnee = CFrame.Angles(math.rad(-10.86 - 6.10 * math.cos(Timing.Sine / 38.1)), math.rad(0), math.rad(0))
		})
		if Random.new():NextInteger(1, 64) == 1 then
			SetTween(Neck, {
				C0 = GetC0(Neck) * CFrame.Angles(math.random(), math.random(), math.random())
			}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
			--SetTween(RightShoulder, {
			--	C0 = GetC0(RightShoulder) * CFrame.Angles(math.random(), math.random(), math.random())
			--}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1)
			--SetTween(LeftShoulder, {
			--	C0 = GetC0(LeftShoulder) * CFrame.Angles(math.random(), math.random(), math.random())
			--}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1)
		end
	elseif State == "Walk" then
		AnimateChar({
			AnimTime = 0.1,
			AnimStyle = Enum.EasingStyle.Quad,
			AnimDirection = Enum.EasingDirection.Out,
			RootJoint = CFrame.new(0 - 0.23 * math.cos(Timing.Sine / 52.5), 1.2 + 1 * math.cos(Timing.Sine / 28), 0 + 0.2 * math.cos(Timing.Sine / 34)) * CFrame.Angles(math.rad(-(ForwardVec + ForwardVec / 5 * 20.5)), math.rad(0), math.rad(-(SideVec + SideVec / 5 * 10.21))) * CFrame.Angles(math.rad(-2 + 4 * math.cos(Timing.Sine / 32)), math.rad(0), math.rad(0 - 2.2 * math.cos(Timing.Sine/98) + 3.1 * math.cos(Timing.Sine/86))),
			RightShoulder = CFrame.new(0, 0 + 0.05 * math.cos(Timing.Sine / 28), 0) * CFrame.Angles(math.rad((ForwardVec - ForwardVec / 5 * 30.45)), math.rad(0 - 2 * math.cos(Timing.Sine / 43)), math.rad(10 - 5 * math.cos(Timing.Sine / 28))),
			LeftShoulder = CFrame.new(0, 0 + 0.05 * math.cos(Timing.Sine / 28), 0) * CFrame.Angles(math.rad((ForwardVec - ForwardVec / 5 * 30.45)), math.rad(0 + 2 * math.cos(Timing.Sine / 43)), math.rad(-10 + 5 * math.cos(Timing.Sine / 28))),
			RightHip = CFrame.new(0, 0.2, -0.5) * CFrame.Angles(math.rad(-2.5 - 4.5 * math.cos(Timing.Sine/38)), math.rad(-20), math.rad(-12.42) * SideVec - math.rad(12.42) * ForwardVec),
			LeftHip = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-4.25 - 2.3 * math.cos(Timing.Sine/22)), math.rad(20), math.rad(12.42) * SideVec - math.rad(-12.42) * ForwardVec),
			RightElbow = CFrame.Angles(math.rad(8.32 - 1.351 * math.cos(Timing.Sine / 37.2) + 9.23 * math.cos(Timing.Sine / 41.54)), math.rad(0), math.rad(0)),
			LeftElbow = CFrame.Angles(math.rad(8.51 - 1.351 * math.cos(Timing.Sine / 37.2) + 9.23 * math.cos(Timing.Sine / 41.54)), math.rad(0), math.rad(0)),
			Waist = CFrame.Angles(math.rad(-2 + 4 * math.cos(Timing.Sine / 32)), math.rad(0), math.rad((SideVec - SideVec / 5 * 10.2))),
			RightKnee = CFrame.Angles(math.rad(-12.32 - 4.42 * math.cos(Timing.Sine / 42.21)), math.rad(0), math.rad(0)),
			LeftKnee = CFrame.Angles(math.rad(-10.86 - 6.10 * math.cos(Timing.Sine / 38.1)), math.rad(0), math.rad(0))
		})
	elseif State == "Paralyzed" then
		-- Right Arm
		SetTween(RightShoulder, {
			C0 = GetC0(RightShoulder)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(RightElbow, {
			C0 = GetC0(RightElbow)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(RightWrist, {
			C0 = GetC0(RightWrist)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		--
		-- Left Arm
		SetTween(LeftShoulder, {
			C0 = GetC0(LeftShoulder)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(LeftElbow, {
			C0 = GetC0(LeftElbow)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(LeftWrist, {
			C0 = GetC0(LeftWrist)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		--
		-- Head, Torso
		SetTween(Neck, {
			C0 = GetC0(Neck)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(Waist, {
			C0 = GetC0(Waist)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(Root, {
			C0 = GetC0(Root)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		--
		-- Right Leg
		SetTween(RightHip, {
			C0 = GetC0(RightHip)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(RightKnee, {
			C0 = GetC0(RightKnee)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(RightAnkle, {
			C0 = GetC0(RightAnkle)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		--
		-- Left Leg
		SetTween(LeftHip, {
			C0 = GetC0(LeftHip)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(LeftKnee, {
			C0 = GetC0(LeftKnee)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
		SetTween(LeftAnkle, {
			C0 = GetC0(LeftAnkle)
		}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1)
	end
end
