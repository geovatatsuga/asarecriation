package com.sunweb.game.rpg.soulGuard
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.CommandCodeSoulGuard;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.SoulBlessUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.SoulBlessUpRequest;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.SoulGuardInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.SoulGuardUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.soulGuard.SoulGuardUpRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import img.SoulGuardStar;
   
   public class obf_4_3841
   {
      
      public static var soulGuardConfig:Object;
      
      public function obf_4_3841()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         soulGuardConfig = param1;
      }
      
      public static function get soulGuardOpenCond() : Object
      {
         return JSONUtil.getObject(soulGuardConfig,["openCondition"]);
      }
      
      public static function soulGuardJobList(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getObject(soulGuardConfig,["jobList"]) as Array;
         if(_loc2_)
         {
            return _loc2_[param1];
         }
         return null;
      }
      
      public static function soulGuardUpBlessItemCode() : String
      {
         return JSONUtil.getStr(soulGuardConfig,["upBlessItemCode"]);
      }
      
      public static function soulGuardUpBlessItemNums(param1:int) : int
      {
         var _loc2_:Array = JSONUtil.getObject(soulGuardConfig,["upBlessItemNums"]) as Array;
         if(_loc2_)
         {
            return _loc2_[param1];
         }
         return 0;
      }
      
      public static function soulGuardSoulBlessAttrs(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getObject(soulGuardConfig,["soulBlessAttrs"]) as Array;
         if(_loc2_)
         {
            return _loc2_[param1];
         }
         return null;
      }
      
      public static function getSoulGuardStarLevelDisplay(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc7_:SoulGuardStar = null;
         var _loc8_:SoulGuardStar = null;
         var _loc3_:int = 40;
         var _loc4_:int = 10;
         var _loc5_:Sprite = new Sprite();
         var _loc6_:int = 1;
         while(_loc6_ <= _loc4_)
         {
            if(_loc6_ <= param1)
            {
               _loc7_ = new SoulGuardStar();
               _loc7_.x = (_loc6_ - 1) * _loc3_;
               _loc7_.scaleX = 1.5;
               _loc7_.scaleY = 1.5;
               _loc5_.addChild(_loc7_);
            }
            else
            {
               if(!param2)
               {
                  break;
               }
               _loc8_ = new SoulGuardStar();
               _loc8_.filters = [obf_9_V_1635.getGrayFilter()];
               _loc8_.x = (_loc6_ - 1) * _loc3_;
               _loc8_.scaleX = 1.5;
               _loc8_.scaleY = 1.5;
               _loc5_.addChild(_loc8_);
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function sendSoulGuardUpReq(param1:int) : void
      {
         var _loc2_:SoulGuardUpRequest = new SoulGuardUpRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendSoulBlessUpReq(param1:int) : void
      {
         var _loc2_:SoulBlessUpRequest = new SoulBlessUpRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeSoulGuard.SOUL_GUARD_UP_ANSWER)
         {
            obf_0_2_w_380(param1 as SoulGuardUpAnswer);
         }
         else if(param1.code == CommandCodeSoulGuard.SOUL_BLESS_UP_ANSWER)
         {
            obf_h_O_1198(param1 as SoulBlessUpAnswer);
         }
         else if(param1.code == CommandCodeSoulGuard.SOUL_GUARD_INFO_NOTIFY)
         {
            obf_D_8_2749(param1 as SoulGuardInfoNotify);
         }
      }
      
      private static function obf_0_2_w_380(param1:SoulGuardUpAnswer) : void
      {
         if(param1.isSuccess)
         {
            WindowManager.showMessageBox(DiversityManager.getString("SoulGuardUI","prompt_SouleComplete"));
            obf_K_e_3075.soulGuardUI.soulGuardInfo(param1.info);
            obf_K_e_3075.soulGuardUI.showSoulGuardInfo(param1.info.type);
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("SoulGuardUI","prompt_SoulFail"));
         }
      }
      
      private static function obf_h_O_1198(param1:SoulBlessUpAnswer) : void
      {
         obf_K_e_3075.soulGuardUI.soulGuardInfo(param1.info);
         obf_K_e_3075.soulGuardUI.showBiHuInfo(param1.info.type,param1.info.blessLevel);
      }
      
      private static function obf_D_8_2749(param1:SoulGuardInfoNotify) : void
      {
         obf_K_e_3075.soulGuardUI.showSoulGuardList(param1.soulGuardList);
      }
   }
}

