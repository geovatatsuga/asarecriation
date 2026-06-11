package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.npc.CommandCodeNpc;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.geom.Point;
   import mcRes.AddLuckStarEffect;
   import mcRes.AssembleLuckBox;
   
   public class obf_x_c_2855
   {
      
      public static var configList:Array;
      
      private static var materialMapConfig:Object;
      
      private static var starLevelValue:Array;
      
      private static var configObj:Object = new Object();
      
      private static var obf_0_2_a_674:Object = new Object();
      
      public function obf_x_c_2855()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         configList = param1;
         configObj = new Object();
         materialMapConfig = new Object();
         for each(_loc2_ in param1)
         {
            if(!configObj[_loc2_.type])
            {
               configObj[_loc2_.type] = new Object();
            }
            _loc3_ = configObj[_loc2_.type];
            _loc4_ = JSONUtil.getStr(_loc2_,["subtype"]);
            if(_loc4_ == "")
            {
               _loc4_ = DiversityManager.getString("AssembleBoxUI","noType");
            }
            if(!_loc3_[_loc4_])
            {
               _loc3_[_loc4_] = new Array();
            }
            _loc5_ = _loc3_[_loc4_];
            _loc5_.push(_loc2_);
            obf_0_2_a_674[_loc2_.ruleIndex] = _loc2_;
            for(_loc6_ in _loc2_.baseItems)
            {
               if(!materialMapConfig[_loc6_])
               {
                  materialMapConfig[_loc6_] = new Array();
               }
               materialMapConfig[_loc6_].push(_loc2_.ruleIndex);
            }
         }
         initLuckStar();
      }
      
      public static function getMaterialAssembleList(param1:String) : Array
      {
         return JSONUtil.getObject(materialMapConfig,[param1]) as Array;
      }
      
      public static function getConfigInMaterialMap(param1:String, param2:int) : Object
      {
         return getConfigById(JSONUtil.getStr(materialMapConfig,[param1,param2]));
      }
      
      public static function getConfigById(param1:String) : Object
      {
         return obf_0_2_a_674[param1];
      }
      
      public static function getMainTargetItemCodeById(param1:String) : String
      {
         var _loc2_:Object = obf_0_2_a_674[param1];
         return JSONUtil.getStr(_loc2_,["mainTargetItem"]);
      }
      
      public static function getAssembleBaseMaterial(param1:String) : Array
      {
         var _loc4_:String = null;
         var _loc2_:Object = getConfigById(param1);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         for(_loc4_ in _loc2_.baseItems)
         {
            _loc3_.push({
               "itemCode":_loc4_,
               "itemCount":_loc2_.baseItems[_loc4_]
            });
         }
         _loc3_.sortOn("itemCode");
         return _loc3_;
      }
      
      public static function getSubtypeList(param1:String) : Array
      {
         var _loc4_:String = null;
         var _loc2_:Object = configObj[param1];
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         for(_loc4_ in _loc2_)
         {
            _loc3_.push(_loc4_);
         }
         _loc3_.sort();
         return _loc3_;
      }
      
      public static function getConfigsByType(param1:String, param2:String = null) : Array
      {
         var _loc5_:String = null;
         var _loc3_:Array = new Array();
         var _loc4_:Object = configObj[param1];
         if(!_loc4_)
         {
            return null;
         }
         if(param2 == null)
         {
            for(_loc5_ in _loc4_)
            {
               _loc3_ = _loc3_.concat(_loc4_[_loc5_]);
            }
         }
         else
         {
            _loc3_ = _loc4_[param2];
         }
         return _loc3_;
      }
      
      public static function getCanAssembleList(param1:Array) : Array
      {
         var _loc3_:Object = null;
         if(!param1 || !obf_K_e_3075.playerBagUI)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            if(obf_C_e_1742(_loc3_,false))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function obf_C_e_1742(param1:Object, param2:Boolean = true) : Boolean
      {
         var _loc3_:String = null;
         if(!ConditionScript.checkCondition(param1.condition,null,param2))
         {
            return false;
         }
         for(_loc3_ in param1.baseItems)
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc3_,true) < param1.baseItems[_loc3_])
            {
               if(param2)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(_loc3_)]));
               }
               return false;
            }
         }
         return true;
      }
      
      private static function initLuckStar() : void
      {
         starLevelValue = new Array();
         starLevelValue.push(0);
         var _loc1_:int = 2;
         var _loc2_:int = 1;
         while(_loc2_ <= 100)
         {
            _loc1_ += _loc2_ * 2;
            starLevelValue.push(_loc1_);
            _loc2_++;
         }
      }
      
      public static function getLuckStar(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(!starLevelValue)
         {
            return 0;
         }
         var _loc3_:int = 1;
         while(_loc3_ < starLevelValue.length)
         {
            _loc4_ = getLuckStarLevelUpValue(_loc3_);
            if(param1 < _loc4_)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public static function getLuckStarLevelUpValue(param1:int) : int
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         return JSONUtil.getInt(starLevelValue,[param1]);
      }
      
      public static function setLuckBox(param1:int, param2:AssembleLuckBox, param3:Boolean = true) : void
      {
         var _loc8_:obf_6_t_3568 = null;
         var _loc4_:int = getLuckStar(param1);
         var _loc5_:int = getLuckStarLevelUpValue(_loc4_ + 1) - getLuckStarLevelUpValue(_loc4_);
         var _loc6_:int = param1 - getLuckStarLevelUpValue(_loc4_);
         param2.txtLuckStar.text = "x" + obf_L_l_4100.obf_1_m_1767(_loc4_ + "",2,"0");
         if(param3 && _loc4_ > param2.luckLevel)
         {
            _loc8_ = new obf_6_t_3568(new AddLuckStarEffect());
            _loc8_.allowRepeat = false;
            _loc8_.autoRemove = true;
            param2.addChild(_loc8_);
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("AssemblePrompt","assembleLuckStarUp"),param2.parent,new Point(0,-100));
         }
         param2.luckLevel = _loc4_;
         var _loc7_:int = _loc6_ / _loc5_ * 100;
         param2.barLuckValue.gotoAndStop(_loc7_);
      }
      
      public static function obf_0_2_6_666(param1:int) : int
      {
         var _loc2_:int = getAssembleLuck(param1);
         _loc2_ += 1 + Math.random() * 10;
         setAssembleLuck(param1,_loc2_);
         return _loc2_;
      }
      
      public static function getAssembleLuck(param1:int) : int
      {
         if(!GameContext.userConfig.asl)
         {
            GameContext.userConfig.asl = new Object();
         }
         return JSONUtil.getInt(GameContext.userConfig.asl,[param1 + ""]);
      }
      
      public static function setAssembleLuck(param1:int, param2:int) : void
      {
         if(!GameContext.userConfig.asl)
         {
            GameContext.userConfig.asl = new Object();
         }
         GameContext.userConfig.asl[param1] = param2;
         GameContext.saveConfigNow();
      }
      
      public static function sendAssemble(param1:String, param2:Array, param3:int, param4:Array, param5:Boolean = false, param6:Array = null, param7:String = "") : void
      {
         var _loc8_:NpcAssembleItemRequest = new NpcAssembleItemRequest();
         _loc8_.npcId = param1;
         _loc8_.funcMenuFullIndex = param2;
         _loc8_.assembleRuleIndex = param3;
         _loc8_.addedItems = param4;
         _loc8_.priorityEqualItem = param5;
         _loc8_.baseItemIds = param6;
         _loc8_.protectionItem = param7;
         GameContext.worldClient.sendCommand(_loc8_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeNpc.NPC_ASSEMBLE_ITEM_ANSWER)
         {
            obf_6_q_3366(param1 as NpcAssembleItemAnswer);
         }
      }
      
      private static function obf_6_q_3366(param1:NpcAssembleItemAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_6_D_3816.print(DiversityManager.getString("AssembleBoxUI","promptAssemberComplete"));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("AssembleBoxUI","promptAssemberFail"));
         }
         if(Boolean(obf_K_e_3075.assembleBoxUI) && obf_K_e_3075.assembleBoxUI.visible)
         {
            obf_K_e_3075.assembleBoxUI.startAssemble();
         }
         obf_K_e_3075.rideBoxUI.obf_w_i_3412(param1);
         obf_K_e_3075.wingBoxUI.obf_w_i_3412(param1);
         obf_K_e_3075.petAssembleBoxUI.obf_6_q_3366(param1);
         obf_K_e_3075.soulAssembleUI.obf_w_i_3412(param1);
         if(obf_K_e_3075.armoryComposeUI.visible)
         {
            obf_K_e_3075.armoryComposeUI.obf_w_i_3412(param1);
         }
      }
   }
}

