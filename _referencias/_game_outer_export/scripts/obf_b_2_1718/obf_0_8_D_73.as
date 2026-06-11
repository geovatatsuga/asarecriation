package obf_b_2_1718
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneAttrAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneAttrRequest;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneMeltAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneMeltRequest;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneOpenAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneOpenRequest;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneRefineAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneRefineRequest;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.player.bone.CommandCodeBone;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_8_D_73
   {
      
      public static var boneConfig:Object;
      
      private static var equipMaterial:Object;
      
      private static var _boneAttrPoint:Array;
      
      private static var equipConfig:Object;
      
      public static var refineMaterial:Array;
      
      public static var _lvName:String;
      
      public static var obf_0_1_w_388:int;
      
      public static var obf_Y_y_1810:int;
      
      public static var _lightLevel:int;
      
      public static var _refineLevel:int;
      
      public static var obf_k_i_3840:int = 10;
      
      public function obf_0_8_D_73()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc2_:String = null;
         boneConfig = new Object();
         _boneAttrPoint = new Array();
         boneConfig = param1;
         for(_loc2_ in param1.boneLevels)
         {
            _boneAttrPoint.push(_loc2_);
         }
      }
      
      public static function getRefineMaterial() : Object
      {
         return obf_x_c_2855.getConfigById(WorldConfig.getStringSetting("boneRefineRule")).baseItems;
      }
      
      public static function getRefineRule() : int
      {
         return WorldConfig.getObjectSetting("boneRefineRule") as int;
      }
      
      public static function get boneAttrPoint() : Array
      {
         return _boneAttrPoint;
      }
      
      public static function getBoneAllNum() : int
      {
         return JSONUtil.getInt(boneConfig,["boneAllValue"]);
      }
      
      public static function getBoneClearNum() : int
      {
         return JSONUtil.getInt(boneConfig,["refineTimes"]);
      }
      
      public static function get openBoneCon() : Boolean
      {
         var _loc1_:Object = JSONUtil.getObject(boneConfig,["openBoneCondition"]);
         if(!ConditionScript.checkCondition(_loc1_,null,true))
         {
            return false;
         }
         return true;
      }
      
      public static function getBoneCurrentLightAll(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Object = new Object();
         var _loc7_:int = 1;
         while(_loc7_ <= param1)
         {
            _loc3_ = getStirpObject(_loc7_);
            _loc4_ = JSONUtil.getInt(_loc3_,["boneValue"]);
            if(_loc7_ != param1)
            {
               _loc5_ += _loc4_ * obf_k_i_3840;
            }
            else
            {
               _loc6_ = _loc4_ * param2;
            }
            _loc7_++;
         }
         return _loc5_ + _loc6_;
      }
      
      public static function itemIsRefineEquip(param1:String) : Boolean
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(_loc2_.type != GameItemType.EQUIPMENT || _loc2_.playerLevel < JSONUtil.getInt(boneConfig,["meltEquipCondition","playerLevel"]) || _loc2_.rank < JSONUtil.getInt(boneConfig,["meltEquipCondition","rank"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("boneUI","prompt_UnItems"));
            return false;
         }
         return true;
      }
      
      public static function get getBoneLevel() : int
      {
         return obf_Y_y_1810;
      }
      
      public static function get BoneGradeList() : Array
      {
         return boneConfig.boneLevels;
      }
      
      public static function getStirpObject(param1:int) : Object
      {
         var _loc2_:Array = boneConfig.boneLevels as Array;
         if(!_loc2_)
         {
            return null;
         }
         if(param1 < 1)
         {
            return null;
         }
         if(param1 > _loc2_.length)
         {
            return null;
         }
         var _loc3_:Object = _loc2_[param1 - 1];
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getAttributesInfo(param1:int) : Array
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = JSONUtil.getObject(getStirpObject(obf_K_e_3075.boneUI.getButtonType),["level"]) as Array;
         if(!_loc3_)
         {
            return null;
         }
         _lvName = JSONUtil.getStr(_loc3_[param1 - 1],["lvName"]);
         var _loc4_:Array = JSONUtil.getObject(_loc3_[param1 - 1],["addAttr"]) as Array;
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = new Object();
            _loc6_["attr"] = JSONUtil.getInt(_loc5_,["attr"]);
            _loc6_["value"] = JSONUtil.getNumber(_loc5_,["value"]);
            _loc2_.push(_loc6_);
         }
         return _loc2_;
      }
      
      public static function getAttributesName() : String
      {
         return _lvName;
      }
      
      public static function sendRefineItems(param1:Object) : void
      {
         var _loc2_:BoneMeltRequest = new BoneMeltRequest();
         _loc2_.equipmentItemIds = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendRefineBone() : void
      {
         var _loc1_:BoneRefineRequest = new BoneRefineRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBoneUpLevel() : void
      {
         var _loc1_:BoneUpLevelRequest = new BoneUpLevelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBoneLevelAttr(param1:int) : void
      {
         var _loc2_:BoneAttrRequest = new BoneAttrRequest();
         _loc2_.boneTab = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendOpenBone() : void
      {
         var _loc1_:BoneOpenRequest = new BoneOpenRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeBone.BONE_MELT_ANSWER)
         {
            obf_b_Z_2070(param1 as BoneMeltAnswer);
         }
         else if(param1.code == CommandCodeBone.BONE_REFINE_ANSWER)
         {
            obf_K_e_3075.boneUI.obf_k_N_2236(param1 as BoneRefineAnswer);
         }
         else if(param1.code == CommandCodeBone.BONE_UP_LEVEL_ANSWER)
         {
            obf_a_h_2864(param1 as BoneUpLevelAnswer);
         }
         else if(param1.code == CommandCodeBone.BONE_ATTR_ANSWER)
         {
            obf_T_p_2837(param1 as BoneAttrAnswer);
         }
         else if(param1.code == CommandCodeBone.BONE_OPEN_ANSWER)
         {
            obf_p_Q_2490(param1 as BoneOpenAnswer);
         }
      }
      
      private static function obf_b_Z_2070(param1:BoneMeltAnswer) : void
      {
         if(param1.isMeltSucceed)
         {
            WindowManager.showMessageBox(DiversityManager.getString("boneUI","promptRefineComplete"));
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("boneUI","promptRefineberFail"));
         }
         obf_K_e_3075.boneUI.clearItems();
      }
      
      private static function obf_a_h_2864(param1:BoneUpLevelAnswer) : void
      {
         GameContext.localPlayer.fullInfo.boneLevel = param1.boneLevel;
         GameContext.localPlayer.fullInfo.lightLevel = param1.lightLevel;
         GameContext.localPlayer.fullInfo.refineLevel = 0;
         obf_K_e_3075.boneUI.obf_0_5_H_253(param1.boneLevel,param1.lightLevel);
         obf_K_e_3075.boneUI.obf_P_K_1551();
         if(param1.lightLevel == obf_k_i_3840)
         {
            GameContext.localPlayer.fullInfo.boneLevel += 1;
            if(GameContext.localPlayer.fullInfo.boneLevel > 8)
            {
               obf_K_e_3075.boneUI.obf_E_P_1839();
               return;
            }
            GameContext.localPlayer.fullInfo.lightLevel = 0;
            obf_K_e_3075.boneUI.exchangeAttr();
            obf_K_e_3075.boneUI.showTabState();
         }
      }
      
      private static function obf_T_p_2837(param1:BoneAttrAnswer) : void
      {
         obf_K_e_3075.boneUI.showBoneAttr(param1.attr);
         obf_K_e_3075.boneUI.obf_6_Z_2251();
      }
      
      private static function obf_p_Q_2490(param1:BoneOpenAnswer) : void
      {
         GameContext.localPlayer.fullInfo.boneLevel = param1.boneLevel;
         obf_K_e_3075.showUI(obf_K_e_3075.boneUI);
      }
   }
}

