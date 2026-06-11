package com.sunweb.game.rpg.playerBag
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import playerUI.CoinIcon;
   import playerUI.CopperIcon;
   import playerUI.DiamondIcon;
   import playerUI.GoldIcon;
   import playerUI.RMBIcon;
   import playerUI.SilverIcon;
   
   public class obf_a_f_2935
   {
      
      public static var RMB_NAME:String = DiversityManager.getString("MoneyName","moneyName");
      
      private static var goldCarry:int = 100;
      
      public function obf_a_f_2935()
      {
         super();
      }
      
      public static function getGoldValue(param1:int, param2:int, param3:int, param4:int) : Number
      {
         return param1 * Math.pow(goldCarry,3) + param2 * Math.pow(goldCarry,2) + param3 * Math.pow(goldCarry,1) + param4;
      }
      
      public static function getGoldRank(param1:Number) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:* = 3;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1 / Math.pow(goldCarry,_loc3_);
            _loc2_.push(_loc4_);
            param1 -= _loc4_ * Math.pow(goldCarry,_loc3_);
            _loc3_--;
         }
         return _loc2_;
      }
      
      public static function getGoldNotCopperRank(param1:Number) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:* = 2;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1 / Math.pow(goldCarry,_loc3_);
            _loc2_.push(_loc4_);
            param1 -= _loc4_ * Math.pow(goldCarry,_loc3_);
            _loc3_--;
         }
         return _loc2_;
      }
      
      public static function getGoldString(param1:Number, param2:Boolean = false) : String
      {
         var _loc5_:Boolean = false;
         var _loc8_:String = null;
         var _loc3_:Array = [[DiversityManager.getString("MoneyName","diamondName"),"00FFFF"],[DiversityManager.getString("MoneyName","goldName"),"FFFF00"],[DiversityManager.getString("MoneyName","silverName"),"DFDFDF"],[DiversityManager.getString("MoneyName","copperName"),"FF9900"]];
         var _loc4_:Array = getGoldRank(param1);
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.length)
         {
            if(_loc4_[_loc7_] != 0)
            {
               _loc5_ = true;
            }
            if(_loc5_)
            {
               if(param2)
               {
                  _loc8_ = "<font color=\'#" + _loc3_[_loc7_][1] + "\'>" + _loc4_[_loc7_] + _loc3_[_loc7_][0] + "</font>";
               }
               else
               {
                  _loc8_ = _loc4_[_loc7_] + _loc3_[_loc7_][0];
               }
               _loc6_ += _loc8_;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public static function getMoneyString(param1:int) : String
      {
         return param1 + RMB_NAME;
      }
      
      public static function getCoinString(param1:int) : String
      {
         return param1 + DiversityManager.getString("MoneyName","coinName");
      }
      
      public static function getGoldDisplay(param1:Number, param2:uint = 16777215) : DisplayObject
      {
         var _loc5_:Boolean = false;
         var _loc7_:DisplayObject = null;
         var _loc8_:TextField = null;
         var _loc3_:Array = getGoldRank(param1);
         var _loc4_:Sprite = new Sprite();
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            if(_loc3_[_loc6_] != 0 || _loc5_)
            {
               _loc5_ = true;
               if(_loc6_ == 0)
               {
                  _loc7_ = new DiamondIcon();
               }
               else if(_loc6_ == 1)
               {
                  _loc7_ = new GoldIcon();
               }
               else if(_loc6_ == 2)
               {
                  _loc7_ = new SilverIcon();
               }
               else if(_loc6_ == 3)
               {
                  _loc7_ = new CopperIcon();
               }
               _loc7_.x = _loc4_.width;
               _loc7_.y = 5;
               _loc4_.addChild(_loc7_);
               _loc8_ = new TextField();
               _loc8_.selectable = false;
               _loc8_.textColor = param2;
               _loc8_.autoSize = TextFieldAutoSize.LEFT;
               _loc8_.text = _loc3_[_loc6_] + "";
               _loc8_.x = _loc4_.width;
               _loc4_.addChild(_loc8_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function getGoldNotCopperDisplay(param1:Number) : DisplayObject
      {
         var _loc4_:Boolean = false;
         var _loc6_:DisplayObject = null;
         var _loc7_:TextField = null;
         var _loc2_:Array = getGoldNotCopperRank(param1);
         var _loc3_:Sprite = new Sprite();
         var _loc5_:int = 0;
         while(_loc5_ < 3)
         {
            if(_loc2_[_loc5_] != 0 || _loc4_)
            {
               _loc4_ = true;
               if(_loc5_ == 0)
               {
                  _loc6_ = new DiamondIcon();
               }
               else if(_loc5_ == 1)
               {
                  _loc6_ = new GoldIcon();
               }
               else if(_loc5_ == 2)
               {
                  _loc6_ = new SilverIcon();
               }
               _loc6_.x = _loc3_.width;
               _loc6_.y = 5;
               _loc3_.addChild(_loc6_);
               _loc7_ = new TextField();
               _loc7_.selectable = false;
               _loc7_.textColor = 16777215;
               _loc7_.autoSize = TextFieldAutoSize.LEFT;
               _loc7_.text = _loc2_[_loc5_] + "";
               _loc7_.x = _loc3_.width;
               _loc3_.addChild(_loc7_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getMoneyDisplay(param1:int, param2:uint = 16777215) : DisplayObject
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:DisplayObject = new RMBIcon();
         _loc4_.y = 5;
         _loc3_.addChild(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.selectable = false;
         _loc5_.textColor = param2;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.text = param1 + "";
         _loc5_.x = _loc3_.width;
         _loc3_.addChild(_loc5_);
         return _loc3_;
      }
      
      public static function getCoinDisplay(param1:int, param2:uint = 16777215) : DisplayObject
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:DisplayObject = new CoinIcon();
         _loc4_.y = 5;
         _loc3_.addChild(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.selectable = false;
         _loc5_.textColor = param2;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.text = param1 + "";
         _loc5_.x = _loc3_.width;
         _loc3_.addChild(_loc5_);
         return _loc3_;
      }
   }
}

