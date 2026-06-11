package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerUseMotionRequest;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   
   public class MagicMotionManager
   {
      
      private static var magicMotion:Object = new Object();
      
      public function MagicMotionManager()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1)
         {
            magicMotion[_loc2_.code] = _loc2_;
         }
      }
      
      public static function getMagicMotionConfig(param1:String) : Object
      {
         return magicMotion[param1];
      }
      
      public static function showMagicMotion(param1:MapInteractiveObject, param2:MapInteractiveObject, param3:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc4_:Object = getMagicMotionConfig(param3);
         if(!_loc4_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4838" + param3 + "obf_______1590！");
            return;
         }
         if(Boolean(param1) && Boolean(_loc4_.myEffectCode) && _loc4_.myEffectCode != "")
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,param1,_loc4_.myEffectCode);
         }
         if(Boolean(param2) && Boolean(_loc4_.yourEffectCode) && _loc4_.yourEffectCode != "")
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,param2,_loc4_.yourEffectCode);
         }
      }
      
      public static function sendMagicMotion(param1:String) : Boolean
      {
         var _loc2_:Object = getMagicMotionConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(Boolean(_loc2_.yourEffectCode) && Boolean(_loc2_.yourEffectCode != "") && !GameContext.localPlayer.obf_0_6_a_430)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MagicMotionPrompt","needTarget"));
            return false;
         }
         if(Boolean(_loc2_.spCost) && GameContext.localPlayer.fullInfo.attributes.sp < _loc2_.spCost)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreSP"));
            return false;
         }
         var _loc3_:PlayerUseMotionRequest = new PlayerUseMotionRequest();
         _loc3_.motionCode = param1;
         if(Boolean(_loc2_.yourEffectCode) && Boolean(_loc2_.yourEffectCode != "") && Boolean(GameContext.localPlayer.obf_0_6_a_430))
         {
            _loc3_.targetId = GameContext.localPlayer.obf_0_6_a_430.id;
         }
         GameContext.worldClient.sendCommand(_loc3_);
         return true;
      }
   }
}

