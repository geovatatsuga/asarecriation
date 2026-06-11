package com.sunweb.game.rpg.skill
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import img.SkillClickEff;
   
   public class SkillCDManager
   {
      
      private static var cdDisplay:Object = new Object();
      
      private static var cdTimeLimiter:Object = new Object();
      
      private static var completedCDDisplay:Object = new Object();
      
      private static var obf_0_6_E_393:Object = new Object();
      
      private static var skillClickEff:SkillClickEff = new SkillClickEff(1,1);
      
      public function SkillCDManager()
      {
         super();
      }
      
      public static function getSkillCDFlag(param1:String) : String
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         var _loc3_:String = JSONUtil.getStr(_loc2_,["cdFlag"]);
         if(obf_L_l_4100.isEmpty(_loc3_))
         {
            _loc3_ = param1;
         }
         return _loc3_;
      }
      
      public static function getSkillCDTime(param1:String, param2:int) : int
      {
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         return JSONUtil.getInt(_loc3_,["levelInfo",param2 - 1,"castRule","coldTime"]);
      }
      
      public static function setSkillCD(param1:String, param2:int, param3:int) : void
      {
         if(!cdTimeLimiter[param1])
         {
            cdTimeLimiter[param1] = new Object();
            cdTimeLimiter[param1].time = new TimeLimiter(param2);
            cdTimeLimiter[param1].sn = param3;
         }
         createCDBitmapData(param1);
      }
      
      public static function setCDClickEffect(param1:String) : void
      {
         obf_0_6_E_393[param1] = new TimeLimiter(300);
      }
      
      public static function checkSkillCD(param1:String) : Boolean
      {
         if(!cdTimeLimiter[param1])
         {
            return false;
         }
         if(cdTimeLimiter[param1].time.checkTimeout())
         {
            return false;
         }
         return true;
      }
      
      public static function getCDBitmapData(param1:String) : BitmapData
      {
         createCDBitmapData(param1);
         return cdDisplay[param1];
      }
      
      public static function getCDBitmap(param1:String) : Bitmap
      {
         return new Bitmap(getCDBitmapData(param1));
      }
      
      private static function createCDBitmapData(param1:String) : void
      {
         if(!cdDisplay[param1])
         {
            cdDisplay[param1] = new BitmapData(32,32,true,0);
         }
      }
      
      public static function cancleCDBySn(param1:int) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:BitmapData = null;
         for(_loc2_ in cdTimeLimiter)
         {
            _loc3_ = cdTimeLimiter[_loc2_];
            if(_loc3_.sn == param1)
            {
               _loc4_ = getCDBitmapData(_loc2_);
               _loc4_.fillRect(new Rectangle(0,0,32,32),0);
               delete cdTimeLimiter[_loc2_];
            }
         }
      }
      
      public static function runSkillCD() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:TimeLimiter = null;
         var _loc5_:BitmapData = null;
         var _loc6_:int = 0;
         var _loc7_:Rectangle = null;
         var _loc8_:BitmapData = null;
         var _loc9_:int = 0;
         var _loc10_:TimeLimiter = null;
         var _loc11_:BitmapData = null;
         var _loc12_:Boolean = false;
         for(_loc1_ in cdTimeLimiter)
         {
            _loc4_ = cdTimeLimiter[_loc1_].time;
            _loc5_ = getCDBitmapData(_loc1_);
            if(_loc5_)
            {
               _loc6_ = _loc4_.lastCheckedInterval / _loc4_.timelimit * 32;
               _loc7_ = new Rectangle(0,0,32,_loc6_);
               _loc5_.fillRect(new Rectangle(0,0,32,32),3422552064);
               _loc5_.fillRect(new Rectangle(0,32 - _loc6_,32,32),0);
            }
            if(_loc4_.checkTimeout())
            {
               if(_loc5_)
               {
                  _loc5_.fillRect(new Rectangle(0,0,32,32),4294967295);
                  completedCDDisplay[_loc1_] = _loc5_;
               }
               delete cdTimeLimiter[_loc1_];
            }
            else if(completedCDDisplay.hasOwnProperty(_loc1_))
            {
               delete completedCDDisplay[_loc1_];
            }
         }
         for(_loc2_ in completedCDDisplay)
         {
            _loc8_ = completedCDDisplay[_loc2_] as BitmapData;
            if(_loc8_)
            {
               _loc9_ = _loc8_.getPixel32(1,1) >> 24 & 0xFF;
               if(_loc9_ > 0)
               {
                  _loc9_ -= 15;
                  if(_loc9_ < 0)
                  {
                     _loc9_ = 0;
                  }
                  _loc8_.fillRect(new Rectangle(0,0,32,32),16777215 + (_loc9_ << 24));
               }
               else
               {
                  _loc8_.fillRect(new Rectangle(0,0,32,32),0);
                  delete completedCDDisplay[_loc2_];
               }
            }
         }
         for(_loc3_ in obf_0_6_E_393)
         {
            _loc10_ = obf_0_6_E_393[_loc3_];
            _loc11_ = getCDBitmapData(_loc3_);
            if(!(!_loc10_ || !_loc11_))
            {
               _loc12_ = cdTimeLimiter.hasOwnProperty(_loc3_);
               if(_loc10_.checkTimeout(true))
               {
                  if(SkillCDManager.getSkillCDFlag(GameContext.localPlayer.obf_w_L_1217) != _loc3_)
                  {
                     delete obf_0_6_E_393[_loc3_];
                     if(!_loc12_)
                     {
                        _loc11_.fillRect(new Rectangle(0,0,32,32),0);
                     }
                  }
               }
               else
               {
                  _loc11_.copyPixels(skillClickEff,new Rectangle(0,0,32,32),new Point(),null,null,_loc12_);
               }
            }
         }
      }
   }
}

