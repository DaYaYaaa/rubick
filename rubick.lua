local rubick = {}
rubick.lastspell = {}
rubick.spellkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Spell Key", Enum.ButtonCode.KEY_SPACE)
rubick.swapkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Swap Key", Enum.ButtonCode.KEY_X)
rubick.library = {
    {name = "ancient_apparition_ice_blast", radius = 99999},
    {name = "ancient_apparition_ice_blast_release", radius = 99999},
    {name = "antimage_counterspell", radius = 1000, type = "disjoint"},
    {name = "abyssal_underlord_pit_of_malice", type = "disable"},
    {name = "alchemist_unstable_concoction", type = "disable"}, -- unfinished
    {name = "alchemist_unstable_concoction_throw", type = "disable"}, -- unfinished
    {name = "alchemist_chemical_rage", radius = 550, type = "disjoint"}, -- unfinished
    {name = "alchemist_unstable_concoction", type = "disable"},
    {name = "ancient_apparition_cold_feet", type = "disable"},
    {name = "axe_berserkers_call", radius = 300},
    {name = "bane_fiends_grip", type = "disable"},
    {name = "batrider_firefly", radius = 550},
    {name = "batrider_flaming_lasso", type = "disable"},
    {name = "beastmaster_call_of_the_wild_boar", radius = 1200},
    --{name = "beastmaster_call_of_the_wild", radius = 2500},  -- unfinished
    {name = "beastmaster_primal_roar", type = "disable"},
    {name = "brewmaster_thunder_clap", radius = 400},
    {name = "brewmaster_drunken_brawler", radius = 550},
    {name = "brewmaster_primal_split", radius = 550},
    {name = "bristleback_quill_spray", radius = 650},
    {name = "bounty_hunter_wind_walk", radius = 1200},  -- unfinished
    {name = "broodmother_insatiable_hunger", radius = 550},
    {name = "centaur_hoof_stomp", type = "disable", radius = 315},
    {name = "centaur_stampede", radius = 99999},
    {name = "chaos_knight_chaos_bolt", type = "disable"},
    {name = "chaos_knight_phantasm", radius = 550},
    {name = "chen_hand_of_god", radius = 99999, heal = "yes"},
    {name = "clinkz_strafe", radius = 550, type = "disjoint"},
    {name = "clinkz_wind_walk", radius = 2000}, -- unfinished
    {name = "crystal_maiden_freezing_field", radius = 835},
    {name = "dark_willow_shadow_realm", radius = 600, type = "disjoint"},
    {name = "dark_willow_bedlam", radius = 300},
    {name = "death_prophet_exorcism", radius = 1000},
    {name = "doom_bringer_scorched_earth", radius = 600},
    {name = "dragon_knight_dragon_tail", type = "disable"},
    {name = "dragon_knight_elder_dragon_form", radius = 550},
    {name = "drow_ranger_trueshot", radius = 99999},
    {name = "ember_spirit_searing_chains", radius = 400},
    {name = "ember_spirit_flame_guard", radius = 400},
    {name = "earthshaker_fissure", type = "disable"},
    {name = "earthshaker_enchant_totem", radius = 300},
    {name = "earthshaker_echo_slam", radius = 600},
    {name = "enchantress_natures_attendants", radius = 900, heal = "yes"},
    {name = "enigma_malefice", type = "disable"},
    {name = "enigma_black_hole", type = "disable", radius = 420, blink = true},
    --{name = "faceless_void_time_dilation", radius = 675}, -- unfinished
    {name = "faceless_void_chronosphere", radius = 425},
    {name = "gyrocopter_rocket_barrage", radius = 400},
    {name = "gyrocopter_flak_cannon", radius = 1250},
    {name = "huskar_inner_fire", radius = 500},
    {name = "invoker_forge_spirit", radius = 1200},
    --{name = "invoker_ghost_walk", radius = 3000}, -- unfinished
    {name = "invoker_ice_wall", radius = 700}, -- unfinished?
    {name = "invoker_sun_strike", radius = 99999},
    {name = "juggernaut_blade_fury", radius = 550, type = "disjoint"}, -- unfinished
    {name = "magnataur_reverse_polarity", type = "disable", radius = 410},
    {name = "invoker_cold_snap", type = "disable"},
    {name = "jakiro_ice_path", type = "disable"},
    {name = "keeper_of_the_light_will_o_wisp", type = "disable"},
    {name = "leshrac_split_earth", type = "disable"},
    {name = "leshrac_diabolic_edict", radius = 500},
    --{name = "leshrac_pulse_nova", radius = 500}, -- unfinished
    {name = "lich_sinister_gaze", type = "disable"},
    {name = "life_stealer_rage", radius = 550, type = "disjoint"}, -- unfinished
    {name = "lina_light_strike_array", type = "disable"},
    {name = "lion_impale", type = "disable"},
    {name = "lion_voodoo", type = "disable"},
    {name = "lone_druid_spirit_bear", radius = 99999},
    {name = "lone_druid_spirit_link", radius = 550},
    {name = "lone_druid_savage_roar", radius = 325},
    {name = "lone_druid_true_form_battle_cry", radius = 550},
    {name = "luna_lucent_beam", type = "disable"},
    {name = "luna_eclipse", radius = 675},
    {name = "lycan_summon_wolves", radius = 1000},
    {name = "lycan_howl", radius = 3000},
    {name = "lycan_shapeshift", radius = 550},
    {name = "magnataur_reverse_polarity", type = "disable"},
    {name = "medusa_stone_gaze", radius = 1000},
    {name = "mirana_starfall", radius = 650},
    {name = "mirana_arrow", type = "disable"},
    {name = "mirana_invis", radius = 99999},
    {name = "monkey_king_boundless_strike", type = "disable"},
    {name = "monkey_king_mischief", radius = 550, type = "disjoint"},
    {name = "naga_siren_mirror_image", radius = 550},
    --{name = "naga_siren_song_of_the_siren", radius = 1400}, -- unfinished
    {name = "necrolyte_death_pulse", radius = 475},
    {name = "necrolyte_sadist", radius = 750}, -- unfinished
    {name = "night_stalker_crippling_fear", radius = 375},
    {name = "nyx_assassin_impale", type = "disable"},
    {name = "nyx_assassin_spiked_carapace", radius = 550}, -- unfinished
    {name = "nyx_assassin_vendetta", radius = 99999},
    {name = "obsidian_destroyer_equilibrium", radius = 550},
    {name = "ogre_magi_fireblast", type = "disable"},
    {name = "ogre_magi_unrefined_fireblast", type = "disable"},
    {name = "omniknight_guardian_angel", radius = 1200},
    {name = "pangolier_shield_crash", radius = 500},
    {name = "pangolier_gyroshell", radius = 550},
    --{name = "pangolier_gyroshell_stop", radius = 550},
    --{name = "phantom_assassin_blur", radius = 1000, type = "disjoint"}, -- unfinished
    {name = "phoenix_icarus_dive", radius = 1400},
    --{name = "phoenix_supernova", radius = 1300}, -- unfinished
    {name = "puck_waning_rift", radius = 400},
    {name = "puck_phase_shift", type = "disjoint"}, -- unfinished
    {name = "queenofpain_scream_of_pain", radius = 475},
    {name = "rattletrap_power_cogs", radius = 99999},
    {name = "razor_plasma_field", radius = 700},
    {name = "razor_eye_of_the_storm", radius = 550},
    {name = "sandking_burrowstrike", type = "disable"},
    {name = "sandking_sand_storm", radius = 650},
    {name = "sandking_epicenter", radius = 550, blink = true}, -- unfinished
    {name = "shadow_shaman_ether_shock", type = "disable"},
    {name = "shadow_shaman_voodoo", type = "disable"},
    {name = "shredder_whirling_death", radius = 300},
    --{name = "shredder_return_chakram", special = "yes"}, -- unfinished
    --{name = "shredder_return_chakram_2", special = "yes"}, -- unfinished
    {name = "silencer_global_silence", radius = 99999}, -- unfinished
    {name = "skeleton_king_hellfire_blast", type = "disable"},
    {name = "slardar_slithereen_crush", type = "disable"},
    {name = "slardar_sprint", radius = 1000}, -- unfinished?
    {name = "slark_dark_pact", radius = 325},
    {name = "slark_pounce", radius = 700},
    {name = "slark_shadow_dance", radius = 550},
    {name = "sniper_take_aim", radius = 99999},
    --{name = "spectre_haunt", radius = 99999}, -- unfinished
    {name = "spirit_breaker_bulldoze", radius = 1500},
    {name = "storm_spirit_static_remnant", radius = 275},
    {name = "sven_storm_bolt", type = "disable"},
    {name = "sven_warcry", radius = 550}, -- unfinished
    {name = "sven_gods_strength", radius = 550},
    {name = "templar_assassin_refraction", radius = 550}, -- unfinished?
    {name = "templar_assassin_meld", radius = 550},
    {name = "terrorblade_reflection", radius = 900},
    {name = "terrorblade_conjure_image", radius = 550},
    {name = "terrorblade_metamorphosis", radius = 550},
    {name = "tidehunter_anchor_smash", radius = 375},
    {name = "tidehunter_ravage", radius = 1250, type = "disable", blink = true},
    {name = "tinker_heat_seeking_missile", radius = 2500},
    --{name = "tinker_rearm", radius = 2500},
    {name = "tiny_avalanche", type = "disable"},
    {name = "treant_overgrowth", radius = 800},
    {name = "troll_warlord_whirling_axes_melee", radius = 450},
    --{name = "troll_warlord_battle_trance", radius = 550}, -- unfinished
    {name = "tusk_snowball", type = "disable"},
    {name = "tusk_tag_team", radius = 350},
    {name = "undying_flesh_golem", radius = 550},
    {name = "ursa_earthshock", radius = 385},
    {name = "ursa_overpower", radius = 550},
    {name = "ursa_enrage", radius = 550},
    {name = "venomancer_poison_nova", radius = 830},
    {name = "vengefulspirit_magic_missile", type = "disable"},
    {name = "visage_summon_familiars", radius = 99999},
    {name = "weaver_shukuchi", radius = 1200}, -- unfinished
    --{name = "weaver_time_lapse", radius = 1200, heal = "yes"}, -- unfinished
    {name = "windrunner_shackleshot", type = "disable"},
    {name = "windrunner_windrun", radius = 1000}, -- unfinished?
    {name = "wisp_spirits", radius = 700},
    {name = "witch_doctor_paralyzing_cask", type = "disable"},
    --{name = "witch_doctor_voodoo_restoration", radius = 550, heal = "yes"}, -- unfinished
    {name = "zuus_thundergods_wrath", radius = 99999}
}

function rubick.OnUpdate()
    local self = Heroes.GetLocal()
    if self and NPC.GetUnitName(self) ~= "npc_dota_hero_rubick" then return end
    local telekinesis = NPC.GetAbilityByIndex(self,0)
    local fadebolt = NPC.GetAbilityByIndex(self,1)
    local spell = NPC.GetAbilityByIndex(self,3)
    local spellsteal = NPC.GetAbilityByIndex(self,5)
    if NPC.GetAbility(self, "special_bonus_cast_range_125") and Ability.GetLevel(NPC.GetAbility(self, "special_bonus_cast_range_125")) > 0 then
        range = Ability.GetCastRange(spellsteal) + 125
    else
        range = Ability.GetCastRange(spellsteal)
    end
    for enemyindex = 1, Heroes.Count() do
        local enemy = Heroes.Get(enemyindex)
        if enemy and not Entity.IsSameTeam(self, enemy) and not NPC.IsChannellingAbility(self) then
            local name = NPC.GetUnitName(enemy)
            for abilityindex = 0, 24 do
                local enemyspell = NPC.GetAbilityByIndex(enemy, abilityindex)
                if enemyspell and Ability.GetCooldown(enemyspell) > 0  then
                    if spellsteal and Ability.IsReady(spellsteal) and NPC.IsEntityInRange(self, enemy, range) then
                        if Ability.GetCooldown(enemyspell) > 0 and spell and Ability.GetCooldown(spell) > 0 or NPC.GetAbility(self, "rubick_empty1") or Menu.IsKeyDown(rubick.swapkey) then
                            if spell and Ability.GetName(spell) ~= Ability.GetName(enemyspell) and (not rubick.lastspell[Ability.GetName(enemyspell)] or GameRules.GetGameTime() - rubick.lastspell[Ability.GetName(enemyspell)] > Ability.GetCooldownLength(enemyspell)) then
                                Ability.CastTarget(spellsteal, enemy)
                                rubick.lastspell[Ability.GetName(enemyspell)] = GameRules.GetGameTime()
                            end
                        end
                    end
                end
            end
        end
    end
    local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(self), Enum.TeamType.TEAM_ENEMY)
    if spell then
        if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_CHANNELLED) ~= 0 and Ability.IsReady(spell) or NPC.IsChannellingAbility(self) then
            ischannelling = true
        else
            ischannelling = false
        end
        local distance = Ability.GetCastRange(spell)
        local isdiable = false
        for _, library in pairs(rubick.library) do
            if library then
                if Ability.GetName(spell) == library.name then
                    if library.type == "disable" then isdiable = true else isdiable = false end
                    if library.type == "disjoint" then end
                    if distance == 0 or distance == 125 then distance = library.radius - 75 end
                end
            end
        end
        if Ability.GetName(spell) == "riki_tricks_of_the_trade" then distance = 450 end
        if Ability.GetName(spell) == "pugna_nether_ward" then distance = 1600 end
        if Ability.GetName(spell) == "nevermore_shadowraze1" or Ability.GetName(spell) == "nevermore_shadowraze2" or Ability.GetName(spell) == "nevermore_shadowraze3" then distance = distance + 150 end
        if enemy and Menu.IsKeyDown(rubick.spellkey) then
            if Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() < distance and Ability.IsReady(spell) then
                if not isdiable or isdiable and not NPC.IsStunned(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                        if Ability.GetName(spell) == "earthshaker_enchant_totem" and NPC.GetItem(self, "item_ultimate_scepter") then Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
                        elseif Ability.GetName(spell) == "riki_tricks_of_the_trade" and NPC.GetItem(self, "item_ultimate_scepter") then Ability.CastTarget(spell, self)
                        elseif Ability.GetName(spell) == "chaos_knight_phantasm" and NPC.GetItem(self, "item_ultimate_scepter") then Ability.CastTarget(spell, self)
                        elseif Ability.GetName(spell) == "luna_eclipse" and NPC.GetItem(self, "item_ultimate_scepter") then Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
                        elseif Ability.GetName(spell) == "nevermore_shadowraze1" or Ability.GetName(spell) == "nevermore_shadowraze2" or Ability.GetName(spell) == "nevermore_shadowraze3" then
                            if Ability.GetName(spell) == "nevermore_shadowraze1" 
                            or Ability.GetName(spell) == "nevermore_shadowraze2" and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > 325
                            or Ability.GetName(spell) == "nevermore_shadowraze3" and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > 575 then
                                if NPC.FindFacingNPC(self, nil, Enum.TeamType.TEAM_ENEMY, distance, 5) == enemy  then
                                    Ability.CastNoTarget(spell)
                                end
                            end
                        elseif Ability.GetName(spell) == "ancient_apparition_ice_blast_release" then
                            if GameRules.GetGameTime() - timer > traveltime then
                                Ability.CastNoTarget(spell)
                            end
                        else
                            Ability.CastNoTarget(spell)
                        end
                    end
                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                        if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_AOE) ~= 0 then
                            Ability.CastTarget(spell, enemy)
                        end
                        if (Ability.GetTargetTeam(spell) & Enum.TargetTeam.DOTA_UNIT_TARGET_TEAM_ENEMY) ~= 0 then
                            Ability.CastTarget(spell, enemy)
                        else
                            Ability.CastTarget(spell, self)
                        end
                    end
                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
                        if Ability.GetName(spell) == "pugna_nether_ward" then
                            Ability.CastPosition(spell, Entity.GetAbsOrigin(self))
                        else
                            if Ability.GetName(spell) == "pudge_meat_hook" then
                                for i = 1, math.floor((Entity.GetAbsOrigin(self) - Entity.GetAbsOrigin(enemy)):Length2D() / 125) do
                                    local isblocked = false
                                    for _, unit in ipairs(NPCs.InRadius(Entity.GetAbsOrigin(self) + (Entity.GetAbsOrigin(enemy) - Entity.GetAbsOrigin(self)):Normalized():Scaled(i * 125), 125, Entity.GetTeamNum(self), Enum.TeamType.TEAM_BOTH)) do
                                        if unit and Entity.IsNPC(unit) and unit ~= enemy and unit ~= self and Entity.IsAlive(unit) and not Entity.IsDormant(unit) and not NPC.IsStructure(unit) and not NPC.IsBarracks(unit) and not NPC.IsWaitingToSpawn(unit) and NPC.GetUnitName(unit) ~= "npc_dota_neutral_caster" and NPC.GetUnitName(unit) ~= nil then
                                            isblocked = true
                                            break
                                        end
                                    end
                                    if isblocked then
                                        return false
                                    end	
                                end
                            end
                            if not isblocked and Ability.GetName(spell) == "pudge_meat_hook" and NPC.FindFacingNPC(self, nil, Enum.TeamType.TEAM_ENEMY, nil, 15) == enemy or Ability.GetName(spell) ~= "pudge_meat_hook" then
                                if NPC.IsRunning(enemy) then
                                    local speed = NPC.GetMoveSpeed(enemy)
                                    local angle = Entity.GetRotation(enemy)
                                    local offset = Angle(0, 45, 0)
                                    angle:SetYaw(angle:GetYaw() + offset:GetYaw())
                                    local x,y,z = angle:GetVectors()
                                    local direction = x + y + z
                                    direction:SetZ(0)
                                    direction:Normalize()
                                    if Ability.GetName(spell) == "invoker_sun_strike" then
                                        direction:Scale(speed * 2)
                                    elseif Ability.GetName(spell) == "ancient_apparition_ice_blast" then
                                        direction:Scale(speed * 2)
                                    else
                                        direction:Scale(speed)
                                    end
                                    local origin = NPC.GetAbsOrigin(enemy)
                                    local pos = origin + direction
                                    Ability.CastPosition(spell, pos)
                                else
                                    Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
                                end
                            end
                            if not isflying and Ability.GetName(spell) == "ancient_apparition_ice_blast" and Ability.IsInAbilityPhase(spell) then
                                isflying = true
                                timer = GameRules.GetGameTime()
                                traveltime = Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() / 1500
                            end
                        end
                    end
                end
            end
            if not spell or spell and not ischannelling then
                if not NPC.IsStunned(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
                    if telekinesis and Ability.IsReady(telekinesis) then
                        if not spell
                        or not isdiable
                        or spell and isdiable and Ability.GetCooldownLength(spell) - Ability.GetCooldownTimeLeft(spell) > 1
                        or spell and isdiable and distance > 0 and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > distance then
                            Ability.CastTarget(telekinesis, enemy)
                        end
                    end
                end
                if fadebolt and Ability.IsReady(fadebolt) then
                    Ability.CastTarget(fadebolt, enemy)
                end
            end
        end
    end
end

return rubick