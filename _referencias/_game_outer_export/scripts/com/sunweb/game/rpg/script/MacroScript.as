package com.sunweb.game.rpg.script
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.obf_3_U_4495;
   import com.sunweb.game.rpg.netRole.obf_n_u_l_l_2508;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class MacroScript
   {
      
      public function MacroScript()
      {
         super();
      }
      
      public static function getMacroDisplay(param1:String, param2:*) : Array
      {
         var _loc5_:String = null;
         var _loc6_:ItemShowBoxUI = null;
         var _loc7_:Sprite = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:Sprite = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:Sprite = null;
         var _loc12_:DisplayObject = null;
         var _loc3_:Array = new Array();
         var _loc4_:TextField = new TextField();
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.selectable = false;
         _loc4_.textColor = 16777215;
         if(param1 == "receiveItems")
         {
            for(_loc5_ in param2)
            {
               _loc6_ = new ItemShowBoxUI(_loc5_,param2[_loc5_]);
               if(_loc6_.haveItem)
               {
                  _loc3_.push(_loc6_);
               }
            }
         }
         else if(param1 == "addGold")
         {
            _loc7_ = new Sprite();
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addGold",null,true);
            _loc7_.addChild(_loc4_);
            _loc8_ = obf_a_f_2935.getGoldDisplay(param2);
            _loc8_.x = _loc7_.width + 5;
            _loc7_.addChild(_loc8_);
            _loc3_.push(_loc7_);
         }
         else if(param1 == "addMoney")
         {
            _loc9_ = new Sprite();
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addMoney",null,true);
            _loc9_.addChild(_loc4_);
            _loc10_ = obf_a_f_2935.getMoneyDisplay(param2);
            _loc10_.x = _loc9_.width + 5;
            _loc9_.addChild(_loc10_);
            _loc3_.push(_loc9_);
         }
         else if(param1 == "addRoleExp")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addRoleExp",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addRoleExpUnit")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addRoleExpUnit",null,true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addGoldUnit")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addGoldUnit",null,true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addSkillExpPlant")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFarmSkillExp",[FarmManager.getKindName(obf_3_U_4495.PLANT),param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addSkillExpCrop")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFarmSkillExp",[FarmManager.getKindName(obf_3_U_4495.obf_0___D_549),param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addSkillExpAnimal")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFarmSkillExp",[FarmManager.getKindName(obf_3_U_4495.obf_d_z_1837),param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addSkillExpMine")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFarmSkillExp",[FarmManager.getKindName(obf_3_U_4495.obf_A_q_1072),param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "dropGroup")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","dropGroup",null,true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addFamilyGold")
         {
            _loc11_ = new Sprite();
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyGold",null,true);
            _loc11_.addChild(_loc4_);
            _loc12_ = obf_a_f_2935.getGoldDisplay(param2);
            _loc12_.x = _loc11_.width + 5;
            _loc11_.addChild(_loc12_);
            _loc3_.push(_loc11_);
         }
         else if(param1 == "addFamilyRes1")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyRes1",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addFamilyRes2")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyRes2",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addFamilyRes3")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyRes3",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addFamilyExp")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyExp",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addFamilyGx")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addFamilyGx",[param2],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "addTitle")
         {
            DiversityManager.setTextField(_loc4_,"MacroPrompt","addTitle",[obf_n_u_l_l_2508.getPlayerTitle(param2,GameContext.localPlayer)],true);
            _loc3_.push(_loc4_);
         }
         else if(param1 == "label")
         {
            _loc4_.htmlText = param2;
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
   }
}

