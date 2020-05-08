
local Fuze = ACF.RegisterFuze("Cluster", "Contact")
local TraceData = { start = true, endpos = true, filter = true }

Fuze.desc = "This fuze fires a beam directly ahead and releases bomblets when the beam hits something close-by.\nDistance in inches."
Fuze.Cluster = 2000

function Fuze:OnLoaded()
	Fuze.BaseClass.OnLoaded(self)

	local Config = self.Configurable

	Config[#Config + 1] = {
		Name = "Cluster",			-- name of the variable to change
		DisplayName = "Distance",	-- name displayed to the user
		CommandName = "Ds",			-- shorthand name used in console commands
		Type = "number",			-- lua type of the configurable variable
		Min = 0,					-- number specific: minimum value
		Max = 10000					-- number specific: maximum value
	}
end

function Fuze:GetDetonate(Missile)
	if not self:IsArmed() then return false end

	local Position = Missile:GetPos()

	TraceData.start = Position
	TraceData.endpos = Position + Missile:GetForward() * self.Cluster
	TraceData.filter = Missile.Filter or Missile

	return util.TraceLine(TraceData).Hit
end

function Fuze:GetDisplayConfig()
	return
	{
		Primer = math.Round(self.Primer, 1) .. " s",
		Distance = math.Round(self.Cluster / 39.37, 1) .. " m"
	}
end
