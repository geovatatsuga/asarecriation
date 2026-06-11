package com.sunweb.game.rpg.playerUI.shop
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.MouseEvent;
   import playerUI.armyBoxUIMC;
   
   public class obf_s_0_2986 extends armyBoxUIMC
   {
      
      private var _iconBag:IconItemBag;
      
      private var readyRuleIndex:int;
      
      private var armyObject:Object;
      
      private var npcId:String;
      
      public function obf_s_0_2986(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtBuy,"ShopBoxUI","txtBuy");
         DiversityManager.setTextField(goods1,"ShopBoxUI","charm");
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         this._iconBag.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         this._iconBag.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      public function setReadyRuleIndex(param1:int) : void
      {
         this.readyRuleIndex = param1;
      }
      
      public function setConfig(param1:Object) : void
      {
         this.armyObject = param1;
      }
      
      public function setNpcId(param1:String) : void
      {
         this.npcId = param1;
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function obf_C_N_3764(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!ConditionScript.checkCondition(this.armyObject.condition,null,true))
         {
            return;
         }
         for(_loc2_ in this.armyObject.baseItems)
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < this.armyObject.baseItems[_loc2_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(_loc2_)]));
               return;
            }
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("ShopBoxUI","isBuy"),this.obf_A_H_4347);
      }
      
      private function obf_A_H_4347(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_x_c_2855.sendAssemble(this.npcId,null,this.readyRuleIndex,null,false,null,"");
         }
      }
      
      public function setCharm(param1:int) : void
      {
         goods2.text = param1 + "";
      }
      
      public function setMaterial(param1:String, param2:int) : void
      {
         goods3.text = param1 + "：";
         obf_D_R_4215.text = param2 + "";
      }
      
      public function setCondition(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:int = 0;
         if(param3 == 1)
         {
            _loc5_ = JSONUtil.getStr(NumberConfig.getSettingObject("mapHonorLevelNames"),[param2]);
            DiversityManager.setTextField(obf_L_6_4466,"ShopBoxUI","condition",[param1,_loc5_]);
            for(_loc6_ in this.armyObject.condition["mapHonorLevel>="])
            {
               _loc7_ = int(GameContext.localPlayer.fullInfo.mapHonorValues[_loc6_]);
               _loc8_ = NumberConfig.getSettingObject("mapHonorLevelValues") as Array;
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  if(_loc8_[_loc9_] <= _loc7_)
                  {
                     _loc4_ = _loc9_;
                  }
                  _loc9_++;
               }
            }
         }
         else if(param3 == 2)
         {
            _loc10_ = JSONUtil.getStr(NumberConfig.getSettingObject("armyTitleNames"),[param2]);
            DiversityManager.setTextField(obf_L_6_4466,"ShopBoxUI","condition",[param1,_loc10_]);
            _loc11_ = GameContext.localPlayer.fullInfo.mapHonorValues;
            if(!_loc11_)
            {
               return;
            }
            for each(param1 in _loc11_)
            {
               _loc12_ += int(param1);
            }
            _loc13_ = NumberConfig.getSettingObject("armyTitleValues") as Array;
            _loc14_ = 0;
            while(_loc14_ < _loc13_.length)
            {
               if(_loc13_[_loc14_] <= _loc12_)
               {
                  _loc4_ = _loc14_;
               }
               _loc14_++;
            }
         }
         if(_loc4_ >= param2)
         {
            obf_L_6_4466.textColor = 16777215;
         }
         else
         {
            obf_L_6_4466.textColor = 16711680;
         }
      }
      
      public function setRemark(param1:String) : void
      {
         goodsRemark.htmlText = param1;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
   }
}

