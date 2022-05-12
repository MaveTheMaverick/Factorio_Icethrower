-- follow the flamethrower turret wherever it goes
-- there is no escape
data.raw.item["icethrower-turret"].subgroup = data.raw.item["flamethrower-turret"].subgroup
data.raw.item["icethrower-turret"].order    = data.raw.item["flamethrower-turret"].order .. "a"

local explosive_biters = {
    data.raw["turret"]["small-explosive-worm-turret"],
    data.raw["turret"]["medium-explosive-worm-turret"],
    data.raw["turret"]["big-explosive-worm-turret"],
    data.raw["turret"]["behemoth-explosive-worm-turret"],
    data.raw["turret"]["leviathan-explosive-worm-turret"],
    data.raw["unit"]["small-explosive-spitter"],
    data.raw["unit"]["medium-explosive-spitter"],
    data.raw["unit"]["big-explosive-spitter"],
    data.raw["unit"]["behemoth-explosive-spitter"],
    data.raw["unit"]["leviathan-explosive-spitter"],
    data.raw["unit"]["small-explosive-biter"],
    data.raw["unit"]["medium-explosive-biter"],
    data.raw["unit"]["big-explosive-biter"],
    data.raw["unit"]["behemoth-explosive-biter"],
    data.raw["unit"]["leviathan-explosive-biter"]
}
local explosive_mothers = {
    data.raw["turret"]["mother-explosive-worm-turret"],
    data.raw["unit"]["mother-explosive-spitter"],
    data.raw["unit"]["mother-explosive-biter"]
}

-- If explosive biters is enabled and cold biters is not, add the cold weakness to them
if mods["Explosive_biters"] and not mods["Cold_biters"] then
    for _, biter in ipairs(explosive_biters) do
        table.insert(biter.resistances,	{type = "cold",percent = -100})
    end
    if not settings.startup["eb-disable-mother"].value then
        for _, biter in ipairs(explosive_mothers) do
            table.insert(biter.resistances,	{type = "cold",percent = -100})
        end
    end
end

-- Add Cryonite Slush from Space Exploration as ammo
if data.raw["fluid"]["se-cryonite-slush"] then
    table.insert(data.raw["fluid-turret"]["icethrower-turret"].attack_parameters.fluids, {type = "se-cryonite-slush", damage_modifier = 2.2})
end

-- Add Alien Cold Extract from Frost Biters as ammo
if data.raw["fluid"]["cb_alien_cold_extract"] then
    table.insert(data.raw["fluid-turret"]["icethrower-turret"].attack_parameters.fluids, {type = "cb_alien_cold_extract", damage_modifier = 2.5})
end
