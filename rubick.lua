local rubick = {}
rubick.lastspell = {}
rubick.spellkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Spell Key", Enum.ButtonCode.KEY_SPACE)
rubick.swapkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Swap Key", Enum.ButtonCode.KEY_X)
rubick.logical = {
    {name = "crystal_maiden_freezing_field", radius = 835},
    {name = "earthshaker_echo_slam", radius = 600},
    {name = "enigma_black_hole", radius = 420},
    {name = "faceless_void_chronosphere", radius = 425},
    {name = "tidehunter_ravage", radius = 1250}
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
    if enemy and Menu.IsKeyDown(rubick.spellkey) and not NPC.IsChannellingAbility(self) then
        if spell and Ability.IsReady(spell) then
            for _, logicspell in pairs(rubick.logical) do
                if logicspell and spell and Ability.GetName(spell) == logicspell.name then
                    islogicspell = true
                    spellradius = logicspell.radius
                    if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_CHANNELLED) ~= 0 then
                        ischannelling = true
                    else
                        ischannelling = false
                    end
                end
            end
            if not islogicspell or islogicspell and NPC.IsEntityInRange(self, enemy, spellradius - 60) then
                if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                    if Ability.GetName(spell) == "earthshaker_enchant_totem" and NPC.GetItem(self, "item_ultimate_scepter") then
                        Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
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
        if not spell or spell and not ischannelling then
            if telekinesis and Ability.IsReady(telekinesis) then
                Ability.CastTarget(telekinesis, enemy)
            end
            if fadebolt and Ability.IsReady(fadebolt) then
                Ability.CastTarget(fadebolt, enemy)
            end
        end
    end
end

return rubick