package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.FarmTempletManager;
   import com.sunweb.game.rpg.farm.obf_F_a_1500;
   import com.sunweb.game.rpg.farm.obf_P_f_3747;
   import com.sunweb.game.rpg.farm.obf_d_8_4301;
   import com.sunweb.game.rpg.farm.obf_n_v_1693;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.module.obf_0_K_4070;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   
   public class IconItemFarm extends IconItem
   {
      
      public static const FARM_SEED:int = 0;
      
      public static const FARM_BUILDING:int = 1;
      
      public var farmItemType:int;
      
      public function IconItemFarm(param1:DisplayObject, param2:String)
      {
         super(param1);
         itemCode = param2;
         addType(GameItemType.EXPENDABLE);
      }
      
      public static function getNewIconItem(param1:String, param2:String, param3:int) : IconItemFarm
      {
         var _loc4_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc4_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4705(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc5_:IconItemFarm = new IconItemFarm(GameItemManager.getItemIcon(param1),param1);
         _loc5_.itemName = _loc4_.name;
         _loc5_.itemId = param2;
         _loc5_.farmItemType = param3;
         _loc5_.rankMask = GameItemRank.getRankIcon(_loc4_.rank);
         _loc5_.iconItemRank = _loc4_.rank;
         _loc5_.iconMask = GameItemCDManager.getCDBitmap(GameItemManager.getItemCDFlag(param1));
         return _loc5_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:Object = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:String = null;
         var _loc20_:obf_n_v_1693 = null;
         var _loc21_:Array = null;
         var _loc22_:Object = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Shape = null;
         var _loc26_:Object = null;
         var _loc27_:Rectangle = null;
         var _loc28_:Number = NaN;
         var _loc3_:GameTipUI = new GameTipUI("Items");
         var _loc4_:int = 290;
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(_loc5_)
         {
            GameItemManager.obf_4_G_4299(_loc5_.name,_loc5_.rank,_loc3_,_loc4_);
            GameItemManager.obf_o_l_1634(_loc5_,_loc3_,_loc4_);
            if(_loc5_.subtype == GameItemSubtype.EXPENDABLE_FARM_BUILDING)
            {
               _loc6_ = obf_d_8_4301.getFarmBuildingInfo(_loc5_.properties.buildingCode);
               if(!_loc6_)
               {
                  obf_x_0_1295.obf_r_w_3556("obf_____4729（" + _loc5_.properties.buildingCode + "）obf_____4800！");
                  return;
               }
               _loc3_.addTipInfo(DiversityManager.getString("FarmItem","farmLevel_Label"),_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<p align=\'right\'>" + DiversityManager.getString("FarmItem","farmLevel_Value",[JSONUtil.getInt(_loc6_,["farmLevel"],1)]) + "</p>",_loc4_,_loc3_.maxRow);
               _loc3_.addTipInfo("<FONT COLOR=\'#33FF00\'>" + DiversityManager.getString("FarmItem","validDayAfterUse",[_loc5_.properties.days]) + "</FONT>",_loc4_,_loc3_.maxRow + 2);
            }
            else if(_loc5_.subtype == GameItemSubtype.EXPENDABLE_FARM_SEED)
            {
               _loc6_ = obf_P_f_3747.getFarmHarvestInfo(_loc5_.properties.harvestCode);
               if(!_loc6_)
               {
                  obf_x_0_1295.obf_r_w_3556("obf___4940（" + _loc5_.properties.harvestCode + "）obf_____4800！");
                  return;
               }
               _loc3_.addTipInfo(DiversityManager.getString("FarmItem","itemType_Label"),_loc4_,_loc3_.maxRow + 1);
               if(_loc6_)
               {
                  _loc3_.addTipInfo("<P ALIGN=\'RIGHT\'>" + FarmManager.getKindName(_loc6_.kind) + "</P>",_loc4_,_loc3_.maxRow);
               }
               _loc3_.addTipInfo(DiversityManager.getString("FarmItem","season_Label"),_loc4_,_loc3_.maxRow + 1);
               _loc7_ = 0;
               _loc8_ = 0;
               _loc9_ = new Array();
               for each(_loc10_ in _loc6_.phaseConfig)
               {
                  _loc8_ += _loc10_.phaseDurationInMin || 0;
                  if(_loc10_.phaseType == obf_F_a_1500.obf_Y_i_1717)
                  {
                     _loc7_++;
                     _loc9_.push([_loc10_.productCode,_loc10_.productNumber]);
                  }
               }
               _loc11_ = int(_loc8_ / 60);
               _loc12_ = _loc8_ - _loc11_ * 60;
               _loc3_.addTipInfo("<P ALIGN=\'RIGHT\'>" + DiversityManager.getString("FarmItem","harvestTime",[_loc11_,_loc12_,_loc7_]) + "</P>",_loc4_,_loc3_.maxRow);
               _loc13_ = GameContext.localPlayer.getFarmSkillLevelByKind(_loc6_.kind) < _loc6_.level ? 16711680 : 65280;
               _loc14_ = "";
               if(Boolean(_loc6_.allowFarmCodes) && _loc6_.allowFarmCodes.length > 0)
               {
                  for each(_loc19_ in _loc6_.allowFarmCodes)
                  {
                     if(_loc14_ != "")
                     {
                        _loc14_ += "、";
                     }
                     _loc20_ = FarmTempletManager.getFarmTemplet(_loc19_);
                     if(_loc20_)
                     {
                        _loc14_ += _loc20_.name;
                     }
                  }
               }
               _loc3_.addTipInfo(DiversityManager.getString("FarmItem","needFarm",[_loc6_.farmLevel || 1,_loc14_]) + "、<FONT COLOR=\'#" + _loc13_.toString(16) + "\'>" + DiversityManager.getString("FarmItem","needFarmSkill",[_loc6_.level,FarmManager.getKindName(_loc6_.kind)]) + "</FONT>",_loc4_,_loc3_.maxRow + 1);
               _loc3_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("FarmItem","productAndYield_Label") + "</P>",_loc4_,_loc3_.maxRow + 1);
               _loc17_ = 1;
               _loc18_ = 0;
               while(_loc18_ < _loc9_.length)
               {
                  _loc21_ = _loc9_[_loc18_];
                  if(_loc21_[0] != null && _loc21_[0] != "")
                  {
                     if(_loc18_ == 0)
                     {
                        _loc15_ = _loc21_[0];
                        _loc16_ = int(_loc21_[1]);
                     }
                     _loc22_ = GameItemManager.getItemConfig(_loc15_);
                     if(_loc15_ != _loc21_[0] || _loc16_ != _loc21_[1])
                     {
                        if(_loc22_)
                        {
                           _loc3_.addTipInfo(DiversityManager.getString("FarmItem","season_Value",[_loc18_ > _loc17_ ? _loc17_ + "-" + _loc18_ : _loc17_]),_loc4_,_loc3_.maxRow + 1);
                           _loc3_.addTipInfo("<P align=\'right\'><FONT color=\'#" + GameItemRank.getRankColor(_loc22_.rank).toString(16) + "\'>" + _loc22_.name + "</FONT> " + DiversityManager.getString("FarmItem","season_Value",[_loc16_ + "/"]) + "</P>",_loc4_,_loc3_.maxRow);
                        }
                        _loc15_ = _loc21_[0];
                        _loc16_ = int(_loc21_[1]);
                        _loc17_ = _loc18_ + 1;
                     }
                     if(_loc18_ == _loc9_.length - 1)
                     {
                        _loc15_ = _loc21_[0];
                        _loc16_ = int(_loc21_[1]);
                        _loc22_ = GameItemManager.getItemConfig(_loc15_);
                        if(_loc22_)
                        {
                           _loc3_.addTipInfo(DiversityManager.getString("FarmItem","season_Value",[_loc18_ > _loc17_ ? _loc17_ + "-" + (_loc18_ + 1) : _loc17_]),_loc4_,_loc3_.maxRow + 1);
                           _loc3_.addTipInfo("<P align=\'right\'><FONT color=\'#" + GameItemRank.getRankColor(_loc22_.rank).toString(16) + "\'>" + _loc22_.name + "</FONT> " + DiversityManager.getString("FarmItem","season_Value",[_loc16_ + "/"]) + "</P>",_loc4_,_loc3_.maxRow);
                        }
                     }
                  }
                  _loc18_++;
               }
            }
            if(Boolean(_loc5_.remark) && _loc5_.remark != "")
            {
               _loc3_.addTipInfo(_loc5_.remark,_loc4_,_loc3_.maxRow + 2);
            }
            if(Boolean(_loc6_.farmArea) && _loc6_.farmArea.length > 0)
            {
               _loc23_ = 10;
               _loc24_ = 5;
               _loc3_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("FarmItem","harvestArea") + "</P>",_loc4_,_loc3_.maxRow + 2);
               _loc25_ = new Shape();
               _loc25_.graphics.beginFill(16711680);
               for each(_loc26_ in _loc6_.farmArea)
               {
                  _loc25_.graphics.drawRect((_loc26_.x - _loc6_.rootX) * _loc23_,(_loc26_.y - _loc6_.rootY) * _loc24_,_loc23_ - 1,_loc24_ - 1);
               }
               _loc25_.graphics.endFill();
               _loc27_ = _loc25_.getBounds(_loc25_);
               _loc28_ = 1;
               if(_loc25_.width > _loc4_)
               {
                  _loc28_ = _loc4_ / _loc25_.width;
                  _loc25_.scaleX = _loc28_;
                  _loc25_.scaleY = _loc28_;
               }
               _loc25_.x = _loc4_ / 2 - (_loc27_.width / 2 + _loc27_.x) * _loc28_;
               _loc3_.addTipObject(_loc25_,_loc3_.maxRow);
            }
            GameItemManager.obf_J_l_4537(_loc5_,_loc3_,_loc4_);
            GameItemManager.setItemTipValidTime(param1,param2,_loc3_,_loc4_);
         }
         GameTipManager.showTip(_loc3_);
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         var _loc2_:Boolean = false;
         if(itemCount <= 0)
         {
            return false;
         }
         if(Boolean(this.parent) && Boolean(this.parent is IconItemBag) && IconItemBag(this.parent).parentIconUI is PlayerBagUI)
         {
            _loc2_ = FarmManager.useFarmItem(this);
            obf_0_K_4070.showWelcome("ius");
            return _loc2_;
         }
         return false;
      }
      
      override public function clone() : IconItem
      {
         var _loc1_:IconItemFarm = getNewIconItem(itemCode,itemId,this.farmItemType);
         _loc1_.itemCount = this.itemCount;
         return _loc1_;
      }
   }
}

