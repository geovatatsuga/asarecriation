package com.sunweb.game.rpg.equipKindGrow
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.CommandCodePlayerEquipKindGrow;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowAddExpAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowAddExpRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowBlessAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowBlessRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowBreachAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowBreachRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowTemperAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowTemperRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowTemperSaveAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.kindGrow.KindGrowTemperSaveRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerViewItemRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class EquipKindGrowManager
   {
      
      public static var _config:Object;
      
      public function EquipKindGrowManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _config = new Object();
         _config = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(_config,["openCon"]);
      }
      
      public static function get expList() : Array
      {
         return JSONUtil.getValue(_config,["expList"]) as Array;
      }
      
      public static function get breachMap() : Object
      {
         var _loc4_:Object = null;
         var _loc1_:Array = JSONUtil.getValue(_config,["breach"]) as Array;
         if(!_loc1_ || _loc1_.length <= 0)
         {
            return null;
         }
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc2_[JSONUtil.getInt(_loc4_,["level"])] = JSONUtil.getObject(_loc4_,["needItems"]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function get kindConfig() : Array
      {
         return JSONUtil.getValue(_config,["kindConfig"]) as Array;
      }
      
      public static function get blessCode() : Object
      {
         return JSONUtil.getObject(_config,["blessCode"]);
      }
      
      public static function get temperItemCode() : Object
      {
         return JSONUtil.getObject(_config,["temperItemCode"]);
      }
      
      public static function get temperLockCode() : String
      {
         return JSONUtil.getStr(_config,["temperLockCode"]);
      }
      
      public static function get lockNeedNum() : Object
      {
         return JSONUtil.getObject(_config,["lockNeedNum"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_INFO_NOTIFY)
         {
            onKindGrowInfoNotify(param1 as KindGrowInfoNotify);
         }
         else if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_ADD_EXP_ANSWER)
         {
            onKindGrowAddExpAnswer(param1 as KindGrowAddExpAnswer);
         }
         else if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_BLESS_ANSWER)
         {
            onKindGrowBlessAnswer(param1 as KindGrowBlessAnswer);
         }
         else if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_BREACH_ANSWER)
         {
            onKindGrowBreachAnswer(param1 as KindGrowBreachAnswer);
         }
         else if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_TEMPER_ANSWER)
         {
            onKindGrowTemperAnswer(param1 as KindGrowTemperAnswer);
         }
         else if(param1.code == CommandCodePlayerEquipKindGrow.KIND_GROW_TEMPER_SAVE_ANSWER)
         {
            onKindGrowTemperSaveAnswer(param1 as KindGrowTemperSaveAnswer);
         }
      }
      
      public static function onKindGrowInfoNotify(param1:KindGrowInfoNotify) : void
      {
         var _loc3_:* = undefined;
         if(!param1 || !param1.infoList)
         {
            return;
         }
         var _loc2_:Object = new Object();
         for each(_loc3_ in param1.infoList)
         {
            _loc2_[_loc3_.kind] = _loc3_;
         }
         obf_K_e_3075.equipKindGrowUI.setKindInfoMap(_loc2_);
      }
      
      public static function onKindGrowAddExpAnswer(param1:KindGrowAddExpAnswer) : void
      {
         if(!param1 || !param1.info)
         {
            return;
         }
         var _loc2_:Object = obf_K_e_3075.equipKindGrowUI.kindInfoMap;
         if(!_loc2_)
         {
            _loc2_ = new Object();
         }
         _loc2_[param1.info.kind] = param1.info;
         obf_K_e_3075.equipKindGrowUI.setKindInfoMap(_loc2_);
         obf_K_e_3075.equipKindGrowUI.obf_r_g_3499();
         obf_K_e_3075.equipKindGrowUI.obf_v_Y_799();
         obf_K_e_3075.equipKindGrowUI.obf_0_8_7_127();
      }
      
      public static function onKindGrowBlessAnswer(param1:KindGrowBlessAnswer) : void
      {
         if(!param1 || !param1.equipId)
         {
            return;
         }
         var _loc2_:PlayerViewItemRequest = new PlayerViewItemRequest();
         _loc2_.itemId = param1.equipId;
         GameContext.worldClient.sendCommand(_loc2_);
         obf_K_e_3075.showTipInfo(DiversityManager.getString("equipKindGrowBlessUI","success"));
      }
      
      public static function onKindGrowBreachAnswer(param1:KindGrowBreachAnswer) : void
      {
         if(!param1 || !param1.info)
         {
            return;
         }
         var _loc2_:Object = obf_K_e_3075.equipKindGrowUI.kindInfoMap;
         if(!_loc2_)
         {
            _loc2_ = new Object();
         }
         _loc2_[param1.info.kind] = param1.info;
         obf_K_e_3075.equipKindGrowUI.setKindInfoMap(_loc2_);
         obf_K_e_3075.equipKindGrowUI.obf_r_g_3499();
         obf_K_e_3075.equipKindGrowUI.obf_v_Y_799();
      }
      
      public static function onKindGrowTemperAnswer(param1:KindGrowTemperAnswer) : void
      {
         if(!param1 || !param1.info)
         {
            return;
         }
         var _loc2_:Object = obf_K_e_3075.equipKindGrowUI.kindInfoMap;
         if(!_loc2_)
         {
            _loc2_ = new Object();
         }
         _loc2_[param1.info.kind] = param1.info;
         obf_K_e_3075.equipKindGrowUI.setKindInfoMap(_loc2_);
         obf_K_e_3075.equipKindGrowTemperUI.refresh();
      }
      
      public static function onKindGrowTemperSaveAnswer(param1:KindGrowTemperSaveAnswer) : void
      {
         if(!param1 || !param1.info)
         {
            return;
         }
         var _loc2_:Object = obf_K_e_3075.equipKindGrowUI.kindInfoMap;
         if(!_loc2_)
         {
            _loc2_ = new Object();
         }
         _loc2_[param1.info.kind] = param1.info;
         obf_K_e_3075.equipKindGrowUI.setKindInfoMap(_loc2_);
         obf_K_e_3075.equipKindGrowUI.obf_r_g_3499();
         obf_K_e_3075.equipKindGrowUI.obf_v_Y_799();
         obf_K_e_3075.equipKindGrowTemperUI.refresh();
      }
      
      public static function onKindGrowAddExpRequest(param1:int, param2:Array) : void
      {
         var _loc3_:KindGrowAddExpRequest = new KindGrowAddExpRequest();
         _loc3_.kind = param1;
         _loc3_.equIds = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function onKindGrowBreachRequest(param1:int) : void
      {
         var _loc2_:KindGrowBreachRequest = new KindGrowBreachRequest();
         _loc2_.kind = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function onKindGrowBlessRequest(param1:int, param2:String) : void
      {
         var _loc3_:KindGrowBlessRequest = new KindGrowBlessRequest();
         _loc3_.kind = param1;
         _loc3_.equipId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function onKindGrowTemperRequest(param1:int, param2:Array) : void
      {
         var _loc3_:KindGrowTemperRequest = new KindGrowTemperRequest();
         _loc3_.kind = param1;
         _loc3_.lockList = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function onKindGrowTemperSaveRequest(param1:int) : void
      {
         var _loc2_:KindGrowTemperSaveRequest = new KindGrowTemperSaveRequest();
         _loc2_.kind = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
   }
}

