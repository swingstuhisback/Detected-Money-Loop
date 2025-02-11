-- Credits to Phobos and (???) for the base script (Pessi). I only modified for maximized money loop.
gui.show_message("DML", "Your account will be flagged and will receive a delayed ban (1-3 days). Have fun!")

local TransactionManager <const> = {}; TransactionManager.__index = TransactionManager function TransactionManager.new() local instance = setmetatable({}, TransactionManager); return instance; end
---@return Int32 character
function TransactionManager:GetCharacter() local _, char = STATS.STAT_GET_INT(joaat("MPPLY_LAST_MP_CHAR"), 0, 1) return tonumber(char); end
---@param Int32 hash 
---@param Int32 category
---@return Int32 price
function TransactionManager:GetPrice(hash) return tonumber(NETSHOPPING.NET_GAMESERVER_GET_PRICE(hash, 0x57DE404E, true)) end
---@param Int32 hash 
---@param? Int32 amount 
function TransactionManager:TriggerTransaction(item_hash) script.execute_as_script("shop_controller", function() if NETSHOPPING.NET_GAMESERVER_BASKET_IS_ACTIVE() then NETSHOPPING.NET_GAMESERVER_BASKET_END() end local status, plrid = NETSHOPPING.NET_GAMESERVER_BEGIN_SERVICE(-1, 0x57DE404E, item_hash, 0x562592BB, self:GetPrice(item_hash), 2) if status then NETSHOPPING.NET_GAMESERVER_CHECKOUT_START(plrid) end end) end

function TransactionManager:Init()
    local tab = gui.get_tab("Detected Money Loop")
    local loopToggle = tab:add_checkbox("Enable Loop")
    script.register_looped("loopToggle", function(script) if(loopToggle:is_enabled()) then
            self:TriggerTransaction(0x615762F1);
            self:TriggerTransaction(0xCDCF2380);
            self:TriggerTransaction(0x9145F938);
            self:TriggerTransaction(0x610F9AB4);
            self:TriggerTransaction(0x68341DC5);
            self:TriggerTransaction(0xEE884170);
            script:sleep(5);
            self:TriggerTransaction(0x610F9AB4);
            end end) end


TransactionManager.new():Init()
