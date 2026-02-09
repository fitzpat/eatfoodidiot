--[[
* Ashita - Copyright (c) 2014 - 2017 atom0s [atom0s@live.com]
*
* This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
* To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to
* Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*
* By using Ashita, you agree to the above license and its terms.
*
*      Attribution - You must give appropriate credit, provide a link to the license and indicate if changes were
*                    made. You must do so in any reasonable manner, but not in any way that suggests the licensor
*                    endorses you or your use.
*
*   Non-Commercial - You may not use the material (Ashita) for commercial purposes.
*
*   No-Derivatives - If you remix, transform, or build upon the material (Ashita), you may not distribute the
*                    modified material. You are, however, allowed to submit the modified works back to the original
*                    Ashita project in attempt to have it added to the original project.
*
* You may not apply legal terms or technological measures that legally restrict others
* from doing anything the license permits.
*
* No warranties are given.
]] --
addon.author = 'morrowindislong';
addon.name = 'Eat food you idiot!';
addon.version = '1.0.0';

require 'common';

local default_config = {
    font = {
        family = 'Consolas',
        size = 16,
        color = math.d3dcolor(255, 255, 0, 0),
        position = {650, 650}
    },
    background = {
        color = math.d3dcolor(128, 0, 0, 0),
        visible = true
    }
};

local tp_config = default_config;
local color



ashita.events.register("load", "load_callback1", function()
    -- Load the configuration file..
    -- tp_config = ashita.settings.load_merged(addon.path .. '/settings.json', default_config);

    -- Create the font object..
    local f = AshitaCore:GetFontManager():Create('__addons_eat_food_idiot');
    f:SetColor(tp_config.font.color);
    f:SetFontFamily(tp_config.font.family);
    f:SetFontHeight(tp_config.font.size);
    f:SetPositionX(tp_config.font.position[1]);
    f:SetPositionY(tp_config.font.position[2]);
    f:SetText('');
    f:SetVisible(true);
    f:GetBackground():SetVisible(tp_config.background.visible);
    f:GetBackground():SetColor(tp_config.background.color);
end)

ashita.events.register('unload', 'unload_cb', function ()
    AshitaCore:GetFontManager():Delete('__addons_eat_food_idiot');
end)

ashita.events.register('d3d_present', 'present_cb', function ()
    local f = AshitaCore:GetFontManager():Get('__addons_eat_food_idiot')
    local buffs = AshitaCore:GetMemoryManager():GetPlayer():GetBuffs();
    local txt = ''
    local matchText = "Food";
    local foodFound = false;

    for _, buff in pairs(buffs) do
        local buffString = AshitaCore:GetResourceManager():GetString("buffs.names", buff)
        if (buffString) then
            if (buffString == matchText) then
                foodFound = true;
                break
            end
        end
    end

    if (foodFound == false) then

        if(color == '|cFFFF0000|%s|r') then
            color = '|cFF00FF00|%s|r'
        else
            color = '|cFFFF0000|%s|r'
        end

        txt = string.format(color, "         / \\\n        |\\_/|\n        |---|\n        |   |\n        |   |\n      _ |=-=| _\n  _  / \\|   |/ \\\n / \\|   |   |   ||\\\n|   |   |   |   | \\>\n|   |   |   |   |   \\\n| -   -   -   - |)   )\n|                   /\n \\                 /\n  \\               /\n   \\             /\n    \\           /\n    EAT FOOD IDIOT")
    end

    if (f ~= nil) then
        f:SetText(txt)
    end
end);
