package com.sunweb.game.utils
{
   import fl.controls.UIScrollBar;
   import fl.core.InvalidationType;
   
   public class ResizableScrollBar extends UIScrollBar
   {
      
      public var _resizWidth:int;
      
      public function ResizableScrollBar(param1:int)
      {
         this._resizWidth = param1;
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = super.height;
            upArrow.setSize(this._resizWidth,this._resizWidth);
            upArrow.move(0,0);
            downArrow.setSize(this._resizWidth,this._resizWidth);
            downArrow.move(0,Math.max(downArrow.height,_loc1_ - downArrow.height));
            track.move(0,this._resizWidth);
            track.setSize(this._resizWidth,Math.max(0,_loc1_ - (downArrow.height + upArrow.height)));
            thumb.setSize(this._resizWidth,thumb.height);
            updateThumb();
         }
         if(isInvalid(InvalidationType.STYLES,InvalidationType.STATE))
         {
            setStyles();
         }
         downArrow.drawNow();
         upArrow.drawNow();
         track.drawNow();
         thumb.drawNow();
         validate();
      }
   }
}

