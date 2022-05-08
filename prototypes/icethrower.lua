-- Icethrower
-- prototypes.icethrower

require "util"
local math3d = require "math3d"
--local sounds = require("__base__.prototypes.entity.sounds")
--local fireutil = require("__base__.prototypes.fire-util")

local ice_fire_scale = 1
--local ice_firestream_tint = {0.03, 0.06, 1, 0.9}
--local ice_firestream_tint = {0.3, 0.6, 255, 255}
local ice_fire_tint = {0.55, 0.75, 1, 0.5}

-- technology
local icethrower_tech = {
    type = "technology",
    name = "icethrower",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/flamethrower.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "icethrower-turret"
      }
    },
    prerequisites = {"flamethrower"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    order = "e-c-ba"
}

-- recipe
local icethrower_recipe = {
    type = "recipe",
    name = "icethrower-turret",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {"steel-plate", 30},
      {"iron-gear-wheel", 15},
      {"pipe", 10},
      {"engine-unit", 5}
    },
    result = "icethrower-turret"

}

-- item
local icethrower_item = {
    type = "item",
    name = "icethrower-turret",
    icon = "__base__/graphics/icons/flamethrower-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = data.raw.item["flamethrower-turret"].subgroup,
    order = data.raw.item["flamethrower-turret"].order .. "a",
    place_result = "icethrower-turret",
    stack_size = 50

}

-- entity (placer)
local icethrower_entity = {
    type = "fluid-turret",
    name = "icethrower-turret",
    icon = "__base__/graphics/icons/flamethrower-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "icethrower-turret"},
    max_health = 1400,
    corpse = "flamethrower-turret-remnants",
    collision_box = {{-0.7, -1.2 }, {0.7, 1.2}},
    selection_box = {{-1, -1.5 }, {1, 1.5}},
    rotation_speed = 0.015,
    preparing_speed = 0.08,
    --preparing_sound = sounds.flamethrower_turret_activate,
    --folding_sound = sounds.flamethrower_turret_deactivate,
    folding_speed = 0.08,
    attacking_speed = 1,
    ending_attack_speed = 0.2,
    dying_explosion = "medium-explosion",
    turret_base_has_direction = true,

    resistances =
    {
      {
        type = "cold",
        percent = 100
      }
    },

    fluid_box =
    {
      production_type = "input-output",
      secondary_draw_order = 0,
      render_layer = "lower-object",
      --pipe_picture = fireutil.flamethrower_turret_pipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      pipe_connections =
      {
        { position = {-1.5, 1.0} },
        { position = {1.5, 1.0} }
      }
    },
    fluid_buffer_size = 100,
    fluid_buffer_input_flow = 250 / 60 / 5, -- 5s to fill the buffer
    activation_buffer_ratio = 0.25,

    folded_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].folded_animation),

    preparing_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].preparing_animation),
    prepared_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].prepared_animation),
    attacking_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].attacking_animation),
    ending_attack_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].ending_attack_animation),

    folding_animation = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].folding_animation),

    not_enough_fuel_indicator_picture = indicator_pictures,
    not_enough_fuel_indicator_light = {intensity = 0.2, size = 1.5, color = {1, 0, 0}},
    enough_fuel_indicator_picture = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].enough_fuel_indicator_picture),
    enough_fuel_indicator_light = {intensity = 0.2, size = 1.5, color = {0, 1, 0}},
    out_of_ammo_alert_icon =
    {
      filename = "__core__/graphics/icons/alerts/fluid-icon-red.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      flags = {"icon"}
    },

    gun_animation_render_layer = "object",
    gun_animation_secondary_draw_order = 1,
    base_picture_render_layer = "lower-object-above-shadow",
    base_picture_secondary_draw_order = 1,
    base_picture =
    {
      north =
      {
        layers =
        {
          -- diffuse
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north.png",
            line_length = 1,
            width = 80,
            height = 96,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(-2, 14),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north.png",
              line_length = 1,
              width = 158,
              height = 196,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-1, 13),
              scale = 0.5
            }
          },
          -- mask
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-mask.png",
            flags = { "mask" },
            line_length = 1,
            width = 36,
            height = 38,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(0, 32),
            apply_runtime_tint = true,
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north-mask.png",
              flags = { "mask" },
              line_length = 1,
              width = 74,
              height = 70,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-1, 33),
              apply_runtime_tint = true,
              scale = 0.5
            }
          },
          -- shadow
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-shadow.png",
            draw_as_shadow = true,
            line_length = 1,
            width = 70,
            height = 78,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(2, 14),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-north-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 134,
              height = 152,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(3, 15),
              scale = 0.5
            }
          }
        }
      },
      east =
      {
        layers =
        {
          -- diffuse
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east.png",
            line_length = 1,
            width = 106,
            height = 72,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(-6, 2),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east.png",
              line_length = 1,
              width = 216,
              height = 146,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-6, 3),
              scale = 0.5
            }
          },
          -- mask
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-mask.png",
            flags = { "mask" },
            apply_runtime_tint = true,
            line_length = 1,
            width = 32,
            height = 42,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(-32, 0),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 66,
              height = 82,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-33, 1),
              scale = 0.5
            }
          },
          -- shadow
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-shadow.png",
            draw_as_shadow = true,
            line_length = 1,
            width = 72,
            height = 46,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(14, 8),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-east-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 144,
              height = 86,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(14, 9),
              scale = 0.5
            }
          }
        }
      },
      south =
      {
        layers =
        {
          -- diffuse
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south.png",
            line_length = 1,
            width = 64,
            height = 84,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(0, -8),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south.png",
              line_length = 1,
              width = 128,
              height = 166,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(0, -8),
              scale = 0.5
            }
          },
          -- mask
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-mask.png",
            flags = { "mask" },
            apply_runtime_tint = true,
            line_length = 1,
            width = 36,
            height = 38,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(0, -32),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 72,
              height = 72,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(0, -31),
              scale = 0.5
            }
          },
          -- shadow
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-shadow.png",
            draw_as_shadow = true,
            line_length = 1,
            width = 70,
            height = 52,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(2, 8),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-south-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 134,
              height = 98,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(3, 9),
              scale = 0.5
            }
          }
        }

      },
      west =
      {
        layers =
        {
          -- diffuse
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west.png",
            line_length = 1,
            width = 100,
            height = 74,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(8, -2),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west.png",
              line_length = 1,
              width = 208,
              height = 144,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(7, -1),
              scale = 0.5
            }
          },
          -- mask
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-mask.png",
            flags = { "mask" },
            apply_runtime_tint = true,
            line_length = 1,
            width = 32,
            height = 40,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(32, -2),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 64,
              height = 74,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(32, -1),
              scale = 0.5
            }
          },
          -- shadow
          {
            filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-shadow.png",
            draw_as_shadow = true,
            line_length = 1,
            width = 104,
            height = 44,
            frame_count = 1,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(14, 4),
            hr_version =
            {
              filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-base-west-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 206,
              height = 88,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(15, 4),
              scale = 0.5
            }
          }
        }
      }
    },

    muzzle_animation = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-muzzle-fire.png",
      line_length = 8,
      width = 17,
      height = 41,
      frame_count = 32,
      axially_symmetrical = false,
      direction_count = 1,
      blend_mode = "additive",
      scale = 0.5,
      shift = {0.015625 * 0.5, -0.546875 * 0.5 + 0.05}
    },
    muzzle_light = {size = 1.5, intensity = 0.2, color = {0.6, 0.8, 1}},

    folded_muzzle_animation_shift          = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].folded_muzzle_animation_shift),
    preparing_muzzle_animation_shift       = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].preparing_muzzle_animation_shift),
    prepared_muzzle_animation_shift        = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].prepared_muzzle_animation_shift),
    --starting_attack_muzzle_animation_shift = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1,  orientation_count = 64, progress = 1},
    attacking_muzzle_animation_shift       = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].attacking_muzzle_animation_shift),
    ending_attack_muzzle_animation_shift   = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].ending_attack_muzzle_animation_shift),
    folding_muzzle_animation_shift         = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].folding_muzzle_animation_shift),

    --vehicle_impact_sound = sounds.generic_impact,

    prepare_range = 35,
    shoot_in_prepare_state = false,
    attack_parameters =
    {
      type = "stream",
      cooldown = 4,
      range = 30,
      min_range = 6,

      turn_range = 1.0 / 3.0,
      fire_penalty = 15,

      -- lead_target_for_projectile_speed = 0.2* 0.75 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

      fluids =
      {
        {type = "water"},
      },
      fluid_consumption = 0.2,

      gun_center_shift = table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.gun_center_shift),

      gun_barrel_length = 0.4,

      ammo_type =
      {
        category = "flamethrower",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "icethrower-ice-stream",
            source_offset = {0.15, -0.5}
          }
        }
      },

      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-03.ogg",
            volume = 0.5
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-03.ogg",
            volume = 0.5
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-03.ogg",
            volume = 0.5
          }
        }
      }
    }, -- {0,  0.625}
    call_for_help_radius = 40
}

local ice_sticker =
{
  type = "sticker",
    name = "ice-sticker",
    flags = {"not-on-map"},

    animation =
    {
      filename = "__base__/graphics/entity/fire-flame/fire-flame-13.png",
      line_length = 8,
      width = 60,
      height = 118,
      frame_count = 25,
      --blend_mode = "additive",
      animation_speed = 5, --revert to 1
      scale = 0.2,
      --tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }, --{ r = 1, g = 1, b = 1, a = 0.35 },
      apply_runtime_tint = true,
      --tint = ice_fire_tint,
      shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1),
      draw_as_glow = true
    },

    duration_in_ticks = 30 * 60,
    damage_interval = 10,
    target_movement_modifier = 0.45,
    damage_per_tick = { amount = 1 / 6, type = "cold" },
    --spread_fire_entity = "fire-flame-on-tree",
    fire_spread_cooldown = 30,
    fire_spread_radius = 0.75
}

local stream_sprites =
{
  spine_animation = util.draw_as_glow
  {
    filename = "__Icethrower__/graphics/flamethrower-fire-stream-spine.png",
    --blend_mode = "additive",
    --tint = {r=1, g=1, b=1, a=0.5},
    --apply_runtime_tint = true,
    tint = ice_fire_tint,
    line_length = 4,
    width = 32,
    height = 18,
    frame_count = 32,
    axially_symmetrical = false,
    direction_count = 1,
    animation_speed = 2,
    shift = {0, 0}
  },

  shadow =
  {
    filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
    line_length = 5,
    width = 28,
    height = 16,
    frame_count = 33,
    priority = "high",
    shift = {-0.09, 0.395}
  },

  particle = util.draw_as_glow
  {
    filename = "__Icethrower__/graphics/flamethrower-explosion.png",
    --blend_mode = "additive",
    --apply_runtime_tint = true,
    tint = ice_fire_tint,
    priority = "extra-high",
    width = 64,
    height = 64,
    frame_count = 32,
    line_length = 8
  }
}

local icethrower_ice_stream = {
    type = "stream",
    name = "icethrower-ice-stream",
    flags = {"not-on-map"},
    --stream_light = {intensity = 1, size = 4},
    --ground_light = {intensity = 0.8, size = 4},

    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.005, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60,
        --tint = ice_fire_tint
      }
    },
    particle_buffer_size = 90,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 8,
    particle_vertical_acceleration = 0.005 * 0.60,
    particle_horizontal_speed = 0.2* 0.75 * 1.5,
    particle_horizontal_speed_deviation = 0.005 * 0.70,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "area",
        radius = 2.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "ice-sticker",
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = 2 / 60, type = "cold" },
              apply_damage_to_trees = false
            }
          }
        }
      },
      --[[
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "ice-flame",
              show_in_tooltip = true
            }
          }
        }
      }
      ]]
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "ice-flame",
              tile_collision_mask = { "water-tile" },
              show_in_tooltip = true
            }
          }
        }
      }
    },
    spine_animation = stream_sprites.spine_animation,
    shadow = stream_sprites.shadow,
    particle = stream_sprites.particle
}

--[[
data:extend({
  --fireutil.add_basic_fire_graphics_and_effects_definitions
  {
    type = "fire",
    name = "ice-flame",
    flags = {"placeable-off-grid", "not-on-map"},
    damage_per_tick = {amount = 13 / 60, type = "cold"},
    maximum_damage_multiplier = 6,
    damage_multiplier_increase_per_added_fuel = 1,
    damage_multiplier_decrease_per_tick = 0.005,
  
    emissions_per_second = 0.005,
  
    initial_lifetime = 120,
    lifetime_increase_by = 150,
    lifetime_increase_cooldown = 4,
    maximum_lifetime = 1800,
    delay_between_initial_flames = 10,
    --initial_flame_count = 1,
  
  }
})
]]

local ice_flame = {
  type = "fire",
  name = "ice-flame",
  --localised_name = {"entity-name.acid-splash"},
  flags = {"placeable-off-grid", "not-on-map"},
  damage_per_tick = {amount = 1 / 60, type = "cold"},
  maximum_damage_multiplier = 4,
  damage_multiplier_increase_per_added_fuel = 1,
  damage_multiplier_decrease_per_tick = 0.005,

  --spawn_entity = "fire-flame-on-tree",
  uses_alternative_behavior = true,
  limit_overlapping_particles = true,
  initial_render_layer = "object",
  render_layer = "lower-object-above-shadow",
  secondary_render_layer = "higher-object-above",
  secondary_picture_fade_out_start = 30,
  secondary_picture_fade_out_duration = 60,

  spread_delay = 300,
  spread_delay_deviation = 180,
  maximum_spread_count = 100,

  particle_alpha = 0.6,
  particle_alpha_blend_duration = 60*5,
  --flame_alpha = 0.35,
  --flame_alpha_deviation = 0.05,

  emissions_per_second = 0,

  add_fuel_cooldown = 10,
  fade_in_duration = 1,
  fade_out_duration = 30,

  initial_lifetime = 60*4,--120,
  lifetime_increase_by = 0,
  lifetime_increase_cooldown = 4,
  maximum_lifetime = 1800,
  delay_between_initial_flames = 10,
  initial_flame_count = 1,
  burnt_patch_lifetime = 0,

  --[[
  on_damage_tick_effect =
  {
    type = "direct",
    --force = "enemy",
    ignore_collision_condition = true,
    trigger_target_mask = { "ground-unit" },
    filter_enabled = true,
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
          type = "damage",
          damage = { amount = 2 / 60, type = "cold" },
          apply_damage_to_trees = false
      }
    }
  },
  ]]

  pictures =
  {
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
          draw_as_glow = true,
          line_length = 8,
          direction_count = 1,
          width = 106,
          height = 116,
          frame_count = 26,
          shift = util.mul_shift(util.by_pixel(-12, -10), ice_fire_scale),
          tint = ice_fire_tint,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 210,
            height = 224,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(-12, -8), ice_fire_scale),
            tint = ice_fire_tint,
            scale = 0.5 * ice_fire_scale
          }
        },
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
          line_length = 8,
          direction_count = 1,
          width = 134,
          height = 98,
          frame_count = 26,
          shift = util.mul_shift(util.by_pixel(2, 0), ice_fire_scale),
          draw_as_shadow = true,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 266,
            height = 188,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(2, 2), ice_fire_scale),
            draw_as_shadow = true,
            scale = 0.5 * ice_fire_scale
          }
        }
      }
    },
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
          draw_as_glow = true,
          line_length = 8,
          direction_count = 1,
          width = 88,
          height = 76,
          frame_count = 29,
          shift = util.mul_shift(util.by_pixel(-10, -18), ice_fire_scale),
          tint = ice_fire_tint,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 174,
            height = 150,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(-9, -17), ice_fire_scale),
            tint = ice_fire_tint,
            scale = 0.5 * ice_fire_scale
          }
        },
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
          line_length = 8,
          direction_count = 1,
          width = 120,
          height = 136,
          frame_count = 29,
          shift = util.mul_shift(util.by_pixel(6, 28), ice_fire_scale),
          draw_as_shadow = true,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 238,
            height = 266,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(6, 29), ice_fire_scale),
            draw_as_shadow = true,
            scale = 0.5 * ice_fire_scale
          }
        }
      }
    },
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
          draw_as_glow = true,
          line_length = 8,
          direction_count = 1,
          width = 118,
          height = 104,
          frame_count = 29,
          shift = util.mul_shift(util.by_pixel(22, -16), ice_fire_scale),
          tint = ice_fire_tint,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 236,
            height = 208,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(22, -16), ice_fire_scale),
            tint = ice_fire_tint,
            scale = 0.5 * ice_fire_scale
          }
        },
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
          line_length = 8,
          direction_count = 1,
          width = 110,
          height = 70,
          frame_count = 29,
          shift = util.mul_shift(util.by_pixel(16, 2), ice_fire_scale),
          draw_as_shadow = true,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 214,
            height = 140,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(17, 2), ice_fire_scale),
            draw_as_shadow = true,
            scale = 0.5 * ice_fire_scale
          }
        }
      }
    },
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
          draw_as_glow = true,
          line_length = 8,
          direction_count = 1,
          width = 128,
          height = 80,
          frame_count = 24,
          shift = util.mul_shift(util.by_pixel(16, -20), ice_fire_scale),
          tint = ice_fire_tint,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 252,
            height = 154,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(17, -19), ice_fire_scale),
            tint = ice_fire_tint,
            scale = 0.5 * ice_fire_scale
          }
        },
        {
          filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
          line_length = 8,
          direction_count = 1,
          width = 124,
          height = 80,
          frame_count = 24,
          shift = util.mul_shift(util.by_pixel(18, -16), ice_fire_scale),
          draw_as_shadow = true,
          scale = ice_fire_scale,
          hr_version =
          {
            filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 248,
            height = 160,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(18, -16), ice_fire_scale),
            draw_as_shadow = true,
            scale = 0.5 * ice_fire_scale
          }
        }
      }
    }
  }
}

data:extend({
    icethrower_tech,
    icethrower_recipe,
    icethrower_item,
    icethrower_entity,
    ice_sticker,
    icethrower_ice_stream,
    ice_flame
})
