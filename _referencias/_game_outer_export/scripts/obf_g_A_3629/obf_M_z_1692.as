package obf_g_A_3629
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class obf_M_z_1692
   {
      
      public var obf_W_n_2250:TextField;
      
      public var getFace:Function;
      
      private var faceBox:Sprite;
      
      public var faceTextFormat:TextFormat;
      
      private var maskSprite:Sprite;
      
      public function obf_M_z_1692(param1:TextField)
      {
         super();
         this.obf_W_n_2250 = param1;
         this.faceBox = new Sprite();
         this.obf_W_n_2250.parent.addChild(this.faceBox);
         this.maskSprite = new Sprite();
         this.obf_W_n_2250.parent.addChild(this.maskSprite);
         this.faceBox.mask = this.maskSprite;
         this.obf_q_a_4150();
         this.faceTextFormat = new TextFormat();
         this.faceTextFormat.kerning = true;
         this.faceTextFormat.font = "obf___4942";
         this.faceTextFormat.color = 5129514;
         this.faceTextFormat.size = 1;
         this.faceTextFormat.letterSpacing = 5;
         this.obf_W_n_2250.addEventListener(Event.SCROLL,this.obf_K_k_4159);
      }
      
      public function obf_q_a_4150() : void
      {
         if(!this.faceBox || !this.maskSprite)
         {
            return;
         }
         this.faceBox.x = this.obf_W_n_2250.x;
         this.faceBox.y = this.obf_W_n_2250.y;
         this.faceBox.mouseEnabled = false;
         this.faceBox.alpha = 1;
         this.maskSprite.x = this.obf_W_n_2250.x;
         this.maskSprite.y = this.obf_W_n_2250.y;
         this.maskSprite.graphics.clear();
         this.maskSprite.graphics.beginFill(16777215);
         this.maskSprite.graphics.drawRect(0,0,this.obf_W_n_2250.width,this.obf_W_n_2250.height);
         this.maskSprite.graphics.endFill();
      }
      
      public function destroy() : void
      {
         try
         {
            this.obf_W_n_2250.removeEventListener(Event.SCROLL,this.obf_K_k_4159);
         }
         catch(e:Error)
         {
         }
         try
         {
            this.obf_W_n_2250.parent.removeChild(this.faceBox);
         }
         catch(e:Error)
         {
         }
         try
         {
            this.obf_W_n_2250.parent.removeChild(this.maskSprite);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_K_k_4159(param1:Event) : void
      {
         this.refresh();
      }
      
      public function refresh() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Rectangle = null;
         var _loc8_:String = null;
         var _loc9_:DisplayObject = null;
         if(this.faceBox.numChildren > 0)
         {
            _loc5_ = this.faceBox.numChildren;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this.faceBox.removeChildAt(0);
               _loc6_++;
            }
         }
         var _loc1_:TextLineMetrics = this.obf_W_n_2250.getLineMetrics(0);
         var _loc2_:String = this.obf_W_n_2250.text;
         var _loc3_:RegExp = /#([0-9]{2})/ig;
         var _loc4_:Object = _loc3_.exec(_loc2_);
         while(_loc4_ != null)
         {
            _loc7_ = new Rectangle();
            _loc7_ = this.obf_W_n_2250.getCharBoundaries(_loc4_.index);
            if(_loc7_ != null)
            {
               _loc8_ = _loc4_[1];
               _loc9_ = null;
               if(this.getFace != null)
               {
                  _loc9_ = this.getFace(_loc8_);
               }
               if(_loc9_ != null)
               {
                  if(this.obf_W_n_2250.width - _loc7_.x < _loc9_.width)
                  {
                     this.obf_W_n_2250.replaceText(_loc4_.index,_loc4_.index + 1,"\n #");
                     this.refresh();
                     break;
                  }
                  _loc9_.x = _loc7_.x;
                  _loc9_.y = _loc7_.y - 2 - (this.obf_W_n_2250.scrollV - 1) * _loc1_.height;
                  this.faceBox.addChild(_loc9_);
                  this.obf_W_n_2250.setTextFormat(this.faceTextFormat,_loc4_.index,_loc4_.index + 3);
               }
            }
            _loc4_ = _loc3_.exec(_loc2_);
         }
      }
   }
}

