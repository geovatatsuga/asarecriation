package org.superkaka.kakalib.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public function searchChild(param1:DisplayObjectContainer, param2:Class) : Array
   {
      var _loc6_:DisplayObject = null;
      var _loc3_:Array = [];
      var _loc4_:int = 0;
      var _loc5_:int = param1.numChildren;
      while(_loc4_ < _loc5_)
      {
         _loc6_ = param1.getChildAt(_loc4_);
         if(_loc6_ is param2)
         {
            _loc3_.push(_loc6_);
         }
         else if(_loc6_ is DisplayObjectContainer)
         {
            _loc3_ = _loc3_.concat(searchChild(_loc6_ as DisplayObjectContainer,param2));
         }
         _loc4_++;
      }
      return _loc3_;
   }
}

