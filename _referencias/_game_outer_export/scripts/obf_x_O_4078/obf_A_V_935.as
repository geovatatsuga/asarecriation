package obf_x_O_4078
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactDecomposeRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactDisembedAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactDisembedRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactEmbedAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactEmbedRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactFusionAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactFusionRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactHoleAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactHoleRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactLetteringAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactLetteringRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactRefineAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactRefineRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactUpEquExpAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactUpEquExpRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactUpgradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactUpgradeRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactWashAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactWashRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.CommandCodeArtifact;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import img.EmbedHoleIcon;
   import img.EmptyHoleIcon;
   
   public class obf_A_V_935
   {
      
      private static var configObj:Object;
      
      private static var obf_3_1_4202:Object;
      
      private static var embedGroupMap:Object;
      
      private static var obf_4_P_4198:Object;
      
      public function obf_A_V_935()
      {
         super();
      }
      
      public static function initConfig(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         configObj = param1;
         obf_3_1_4202 = new Object();
         for each(_loc2_ in param1.embedPlanList)
         {
            obf_3_1_4202[_loc2_.planId] = _loc2_;
         }
         embedGroupMap = new Object();
         for each(_loc3_ in param1.embedGroupPlan)
         {
            embedGroupMap[_loc3_.planId] = _loc3_;
         }
         obf_4_P_4198 = new Object();
         for each(_loc4_ in param1.holePlanList)
         {
            obf_4_P_4198[_loc4_.planId] = _loc4_;
         }
      }
      
      public static function get legendConfig() : Object
      {
         return JSONUtil.getObject(configObj,["legendConfig"]);
      }
      
      public static function getGemTypeName(param1:int) : String
      {
         return JSONUtil.getStr(configObj,["gemTypeName",param1 + ""]);
      }
      
      public static function getHoleCost(param1:String, param2:int) : Object
      {
         var _loc3_:Object = getHolePlan(param1);
         return JSONUtil.getObject(_loc3_,["holeCostList",param2]);
      }
      
      public static function getDisembedCost(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in configObj.disembedCostList)
         {
            if(_loc2_.gemLevel == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getEmbedPlan(param1:String) : Object
      {
         return JSONUtil.getObject(obf_3_1_4202,[param1]);
      }
      
      public static function getHolePlan(param1:String) : Object
      {
         return JSONUtil.getObject(obf_4_P_4198,[param1]);
      }
      
      public static function obf_0_6_B_169(param1:String, param2:String) : Boolean
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         var _loc4_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc3_ || !_loc4_)
         {
            return false;
         }
         var _loc5_:Object = obf_A_V_935.getEmbedPlan(JSONUtil.getStr(_loc3_,["properties","embedPlanId"]));
         if(!_loc5_)
         {
            return false;
         }
         if((_loc5_.embedGemType as Array).indexOf(JSONUtil.getInt(_loc4_,["properties","gemType"])) <= -1)
         {
            return false;
         }
         return true;
      }
      
      public static function obf_j_n_1267(param1:String, param2:String) : Boolean
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         var _loc4_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc3_ || !_loc4_)
         {
            return false;
         }
         if(JSONUtil.getInt(_loc4_,["properties","gemLevel"]) > JSONUtil.getInt(_loc3_,["properties","embedGemLevel"]))
         {
            return false;
         }
         return true;
      }
      
      public static function getHolesDisplay(param1:int, param2:int) : DisplayObject
      {
         var _loc5_:DisplayObject = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:* = param1;
         while(_loc4_ >= 1)
         {
            if(_loc4_ > param2)
            {
               _loc5_ = new EmptyHoleIcon();
            }
            else
            {
               _loc5_ = new EmbedHoleIcon();
            }
            _loc5_.x = _loc3_.width;
            _loc3_.addChild(_loc5_);
            _loc4_--;
         }
         return _loc3_;
      }
      
      public static function getEmbedGroupPlan(param1:String) : Object
      {
         return JSONUtil.getObject(embedGroupMap,[param1]);
      }
      
      public static function getMatchGroupPlan(param1:Array, param2:Array) : String
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         loop0:
         for each(_loc3_ in param1)
         {
            _loc4_ = getEmbedGroupPlan(_loc3_);
            if(_loc4_)
            {
               if(!(!_loc4_.groupItems || _loc4_.groupItems.length != param2.length))
               {
                  _loc5_ = param2.concat();
                  for each(_loc6_ in _loc4_.groupItems)
                  {
                     _loc7_ = _loc5_.indexOf(_loc6_);
                     if(_loc7_ <= -1)
                     {
                        _loc8_ = GameItemManager.getItemConfig(_loc6_);
                        if(!_loc8_)
                        {
                           continue;
                        }
                        if(!obf_L_l_4100.isEmpty(_loc8_.equalItem))
                        {
                           _loc7_ = _loc5_.indexOf(_loc8_.equalItem);
                        }
                     }
                     if(_loc7_ <= -1)
                     {
                        continue loop0;
                     }
                     _loc5_.splice(_loc7_,1);
                  }
                  return _loc3_;
               }
            }
         }
         return "";
      }
      
      public static function sendHole(param1:String, param2:int) : void
      {
         var _loc3_:ArtifactHoleRequest = new ArtifactHoleRequest();
         _loc3_.equipmentItemId = param1;
         _loc3_.holeIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendEmbed(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:ArtifactEmbedRequest = new ArtifactEmbedRequest();
         _loc4_.equipmentItemId = param1;
         _loc4_.gemItemIndex = param2;
         _loc4_.holeIndex = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendDisembed(param1:String, param2:int) : void
      {
         var _loc3_:ArtifactDisembedRequest = new ArtifactDisembedRequest();
         _loc3_.equipmentItemId = param1;
         _loc3_.holeIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendRefine(param1:String, param2:int, param3:Array) : void
      {
         var _loc4_:ArtifactRefineRequest = new ArtifactRefineRequest();
         _loc4_.equipmentItemId = param1;
         _loc4_.currentRefineLevel = param2;
         _loc4_.materialItems = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendDecomposeItems(param1:Array) : void
      {
         var _loc2_:ArtifactDecomposeRequest = new ArtifactDecomposeRequest();
         _loc2_.equipmentItemIds = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendEquipmentUpgrade(param1:String, param2:Array) : void
      {
         var _loc3_:ArtifactUpgradeRequest = new ArtifactUpgradeRequest();
         _loc3_.equItemBase = param1;
         _loc3_.addedItems = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendEquipmentFusion(param1:String, param2:String) : void
      {
         var _loc3_:ArtifactFusionRequest = new ArtifactFusionRequest();
         _loc3_.equItemBase = param1;
         _loc3_.equItemStuff = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendEquipmentWash(param1:String) : void
      {
         var _loc2_:ArtifactWashRequest = new ArtifactWashRequest();
         _loc2_.equipmentItemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendEquipLettering(param1:String, param2:String) : void
      {
         var _loc3_:ArtifactLetteringRequest = new ArtifactLetteringRequest();
         _loc3_.equipmentItemId = param1;
         _loc3_.letteringWord = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendEquipExpUp(param1:String) : void
      {
         var _loc2_:ArtifactUpEquExpRequest = new ArtifactUpEquExpRequest();
         _loc2_.equipmentItemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeArtifact.ARTIFACT_HOLE_ANSWER)
         {
            obf_0_8_M_409(param1 as ArtifactHoleAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_EMBED_ANSWER)
         {
            obf_l_5_931(param1 as ArtifactEmbedAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_DISEMBED_ANSWER)
         {
            obf_9_1_4184(param1 as ArtifactDisembedAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_REFINE_ANSWER)
         {
            obf_d_W_2078(param1 as ArtifactRefineAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_UPGRADE_ANSWER)
         {
            obf_t_j_4168(param1 as ArtifactUpgradeAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_FUSION_ANSWER)
         {
            obf_0___M_62(param1 as ArtifactFusionAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_WASH_ANSWER)
         {
            obf_9_X_3350(param1 as ArtifactWashAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_LETTERING_ANSWER)
         {
            onEquipLettering(param1 as ArtifactLetteringAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_UP_EQU_EXP_ANSWER)
         {
            obf_I_P_3930(param1 as ArtifactUpEquExpAnswer);
         }
      }
      
      private static function obf_0_8_M_409(param1:ArtifactHoleAnswer) : void
      {
         if(param1.isSucceeded)
         {
            GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
            obf_6_D_3816.print(DiversityManager.getString("HoleUI","prompt_HoleComplete"));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("HoleUI","prompt_HoleFailed"));
         }
         if(obf_K_e_3075.obf_5_i_2480)
         {
            obf_K_e_3075.obf_5_i_2480.clearContent(true);
         }
         obf_K_e_3075.soulEmbedUI.clearContent(true);
      }
      
      private static function obf_l_5_931(param1:ArtifactEmbedAnswer) : void
      {
         if(param1.isSucceeded)
         {
            GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
            obf_6_D_3816.print(DiversityManager.getString("EmbedUI","prompt_EmbedComplete"));
            obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("EmbedUI","prompt_EmbedFailed"));
         }
         if(obf_K_e_3075.obf_5_i_2480)
         {
            obf_K_e_3075.obf_5_i_2480.clearContent(true);
         }
         obf_K_e_3075.soulEmbedUI.clearContent(true);
      }
      
      private static function obf_9_1_4184(param1:ArtifactDisembedAnswer) : void
      {
         if(param1.isSucceeded)
         {
            GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
            obf_6_D_3816.print(DiversityManager.getString("DisembedUI","prompt_DisembedComplete"));
            obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("DisembedUI","prompt_DisembedFailed"));
         }
         if(obf_K_e_3075.obf_5_i_2480)
         {
            obf_K_e_3075.obf_5_i_2480.clearContent(true);
         }
         obf_K_e_3075.soulEmbedUI.clearContent(true);
      }
      
      private static function obf_d_W_2078(param1:ArtifactRefineAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_6_D_3816.print(DiversityManager.getString("RefineBoxUI","prompt_RefineComplete"));
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_RefineComplete"));
            obf_q_6_3634.obf_e_J_1876("enhanceComplete@fs9",1);
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("RefineBoxUI","prompt_RefineFail"));
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_RefineFail"));
            obf_q_6_3634.obf_e_J_1876("enhanceFail@fs9",1);
         }
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         if(Boolean(obf_K_e_3075.refineBoxUI.equipBag.haveIconItem) && obf_K_e_3075.refineBoxUI.equipBag.haveIconItem.itemId == param1.equipmentItemId)
         {
            obf_K_e_3075.refineBoxUI.obf_0_7_0_691();
            obf_K_e_3075.refineBoxUI.showRefineEffect(param1.isSucceeded);
         }
      }
      
      private static function obf_t_j_4168(param1:ArtifactUpgradeAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("EquipmentUpgradeUI","prompt_upgradeCompleted"),obf_K_e_3075.artifactUpgradeUI);
            obf_K_e_3075.artifactUpgradeUI.obf_8_Q_3889();
         }
         else
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("EquipmentUpgradeUI","prompt_upgradeFailed"),obf_K_e_3075.artifactUpgradeUI);
            obf_K_e_3075.artifactUpgradeUI.obf_a_M_2920();
         }
      }
      
      private static function obf_0___M_62(param1:ArtifactFusionAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("EquipmentFusionUI","prompt_FusionCompleted"),obf_K_e_3075.artifactFusionUI);
            GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
            obf_K_e_3075.artifactFusionUI.obf_W_Z_2731();
         }
         else
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("EquipmentFusionUI","prompt_FusionFailed"),obf_K_e_3075.artifactFusionUI);
            obf_K_e_3075.artifactFusionUI.obf_0_5_D_515();
         }
      }
      
      private static function obf_9_X_3350(param1:ArtifactWashAnswer) : void
      {
         if(param1.addWashPoint > 0)
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("EquipmentFusionUI","prompt_AddWashPoint",[Number(param1.addWashPoint * 100).toFixed(1)]),obf_K_e_3075.artifactFusionUI);
            GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
            obf_K_e_3075.artifactFusionUI.obf_w_W_3244(true);
            obf_K_e_3075.artifactFusionUI.obf_W_Z_2731(true);
         }
      }
      
      private static function onEquipLettering(param1:ArtifactLetteringAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         obf_K_e_3075.closeUI(obf_K_e_3075.equipmentLetteringUI);
      }
      
      private static function obf_I_P_3930(param1:ArtifactUpEquExpAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         if(obf_K_e_3075.soulLevelUpUI)
         {
            obf_K_e_3075.soulLevelUpUI.obf_q_D_1668();
         }
      }
   }
}

