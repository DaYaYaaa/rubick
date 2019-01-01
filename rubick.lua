local rubick = {}
rubick.lastspell = {}
rubick.spellkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick ComboKey", Enum.ButtonCode.KEY_SPACE)
rubick.swapkey = Menu.AddKeyOption({".SCRIPTS", "Rubick"}, "Rubick Swap Key", Enum.ButtonCode.KEY_X)

function rubick.OnUpdate()
    local self = Heroes.GetLocal()
    if self and NPC.GetUnitName(self) ~= "npc_dota_hero_rubick" then return end
    local telekinesis = NPC.GetAbilityByIndex(self,0)
    local fadebolt = NPC.GetAbilityByIndex(self,1)
    local spell = NPC.GetAbilityByIndex(self,3)
    local spellsteal = NPC.GetAbilityByIndex(self,5)
    if NPC.GetItem(self, "item_ultimate_scepter") then range = 1400 else range = 1000 end
    for enemyindex = 1, Heroes.Count() do
        local enemy = Heroes.Get(enemyindex)
        if enemy and not Entity.IsSameTeam(self, enemy) then
            local name = NPC.GetUnitName(enemy)
            for index = 0, 24 do
                local enemyspell = NPC.GetAbilityByIndex(enemy, index)
                if enemyspell and Ability.GetCooldown(enemyspell) > 0 then
                    rubick.lastspell[name] = Ability.GetName(enemyspell)
                end
                if spellsteal and Ability.IsReady(spellsteal) and NPC.IsEntityInRange(self, enemy, Ability.GetCastRange(spellsteal)) then
                    if enemyspell and Ability.IsInAbilityPhase(enemyspell) and spell and Ability.GetCooldown(spell) > 0 or NPC.GetAbility(self, "rubick_empty1") or Menu.IsKeyDown(rubick.swapkey) then
                        if rubick.lastspell[name] ~= nil and spell and Ability.GetName(spell) ~= rubick.lastspell[name] then
                            Ability.CastTarget(spellsteal, enemy)
                        end
                    end
                end
            end
        end
    end
    local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(self), Enum.TeamType.TEAM_ENEMY)
    if enemy and Menu.IsKeyDown(rubick.spellkey) then
        if spell and Ability.IsReady(spell) and not NPC.IsChannellingAbility(self) then
            if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                if Ability.GetName(spell) == "earthshaker_enchant_totem" and NPC.GetItem(self, "item_ultimate_scepter") then
                    Ability.CastPosition(spell, Entity.GetAbsOrigin(enemy))
                else
                    Ability.CastNoTarget(spell)
                end
            end
            if (Ability.GetBehavior(spell) & Enum.AbilityBehavior.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
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
        if telekinesis and Ability.IsReady(telekinesis) then
            Ability.CastTarget(telekinesis, enemy)
        end
        if fadebolt and Ability.IsReady(fadebolt) then
            Ability.CastTarget(fadebolt, enemy)
        end
    end
end

return rubick