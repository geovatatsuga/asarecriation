package obf_x_O_4078
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactSoulAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactSoulMoveAnswer;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactSoulMoveRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.ArtifactSoulRequest;
   import com.sunweb.game.rpg.worldZone.command.artifact.CommandCodeArtifact;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import img.Moon;
   import img.RefineStarOff;
   import img.RefineStarOn;
   import img.Star;
   import img.Sun;
   
   public class obf_1_t_884
   {
      
      private static var _config:Object;
      
      private static var _material:Object;
      
      public function obf_1_t_884()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc3_:Object = null;
         _config = param1;
         _material = new Object();
         var _loc2_:Array = JSONUtil.getObject(_config,["materialArray"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            _material[_loc3_.itemCode] = _loc3_;
         }
      }
      
      public static function get refineValueAdded() : int
      {
         return JSONUtil.getInt(_config,["reqRefineValueAdded"]);
      }
      
      public static function get maxRefineLevel() : int
      {
         return JSONUtil.getInt(_config,["maxRefineLevel"]);
      }
      
      public static function get maxMaterialNumber() : int
      {
         return JSONUtil.getInt(_config,["maxMaterialNumber"]);
      }
      
      public static function getRefineLevelConfig(param1:int) : Object
      {
         return JSONUtil.getObject(_config,["refineLevelArray",param1]);
      }
      
      public static function itemIsRefineMaterial(param1:String) : Boolean
      {
         return _material.hasOwnProperty(param1);
      }
      
      public static function getAddSoulConfig() : Array
      {
         return JSONUtil.getValue(_config,"soul");
      }
      
      public static function getSoulAttr() : Number
      {
         return JSONUtil.getNumber(_config,["soulAttr"]);
      }
      
      public static function getItemCode() : String
      {
         return JSONUtil.getStr(_config,["code"]);
      }
      
      public static function getMoveItemCode() : String
      {
         return JSONUtil.getStr(_config,["MoveCode"]);
      }
      
      public static function itemCanUseOnEquip(param1:String, param2:String) : Boolean
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         var _loc4_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc3_ || !_loc4_)
         {
            return false;
         }
         return JSONUtil.getInt(_loc4_,["properties","materialLevel"],int.MAX_VALUE) >= JSONUtil.getInt(_loc3_,["itemLevel"]) && JSONUtil.getInt(_loc3_,["itemLevel"]) >= JSONUtil.getInt(_loc4_,["properties","materialNeedLevel"]);
      }
      
      public static function getRefineMaterialValue(param1:String) : int
      {
         return JSONUtil.getInt(_material,[param1,"refineValue"]);
      }
      
      public static function getValueRefine(param1:Number, param2:int) : Number
      {
         var _loc3_:Object = getRefineLevelConfig(param2 - 1);
         if(!_loc3_)
         {
            return 0;
         }
         return param1 * JSONUtil.getNumber(_loc3_,["attrAddRate"]) + JSONUtil.getInt(_loc3_,["attrAddValue"]);
      }
      
      public static function getRefineEquipModeCode(param1:int, param2:int) : String
      {
         var _loc6_:int = 0;
         var _loc3_:String = "";
         var _loc4_:Array = JSONUtil.getObject(_config,["refineWeaponEffect"]) as Array;
         if(!_loc4_)
         {
            return "";
         }
         var _loc5_:* = int(_loc4_.length - 1);
         while(_loc5_ >= 0)
         {
            _loc6_ = int(_loc4_[_loc5_]);
            if(param1 >= _loc6_)
            {
               _loc3_ = "xw" + param2 + _loc5_;
               if(param2 == obf_I_5_1944.obf_A_t_4218)
               {
                  _loc3_ += "," + _loc3_ + "z";
               }
               break;
            }
            _loc5_--;
         }
         return _loc3_;
      }
      
      public static function getAllMaterialInPlayerBag() : Array
      {
         var _loc2_:IconItemBag = null;
         if(!obf_K_e_3075.playerBagUI)
         {
            return null;
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in obf_K_e_3075.playerBagUI.allBags)
         {
            if(!(_loc2_.isLocked || !_loc2_.haveIconItem || _loc2_.haveIconItem.itemType != GameItemType.COLLECTION))
            {
               if(obf_1_t_884.itemIsRefineMaterial(_loc2_.haveIconItem.itemCode))
               {
                  _loc1_.push(_loc2_.haveIconItem.itemCode);
               }
            }
         }
         return _loc1_;
      }
      
      public static function getMaterialListInStore() : Array
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:Array = JSONUtil.getObject(_config,["materialArray"]) as Array;
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = GameItemManager.getItemConfig(_loc3_.itemCode);
            if(JSONUtil.getInt(_loc4_,["moneyPrice"],-1) > 0)
            {
               _loc2_.push(_loc3_.itemCode);
            }
         }
         return _loc2_;
      }
      
      public static function getRefineLevelDisplay(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc6_:RefineStarOn = null;
         var _loc7_:RefineStarOff = null;
         var _loc3_:int = 12;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:int = 1;
         while(_loc5_ <= maxRefineLevel)
         {
            if(_loc5_ <= param1)
            {
               _loc6_ = new RefineStarOn();
               _loc6_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc6_);
            }
            else
            {
               if(!param2)
               {
                  break;
               }
               _loc7_ = new RefineStarOff();
               _loc7_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc7_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getSoulLevelDisplay(param1:int) : DisplayObject
      {
         var _loc9_:* = undefined;
         var _loc2_:Sprite = new Sprite();
         var _loc3_:int = 10;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = param1 % _loc3_;
         _loc5_ = param1 / _loc3_;
         if(_loc5_ >= _loc3_)
         {
            _loc4_ = _loc5_ / _loc3_;
            _loc5_ %= _loc3_;
         }
         var _loc7_:int = -1;
         var _loc8_:int = 2;
         var _loc10_:int = 0;
         while(_loc10_ < _loc4_)
         {
            if(++_loc7_ > 14)
            {
               _loc7_ = 0;
               _loc8_ += _loc9_.height;
            }
            _loc9_ = new Sun();
            _loc9_.x = 15 * _loc7_ + 9;
            _loc9_.y = _loc8_ + 1;
            _loc2_.addChild(_loc9_);
            _loc10_++;
         }
         var _loc11_:int = 0;
         while(_loc11_ < _loc5_)
         {
            if(++_loc7_ > 14)
            {
               _loc7_ = 0;
               _loc8_ += _loc9_.height;
            }
            _loc9_ = new Moon();
            _loc9_.x = 15 * _loc7_ + 9;
            _loc9_.y = _loc8_ + 1.3;
            _loc2_.addChild(_loc9_);
            _loc11_++;
         }
         var _loc12_:int = 0;
         while(_loc12_ < _loc6_)
         {
            if(++_loc7_ > 14)
            {
               _loc7_ = 0;
               _loc8_ += _loc9_.height;
            }
            _loc9_ = new Star();
            _loc9_.x = 15 * _loc7_ + 9;
            _loc9_.y = _loc8_;
            _loc2_.addChild(_loc9_);
            _loc12_++;
         }
         return _loc2_;
      }
      
      public static function sendArtifactSoulRequest(param1:String) : void
      {
         var _loc2_:ArtifactSoulRequest = new ArtifactSoulRequest();
         _loc2_.equipmentId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendArtifactSoulMoveRequest(param1:String, param2:String) : void
      {
         var _loc3_:ArtifactSoulMoveRequest = new ArtifactSoulMoveRequest();
         _loc3_.getId = param1;
         _loc3_.loseId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeArtifact.ARTIFACT_SOUL_ANSWER)
         {
            obf_E_D_3869(param1 as ArtifactSoulAnswer);
         }
         else if(param1.code == CommandCodeArtifact.ARTIFACT_SOUL_MOVE_ANSWER)
         {
            obf_5_L_3804(param1 as ArtifactSoulMoveAnswer);
         }
      }
      
      private static function obf_E_D_3869(param1:ArtifactSoulAnswer) : void
      {
         if(param1.isSuccessed)
         {
            obf_6_D_3816.print(DiversityManager.getString("EquAddSoulUI","prompt_SouleComplete"));
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","prompt_SouleComplete"));
            obf_q_6_3634.obf_e_J_1876("enhanceComplete@fs9",1);
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("EquAddSoulUI","prompt_SoulFail"));
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","prompt_SoulFail"));
            obf_q_6_3634.obf_e_J_1876("enhanceFail@fs9",1);
         }
         GameItemInfoManager.removeItemInfo(param1.equipId);
         obf_K_e_3075.equAddSoulUI.equipInfo = null;
         obf_K_e_3075.equAddSoulUI.showRefineEffect(param1.isSuccessed);
      }
      
      private static function obf_5_L_3804(param1:ArtifactSoulMoveAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.getEquipId);
         GameItemInfoManager.removeItemInfo(param1.loseEquipId);
         if(obf_K_e_3075.devolveUI.visible)
         {
            obf_K_e_3075.devolveUI.clearContent(true);
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","prompt_MoveComplete"));
      }
   }
}

