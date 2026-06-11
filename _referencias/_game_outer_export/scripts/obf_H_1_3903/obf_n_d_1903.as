package obf_H_1_3903
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_n_d_1903
   {
      
      public var timeInvLimit:int;
      
      private var cursors:Array = new Array();
      
      public var removeCursor:Array = new Array();
      
      public function obf_n_d_1903()
      {
         super();
      }
      
      public static function get1CursorActionList(param1:int, param2:int) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:obf_b_A_1800 = new obf_b_A_1800(param2,param1);
         _loc4_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc5_:obf_n_d_1903 = new obf_n_d_1903();
         _loc5_.obf_F_v_2549(_loc4_);
         _loc3_.push(_loc5_);
         return _loc3_;
      }
      
      public static function get2CursorActionList(param1:Array, param2:int) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:obf_b_A_1800 = new obf_b_A_1800(param2,JSONUtil.getInt(param1,[0]));
         _loc4_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc5_:obf_n_d_1903 = new obf_n_d_1903();
         _loc5_.obf_F_v_2549(_loc4_);
         _loc3_.push(_loc5_);
         var _loc6_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[1]));
         _loc6_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc7_:obf_n_d_1903 = new obf_n_d_1903();
         _loc7_.obf_F_v_2549(_loc6_,_loc4_);
         _loc3_.push(_loc7_);
         return _loc3_;
      }
      
      public static function get4CursorActionList(param1:Array, param2:int) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:obf_b_A_1800 = new obf_b_A_1800(param2,JSONUtil.getInt(param1,[0]));
         _loc4_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc5_:obf_n_d_1903 = new obf_n_d_1903();
         _loc5_.obf_F_v_2549(_loc4_);
         _loc3_.push(_loc5_);
         var _loc6_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[1]));
         _loc6_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc7_:obf_n_d_1903 = new obf_n_d_1903();
         _loc7_.obf_F_v_2549(_loc6_,_loc4_);
         _loc3_.push(_loc7_);
         var _loc8_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[2]));
         _loc8_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc9_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[3]));
         _loc9_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc9_.speed = -1;
         var _loc10_:obf_n_d_1903 = new obf_n_d_1903();
         _loc10_.obf_F_v_2549(_loc8_,_loc6_);
         _loc10_.obf_F_v_2549(_loc9_,_loc6_);
         _loc3_.push(_loc10_);
         return _loc3_;
      }
      
      public static function get8CursorActionList(param1:Array, param2:int) : Array
      {
         var _loc3_:Array = new Array();
         var _loc4_:obf_b_A_1800 = new obf_b_A_1800(param2,JSONUtil.getInt(param1,[0]));
         _loc4_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc5_:obf_n_d_1903 = new obf_n_d_1903();
         _loc5_.obf_F_v_2549(_loc4_);
         _loc3_.push(_loc5_);
         var _loc6_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[1]));
         _loc6_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc7_:obf_n_d_1903 = new obf_n_d_1903();
         _loc7_.obf_F_v_2549(_loc6_,_loc4_);
         _loc3_.push(_loc7_);
         var _loc8_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[2]));
         _loc8_.action(obf_G_W_823.BEGINNING_STATUS);
         var _loc9_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[3]));
         _loc9_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc9_.speed = -1;
         var _loc10_:obf_n_d_1903 = new obf_n_d_1903();
         _loc10_.obf_F_v_2549(_loc8_,_loc6_);
         _loc10_.obf_F_v_2549(_loc9_,_loc6_);
         _loc3_.push(_loc10_);
         var _loc11_:int = 3 + Math.random() * (param2 - 3);
         var _loc12_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[4]));
         _loc12_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc12_.cursorIndex = getIndexInWheel(JSONUtil.getInt(param1,[4]) - _loc11_,param2);
         _loc12_.cursorDoTimeInv = 100;
         var _loc13_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[5]));
         _loc13_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc13_.cursorIndex = getIndexInWheel(JSONUtil.getInt(param1,[5]) - _loc11_,param2);
         _loc13_.cursorDoTimeInv = 100;
         var _loc14_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[6]));
         _loc14_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc14_.cursorIndex = getIndexInWheel(JSONUtil.getInt(param1,[6]) - _loc11_,param2);
         _loc14_.cursorDoTimeInv = 100;
         var _loc15_:obf_v_l_754 = new obf_v_l_754(param2,JSONUtil.getInt(param1,[7]));
         _loc15_.action(obf_G_W_823.BEGINNING_STATUS);
         _loc15_.cursorIndex = getIndexInWheel(JSONUtil.getInt(param1,[7]) - _loc11_,param2);
         _loc15_.cursorDoTimeInv = 100;
         var _loc16_:obf_n_d_1903 = new obf_n_d_1903();
         _loc16_.obf_F_v_2549(_loc12_);
         _loc16_.obf_F_v_2549(_loc13_);
         _loc16_.obf_F_v_2549(_loc14_);
         _loc16_.obf_F_v_2549(_loc15_);
         _loc3_.push(_loc16_);
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
      
      public function obf_F_v_2549(param1:obf_G_W_823, param2:obf_G_W_823 = null) : void
      {
         this.cursors.push({
            "cursor":param1,
            "dock":param2
         });
      }
      
      public function getInsertCursors() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:obf_G_W_823 = null;
         var _loc4_:obf_G_W_823 = null;
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

