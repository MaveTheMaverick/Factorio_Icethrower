-- Icethrower
-- prototypes.damage-type

-- add cold damage type if it does not exist already

if data.raw["damage-type"]["cold"] == nil then	
    data:extend(
    {
        {
            type = "damage-type",
            name = "cold"
        },
    }
)
end

