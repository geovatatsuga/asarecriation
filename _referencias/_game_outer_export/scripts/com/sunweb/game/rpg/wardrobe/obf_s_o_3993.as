package com.sunweb.game.rpg.wardrobe
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.CommandCodeWardrobe;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.WardrobeAddRequest;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.WardrobeItemsNotyfy;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.WardrobeRemoveRequest;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.WardrobeUplevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.wardrobe.WardrobeUplevelRequest;
   
   public class obf_s_o_3993
   {
      
      public function obf_s_o_3993()
      {
         super();
      }
      
      public static function getWardrobeConfig() : Object
      {
         return WorldConfig.getValue("wardrobeConfig");
      }
      
      public static function sendWardrobeUplevelRequest() : void
      {
         var _loc1_:WardrobeUplevelRequest = new WardrobeUplevelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendAddRequest(param1:String) : void
      {
         var _loc2_:WardrobeAddRequest = new WardrobeAddRequest();
         _loc2_.itemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendRemoveRequest(param1:int, param2:String) : void
      {
         var _loc3_:WardrobeRemoveRequest = new WardrobeRemoveRequest();
         _loc3_.index = param1;
         _loc3_.itemId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeWardrobe.WARDRODE_ITEMS_NOYIFY)
         {
            obf_K_e_3075.obf_0___Z_558.onBagCheck((param1 as WardrobeItemsNotyfy).items);
            obf_K_e_3075.obf_0___Z_558.obf_R_2_4129((param1 as WardrobeItemsNotyfy).attrs);
         }
         else if(param1.code == CommandCodeWardrobe.WARDRODE_UPLEVEL_ANSWER)
         {
            obf_K_e_3075.obf_0___Z_558.obf_J_5_1993((param1 as WardrobeUplevelAnswer).currentCount);
            obf_K_e_3075.obf_0___Z_558.obf_k_T_4034(param1 as WardrobeUplevelAnswer);
         }
      }
   }
}

