package obf_Z_P_2758
{
   public class obf_X_v_3630
   {
      
      public var timeInvLimit:int;
      
      private var cursors:Array = new Array();
      
      public var removeCursor:Array = new Array();
      
      public function obf_X_v_3630()
      {
         super();
      }
      
      public static function get1CursorActionList(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = new Array();
         var _loc5_:obf_h_k_4551 = new obf_h_k_4551(param2,param1,param3);
         _loc5_.action(FateAwardCursorBase.BEGINNING_STATUS);
         var _loc6_:obf_X_v_3630 = new obf_X_v_3630();
         _loc6_.obf_F_v_2549(_loc5_);
         _loc4_.push(_loc6_);
         return _loc4_;
      }
      
      public static function get2CursorActionList(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = new Array();
         var _loc5_:obf_h_k_4551 = new obf_h_k_4551(param2,param1,param3);
         _loc5_.action(FateAwardCursorBase.BEGINNING_STATUS);
         var _loc6_:obf_X_v_3630 = new obf_X_v_3630();
         _loc6_.obf_F_v_2549(_loc5_);
         _loc4_.push(_loc6_);
         return _loc4_;
      }
      
      public static function get3CursorActionList(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = new Array();
         var _loc5_:obf_h_k_4551 = new obf_h_k_4551(param2,param1,param3);
         _loc5_.action(FateAwardCursorBase.BEGINNING_STATUS);
         var _loc6_:obf_X_v_3630 = new obf_X_v_3630();
         _loc6_.obf_F_v_2549(_loc5_);
         _loc4_.push(_loc6_);
         return _loc4_;
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
      
      public function obf_F_v_2549(param1:FateAwardCursorBase, param2:FateAwardCursorBase = null) : void
      {
         this.cursors.push({
            "cursor":param1,
            "dock":param2
         });
      }
      
      public function getInsertCursors() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:FateAwardCursorBase = null;
         var _loc4_:FateAwardCursorBase = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.cursors)
         {
            _loc3_ = _loc2_.cursor;
            if(_loc3_)
            {
               _loc4_ = _loc2_.dock;
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

