local rubick = {}
rubick.lastspell = {}
rubick.spellkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Spell Key", Enum.ButtonCode.KEY_SPACE)
rubick.swapkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Swap Key", Enum.ButtonCode.KEY_X)
rubick.logical = {
    {name = "alchemist_chemical_rage", disjoint = yes},
    {name = "centaur_hoof_stomp", radius = 315},
    {name = "crystal_maiden_freezing_field", radius = 835},
    {name = "clinkz_strafe", radius = 550, disjoint = yes},
    {name = "dark_willow_shadow_realm", radius = 600, disjoint = yes},
    {name = "earthshaker_enchant_totem", radius = 300},
    {name = "earthshaker_echo_slam", radius = 600},
    {name = "enigma_black_hole", radius = 420},
    {name = "faceless_void_chronosphere", radius = 425},
    {name = "magnataur_reverse_polarity", radius = 410},
    {name = "puck_waning_rift", disjoint = yes},
    {name = "slardar_slithereen_crush", radius = 350},
    {name = "storm_spirit_static_remnant", radius = 275},
    {name = "terrorblade_reflection", radius = 900},
    {name = "invoker_sun_strike", radius = 99999},
    {name = "tinker_heat_seeking_missile", radius = 2500},
    {name = "tidehunter_ravage", radius = 1250},
    {name = "terrorblade_reflection", radius = 900},
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
    if spell and (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_CHANNELLED) ~= 0 and Ability.IsReady(spell) or NPC.IsChannellingAbility(self) then
        ischannelling = true
    else
        ischannelling = false
    end
    if enemy and Menu.IsKeyDown(rubick.spellkey) then
        if spell and Ability.IsReady(spell) then
            local logicalrange = Ability.GetCastRange(spell)
            if logicalrange == 0 then
                for _, logicalspell in pairs(rubick.logical) do
                    if logicalspell then
                        if Ability.GetName(spell) == logicalspell.name then
                            logicalrange = logicalspell.radius
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
                logicalrange = logicalrange + 175
            end
            if Entity.GetAbsOrigin(self):Distance(Entity.GetAbsOrigin(enemy)):Length2D() < logicalrange - 75 then
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
                end
            end
        end
        if not spell or spell and not ischannelling then
            if not NPC.IsStunned(enemy) or not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
                if telekinesis and Ability.IsReady(telekinesis) then
                    Ability.CastTarget(telekinesis, enemy)
                end
            end
            if fadebolt and Ability.IsReady(fadebolt) then
                Ability.CastTarget(fadebolt, enemy)
            end
        end
    end
end

return rubick