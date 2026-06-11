package com.sunweb.game.rpg.playerUI.managers
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import gs.easing.obf_u_l_3524;
   
   public class obf_9_7_2639
   {
      
      private static var promptObj:Object;
      
      public static var obf_L_L_4010:Boolean;
      
      public function obf_9_7_2639()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         promptObj = param1;
      }
      
      public static function getPrompt(param1:String) : Array
      {
         if(!promptObj)
         {
            return null;
         }
         return promptObj[param1];
      }
      
      public static function showPromptRes(param1:Sprite, param2:String, param3:Point) : DisplayObject
      {
         var _loc6_:String = null;
         var _loc7_:DisplayObject = null;
         if(!param1 || obf_L_l_4100.isEmpty(param2))
         {
            return null;
         }
         if(!param3)
         {
            param3 = new Point();
         }
         var _loc4_:Array = param2.split(",");
         var _loc5_:Sprite = new Sprite();
         for each(_loc6_ in _loc4_)
         {
            _loc7_ = ResourceManager.instance.getDisplayObject(_loc6_);
            if(_loc7_)
            {
               _loc5_.addChild(_loc7_);
            }
         }
         _loc5_.x = param3.x;
         _loc5_.y = param3.y;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      public static function initNoviceSprite(param1:obf_0_d_4341) : void
      {
         param1.noviceSprite = new Sprite();
         param1.noviceSprite.mouseEnabled = false;
         param1.noviceSprite.mouseChildren = false;
         if(param1 is DisplayObjectContainer)
         {
            (param1 as DisplayObjectContainer).addChild(param1.noviceSprite);
         }
      }
      
      public static function obf_L_s_2876(param1:obf_0_d_4341) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Point = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Point = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:DisplayObject = null;
         if(!param1 || !(param1 as DisplayObject).visible)
         {
            return;
         }
         var _loc2_:Array = getPrompt(param1.novicePromptName);
         for each(_loc3_ in _loc2_)
         {
            if(!ConditionScript.checkCondition(_loc3_.con))
            {
               removeNovicePrompt(_loc3_,param1.noviceSprite);
               removeHighLight(_loc3_);
            }
            else
            {
               _loc4_ = new Point();
               if(_loc3_.point)
               {
                  _loc4_.x = JSONUtil.getInt(_loc3_,["point","x"]);
                  _loc4_.y = JSONUtil.getInt(_loc3_,["point","y"]);
               }
               else if(_loc3_.target)
               {
                  _loc4_ = param1.getTargetPoint(_loc3_.target);
               }
               if(_loc4_)
               {
                  if(Boolean(_loc3_.novicePrompt) && _loc3_.novicePrompt is DisplayObject)
                  {
                     (_loc3_.novicePrompt as DisplayObject).x = _loc4_.x;
                     (_loc3_.novicePrompt as DisplayObject).y = _loc4_.y;
                  }
                  else
                  {
                     _loc3_.novicePrompt = showPromptRes(param1.noviceSprite,_loc3_.res,_loc4_);
                     if((param1 as DisplayObject).visible)
                     {
                        _loc5_ = ResourceManager.instance.getDisplayObject(_loc3_.res);
                        if(_loc5_)
                        {
                           _loc5_.x = GameContext.gameStage.stageWidth / 2;
                           _loc5_.y = GameContext.gameStage.stageHeight / 2;
                           _loc5_.scaleX = 2;
                           _loc5_.scaleY = 2;
                           _loc5_.alpha = 0;
                           _loc6_ = (param1.noviceSprite as DisplayObject).localToGlobal(_loc4_);
                           _loc7_ = [{
                              "showTimeSec":1,
                              "scaleX":1,
                              "scaleY":1,
                              "alpha":1
                           },{
                              "showTimeSec":2,
                              "x":_loc6_.x,
                              "y":_loc6_.y,
                              "ease":obf_u_l_3524.easeOut
                           }];
                           obf_K_e_3075.showUITweenActs(_loc5_,_loc7_);
                        }
                     }
                  }
               }
               else if(_loc3_.novicePrompt)
               {
                  removeNovicePrompt(_loc3_,param1.noviceSprite);
               }
               if(!obf_L_l_4100.isEmpty(_loc3_.target) || !obf_L_l_4100.isEmpty(_loc3_.highLightShow))
               {
                  _loc8_ = !obf_L_l_4100.isEmpty(_loc3_.target) ? _loc3_.target : _loc3_.highLightShow;
                  removeHighLight(_loc3_);
                  if(obf_L_L_4010)
                  {
                     _loc9_ = param1.getHighLightDisplayObject(_loc8_);
                  }
                  if(_loc9_)
                  {
                     _loc3_.highLight = _loc9_;
                     _loc9_.filters = [new GlowFilter(16777215,1,5,5,2),obf_9_V_1635.getHighLightFilter()];
                  }
               }
            }
         }
      }
      
      public static function obf_0___V_239(param1:obf_0_d_4341) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Array = getPrompt(param1.novicePromptName);
         for each(_loc3_ in _loc2_)
         {
            removeNovicePrompt(_loc3_,param1.noviceSprite);
            removeHighLight(_loc3_);
         }
      }
      
      private static function removeNovicePrompt(param1:Object, param2:Sprite) : void
      {
         if(Boolean(param1.novicePrompt) && Boolean(param1.novicePrompt is DisplayObject) && param2.contains(param1.novicePrompt))
         {
            param2.removeChild(param1.novicePrompt);
            delete param1.novicePrompt;
         }
      }
      
      private static function removeHighLight(param1:Object) : void
      {
         if(Boolean(param1.highLight) && param1.highLight is DisplayObject)
         {
            (param1.highLight as DisplayObject).filters = [];
            delete param1.highLight;
         }
      }
   }
}

