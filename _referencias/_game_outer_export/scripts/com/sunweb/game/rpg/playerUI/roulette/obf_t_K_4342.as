package com.sunweb.game.rpg.playerUI.roulette
{
   public class obf_t_K_4342
   {
      
      public var timeInvLimit:int;
      
      private var cursors:Array = new Array();
      
      public var removeCursor:Array = new Array();
      
      public function obf_t_K_4342()
      {
         super();
      }
      
      public static function get1CursorActionList(param1:int, param2:int) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:obf_Y_s_2472 = new obf_Y_s_2472(param2,param1);
         _loc4_.action(obf_0_7_g_595.BEGINNING_STATUS);
         var _loc5_:obf_t_K_4342 = new obf_t_K_4342();
         _loc5_.obf_F_v_2549(_loc4_);
         _loc3_.push(_loc5_);
         return _loc3_;
      }
      
      public static function getIndexInWheel(param1:int, param2:int) : int
      {
         while(param1 < 0 || param1 >= param2)
         {
            if(param1 >= param2)
            {
               param1 -= param2;
            }
            else if(param1 < 0)
            {
               param1 += param2;
            }
         }
         return param1;
      }
      
      public function obf_F_v_2549(param1:obf_0_7_g_595, param2:obf_0_7_g_595 = null) : void
      {
         this.cursors.push({
            "cursor1":param1,
            "dock1":param2
         });
      }
      
      public function getInsertCursors() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:obf_0_7_g_595 = null;
         var _loc4_:obf_0_7_g_595 = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.cursors)
         {
            _loc3_ = _loc2_.cursor1;
            if(_loc3_)
            {
               _loc4_ = _loc2_.dock1;
               if(_loc4_)
               {
                  _loc3_.cursorIndex = _loc4_.cursorIndex;
               }
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
   }
}

