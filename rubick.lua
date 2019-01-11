local rubick = {}
rubick.lastspell = {}
rubick.spellkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Spell Key", Enum.ButtonCode.KEY_SPACE)
rubick.swapkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Swap Key", Enum.ButtonCode.KEY_X)
rubick.logical = {
    {name = "ancient_apparition_ice_blast", radius = 99999},
    {name = "ancient_apparition_ice_blast_release", radius = 99999},
    {name = "antimage_counterspell", radius = 1000, disjoint = yes},
    {name = "abyssal_underlord_pit_of_malice", disable = yes},
    {name = "alchemist_chemical_rage", radius = 550, disjoint = yes}, -- unfinished
    {name = "alchemist_unstable_concoction", disable = yes},
    {name = "ancient_apparition_cold_feet", disable = yes},
    {name = "bane_fiends_grip", disable = yes},
    {name = "batrider_flaming_lasso", disable = yes},
    {name = "beastmaster_call_of_the_wild_boar", radius = 2500},
    -- {name = "beastmaster_call_of_the_wild", radius = 2500},  -- unfinished
    {name = "centaur_hoof_stomp", disable = yes, radius = 315},
    {name = "chaos_knight_chaos_bolt", disable = yes},
    {name = "clinkz_strafe", radius = 550, disjoint = yes},
    {name = "crystal_maiden_freezing_field", radius = 835},
    {name = "death_prophet_exorcism", radius = 1000},
    {name = "dragon_knight_dragon_tail", disable = yes},
    {name = "dragon_knight_elder_dragon_form", radius = 550},
    {name = "drow_ranger_trueshot", radius = 99999},
    {name = "dark_willow_shadow_realm", radius = 600, disjoint = yes},
    {name = "earthshaker_enchant_totem", radius = 300},
    {name = "earthshaker_echo_slam", radius = 600},
    {name = "earthshaker_fissure", disable = yes},
    {name = "enigma_malefice", disable = yes},
    {name = "enigma_black_hole", disable = yes, radius = 420},
    --{name = "faceless_void_time_dilation", radius = 675}, -- unfinished
    {name = "faceless_void_chronosphere", radius = 425},
    {name = "invoker_sun_strike", radius = 99999},
    {name = "juggernaut_blade_fury", radius = 550, disjoint = yes}, -- unfinished
    {name = "magnataur_reverse_polarity", disable = yes, radius = 410},
    {name = "invoker_cold_snap", disable = yes},
    {name = "jakiro_ice_path", disable = yes},
    {name = "keeper_of_the_light_will_o_wisp", disable = yes},
    {name = "leshrac_split_earth", disable = yes},
    {name = "leshrac_diabolic_edict", radius = 500},
    --{name = "leshrac_pulse_nova", radius = 500}, -- unfinished
    {name = "lich_sinister_gaze", disable = yes},
    {name = "lina_light_strike_array", disable = yes},
    {name = "lion_impale", disable = yes},
    {name = "lion_voodoo", disable = yes},
    {name = "luna_lucent_beam", disable = yes},
    {name = "luna_eclipse", radius = 675},
    {name = "magnataur_reverse_polarity", disable = yes},
    {name = "mirana_starfall", radius = 650},
    {name = "mirana_arrow", disable = yes},
    {name = "mirana_invis", radius = 99999},
    {name = "necrolyte_death_pulse", radius = 475},
    {name = "necrolyte_sadist", radius = 750}, -- unfinished
    {name = "nyx_assassin_impale", disable = yes},
    {name = "ogre_magi_fireblast", disable = yes},
    {name = "ogre_magi_unrefined_fireblast", disable = yes},
    --{name = "phantom_assassin_blur", radius = 1000, disjoint = yes}, -- unfinished
    {name = "puck_waning_rift", radius = 400},
    {name = "puck_phase_shift", disjoint = yes}, -- unfinished
    {name = "queenofpain_scream_of_pain", radius = 475},
    {name = "rattletrap_power_cogs", radius = 99999},
    {name = "razor_plasma_field", radius = 700},
    {name = "razor_eye_of_the_storm", radius = 550},
    {name = "sandking_burrowstrike", disable = yes},
    {name = "sandking_sand_storm", radius = 650},
    {name = "sandking_epicenter", radius = 550, blink = yes}, -- unfinished
    {name = "slark_dark_pact", radius = 325},
    {name = "slark_pounce", radius = 700},
    {name = "sniper_take_aim", radius = 99999},
    {name = "shadow_shaman_ether_shock", disable = yes},
    {name = "shadow_shaman_voodoo", disable = yes},
    {name = "skeleton_king_hellfire_blast", disable = yes},
    {name = "slardar_slithereen_crush", disable = yes},
    {name = "slardar_sprint", radius = 1000}, -- unfinished?
    {name = "storm_spirit_static_remnant", radius = 275},
    {name = "sven_storm_bolt", disable = yes},
    {name = "sven_warcry", radius = 550}, -- unfinished
    {name = "sven_gods_strength", radius = 550},
    {name = "templar_assassin_refraction", radius = 550}, -- unfinished?
    {name = "templar_assassin_meld", radius = 550},
    {name = "terrorblade_reflection", radius = 900},
    {name = "tidehunter_anchor_smash", radius = 375},
    {name = "tidehunter_ravage", radius = 1250, disable = yes, blink = yes},
    {name = "tinker_heat_seeking_missile", radius = 2500},
    --{name = "tinker_rearm", radius = 2500},
    {name = "tiny_avalanche", disable = yes},
    {name = "tusk_snowball", disable = yes},
    {name = "venomancer_poison_nova", radius = 830},
    {name = "vengefulspirit_magic_missile", disable = yes},
    {name = "windrunner_shackleshot", disable = yes},
    {name = "windrunner_windrun", radius = 1000}, -- unfinished?
    {name = "witch_doctor_paralyzing_cask", disable = yes},
    --{name = "witch_doctor_voodoo_restoration", radius = 550, heal = yes}, -- unfinished
    {name = "zuus_thundergods_wrath", radius = 99999}
}

local logicalrange = 0

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
        local logicalrange = Ability.GetCastRange(spell)
        local isdiable = false
        for _, logicalspell in pairs(rubick.logical) do
            if logicalspell then
                if Ability.GetName(spell) == logicalspell.name then
                    if logicalspell.disable == yes then
                        isdiable = true
                    else
                        isdiable = false
                    end
                    if logicalrange == 0 then
                        logicalrange = logicalspell.radius - 75
                    end
                    if logicalspell.disjoint == yes then
                        --Log.Write("isDisjoint")
                    end
                end
            end
        end
        if Ability.GetName(spell) == "riki_tricks_of_the_trade" then
            logicalrange = 450
        end
        if Ability.GetName(spell) == "pugna_nether_ward" then
            logicalrange = 1600
        end
        if Ability.GetName(spell) == "nevermore_shadowraze1" or Ability.GetName(spell) == "nevermore_shadowraze2" or Ability.GetName(spell) == "nevermore_shadowraze3" then
            logicalrange = logicalrange + 100
        end
        if enemy and Menu.IsKeyDown(rubick.spellkey) then
            if Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() < logicalrange and Ability.IsReady(spell) then
                if not isdiable or isdiable and not NPC.IsStunned(enemy) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                        if Ability.GetName(spell) == "earthshaker_enchant_totem" and NPC.GetItem(self, "item_ultimate_scepter") then
                            Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
                        elseif Ability.GetName(spell) == "riki_tricks_of_the_trade" and NPC.GetItem(self, "item_ultimate_scepter") then
                            Ability.CastTarget(spell, self)
                        elseif Ability.GetName(spell) == "nevermore_shadowraze1" 
                        or Ability.GetName(spell) == "nevermore_shadowraze2" and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > 325
                        or Ability.GetName(spell) == "nevermore_shadowraze3" and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > 575 then
                            if NPC.FindFacingNPC(self, nil, Enum.TeamType.TEAM_ENEMY, logicalrange, 5) == enemy  then
                                Ability.CastNoTarget(spell)
                            end
                        elseif Ability.GetName(spell) == "ancient_apparition_ice_blast_release" then
                            if isflying and GameRules.GetGameTime() - timer > traveltime then
                                isflying = false
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
                        or spell and isdiable and logicalrange > 0 and Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() > logicalrange then
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