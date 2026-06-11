package com.sunweb.game.rpg.role.action
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.EngineConfig;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class obf_0_2_514
   {
      
      private var obf_x_7_2216:Boolean = false;
      
      public var frameInfo:Object;
      
      public var imageData:BitmapData;
      
      public var imageSprite:Sprite;
      
      public var rootPX:int;
      
      public var rootPY:int;
      
      public var obf_s_8_1954:int;
      
      public var obf_D_C_2024:int;
      
      public var isRaw:Boolean = false;
      
      public var frames:int;
      
      public var obf_G_l_4306:Boolean = false;
      
      public var player:obf_0_M_3913;
      
      public var isEquipOrRide:Boolean = true;
      
      public var actionName:String;
      
      public var direction:int;
      
      public var rawFrameIndex:int;
      
      public var rightFrame:obf_0_2_514 = null;
      
      public var leftFrame:obf_0_2_514 = null;
      
      public function obf_0_2_514(param1:Object = null, param2:* = null)
      {
         var _loc3_:Bitmap = null;
         super();
         if(param2 == null)
         {
            param2 = EngineConfig.isBitmapModePlayerFrame;
         }
         this.obf_x_7_2216 = param2;
         if(param1 == null)
         {
            return;
         }
         if(this.obf_x_7_2216)
         {
            this.imageData = ResourceManager.instance.getBitmapData(param1.img);
            if(this.imageData == null)
            {
               throw new Error("Can not find resource: " + param1.img);
            }
         }
         else
         {
            this.imageSprite = new Sprite();
            _loc3_ = ResourceManager.instance.getBitmap(param1.img);
            if(_loc3_ == null)
            {
               throw new Error("Can not find resource: " + param1.img);
            }
            this.imageSprite.addChild(_loc3_);
         }
         this.frameInfo = param1;
         this.rootPX = param1.rootPX;
         this.rootPY = param1.rootPY;
         this.frames = param1.frames;
      }
      
      public function get isBitmapMode() : Boolean
      {
         return this.obf_x_7_2216;
      }
      
      public function redraw() : void
      {
         if(this.isEquipOrRide)
         {
            if(this.leftFrame == null)
            {
               if(this.player == null)
               {
                  return;
               }
               this.player._refreshPlayerFrame(this,this.actionName,this.direction,this.rawFrameIndex,this.rightFrame);
            }
            else
            {
               if(this.leftFrame.player == null)
               {
                  return;
               }
               this.leftFrame.player._refreshPlayerFrame(this.leftFrame,this.leftFrame.actionName,this.leftFrame.direction,this.leftFrame.rawFrameIndex,this.leftFrame.rightFrame);
            }
         }
         else
         {
            if(this.player == null)
            {
               return;
            }
            this.player._refreshRideFrame(this,this.frameInfo);
         }
      }
   }
}

