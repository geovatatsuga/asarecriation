package com.sunweb.game.rpg.map.pathfind.astar
{
   import flash.utils.getTimer;
   
   public class obf_1_Q_4434
   {
      
      private static var _instance:obf_1_Q_4434;
      
      public static var obf_W_1_2845:Boolean = false;
      
      public static var obf_d_l_3324:uint = 0;
      
      private var _arrange:Arrange;
      
      public var obf_T_J_1162:Array;
      
      private var obf_0_1_c_566:Function;
      
      private var obf_V_M_2300:obf_E_U_3120;
      
      private var obf_F_0_3693:obf_E_U_3120;
      
      private var _grid:Grid;
      
      private var obf_s_4636:int = 0;
      
      public var obf_m_N_3458:Array = [];
      
      private var sqrt_2:Number = 1.4142135623730951;
      
      public function obf_1_Q_4434(param1:Single)
      {
         super();
      }
      
      public static function obf_N_w_2712(param1:Grid) : Array
      {
         if(param1 == null || param1.startNode == null || param1.endNode == null)
         {
            return null;
         }
         if(_instance == null)
         {
            _instance = new obf_1_Q_4434(new Single());
         }
         return _instance.obf_v_Q_937(param1);
      }
      
      public static function get obf_T_J_1162() : Array
      {
         if(_instance)
         {
            return _instance.obf_T_J_1162;
         }
         return null;
      }
      
      public static function get obf_m_N_3458() : Array
      {
         if(_instance)
         {
            return _instance.obf_m_N_3458;
         }
         return null;
      }
      
      private function obf_v_Q_937(param1:Grid) : Array
      {
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:obf_E_U_3120 = null;
         var _loc19_:Boolean = false;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:obf_E_U_3120 = null;
         var _loc23_:obf_E_U_3120 = null;
         var _loc2_:uint = uint(getTimer());
         obf_d_l_3324 = 0;
         this.obf_T_J_1162 = [];
         this._arrange = new Arrange();
         this._arrange.key = "h";
         this.obf_0_1_c_566 = this.obf_0_7_7_358;
         this.obf_F_0_3693 = param1.startNode as obf_E_U_3120;
         this.obf_V_M_2300 = param1.endNode as obf_E_U_3120;
         var _loc3_:obf_E_U_3120 = this.obf_F_0_3693;
         _loc3_.f = 0;
         _loc3_.g = _loc3_.h = 0;
         var _loc4_:int = param1.row - 1;
         var _loc5_:int = param1.obf_0_7_e_155 - 1;
         var _loc6_:Array = param1.nodes as Array;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(_loc3_ != this.obf_V_M_2300)
         {
            _loc12_ = _loc3_.x - 1;
            _loc13_ = _loc3_.x + 1;
            _loc14_ = _loc3_.y - 1;
            _loc15_ = _loc3_.y + 1;
            if(_loc12_ < 0)
            {
               _loc12_ = 0;
            }
            if(_loc13_ > _loc4_)
            {
               _loc13_ = _loc4_;
            }
            if(_loc14_ < 0)
            {
               _loc14_ = 0;
            }
            if(_loc15_ > _loc5_)
            {
               _loc15_ = _loc5_;
            }
            _loc16_ = _loc12_;
            while(_loc16_ <= _loc13_)
            {
               _loc17_ = _loc14_;
               for(; _loc17_ <= _loc15_; _loc17_++)
               {
                  ++obf_d_l_3324;
                  _loc18_ = _loc6_[_loc17_][_loc16_] as obf_E_U_3120;
                  if(!(_loc18_ == null || !_loc18_.walkAble || _loc18_ == _loc3_))
                  {
                     _loc19_ = !(_loc18_.x == _loc3_.x || _loc18_.y == _loc3_.y);
                     if(_loc19_)
                     {
                        _loc22_ = _loc6_[_loc18_.y][_loc3_.x];
                        _loc23_ = _loc6_[_loc3_.y][_loc18_.x];
                        if(_loc22_.walkAble == false && _loc23_.walkAble == false)
                        {
                           continue;
                        }
                     }
                     _loc20_ = _loc19_ ? 1.4 : 1;
                     _loc21_ = _loc3_.f + _loc20_;
                     if(_loc18_.obf_y_R_2352)
                     {
                        _loc8_++;
                        if(_loc18_.f > _loc21_)
                        {
                           _loc18_.f = _loc21_;
                           _loc18_.h = _loc18_.f + _loc18_.g;
                           _loc18_.parent = _loc3_;
                        }
                     }
                     else
                     {
                        _loc9_++;
                        _loc18_.obf_y_R_2352 = true;
                        _loc18_.f = _loc21_;
                        _loc18_.g = this.obf_0_1_c_566(_loc18_);
                        _loc18_.h = _loc18_.f + _loc18_.g;
                        _loc18_.parent = _loc3_;
                        this._arrange.obf_0_1_K_177(_loc18_);
                     }
                  }
               }
               _loc16_++;
            }
            _loc3_ = this._arrange.pop() as obf_E_U_3120;
            if(_loc3_ == null)
            {
               return null;
            }
         }
         var _loc10_:Array = [];
         while(_loc3_ != this.obf_F_0_3693)
         {
            _loc10_.unshift(_loc3_);
            _loc3_ = _loc3_.parent as obf_E_U_3120;
         }
         _loc10_.unshift(_loc3_);
         var _loc11_:uint = getTimer() - _loc2_;
         if(obf_W_1_2845)
         {
            _loc10_ = this.obf_T_a_1986(_loc10_);
         }
         return _loc10_;
      }
      
      private function obf_T_a_1986(param1:Array) : Array
      {
         var clean:Array;
         var currentFace:int;
         var oldTimer:uint;
         var i:int;
         var node:obf_E_U_3120 = null;
         var endP:obf_E_U_3120 = null;
         var face:int = 0;
         var test:obf_E_U_3120 = null;
         var num:int = 0;
         var arr:Array = param1;
         var getface:Function = function(param1:obf_E_U_3120):int
         {
            return (param1.y - node.y) * 10 + (param1.x - node.x);
         };
         if(arr == null || arr.length < 3)
         {
            return arr;
         }
         clean = [];
         node = arr[0];
         currentFace = getface(arr[1]);
         clean.push(node);
         oldTimer = uint(getTimer());
         i = 1;
         while(i < arr.length)
         {
            test = arr[i];
            face = getface(test);
            if(face != currentFace)
            {
               num++;
               if(endP)
               {
                  clean.push(endP);
               }
               endP = test;
               currentFace = face;
            }
            else
            {
               endP = test;
            }
            node = test;
            i++;
         }
         clean.push(endP);
         return clean;
      }
      
      private function obf_0_7_7_358(param1:obf_E_U_3120) : Number
      {
         var _loc2_:int = this.obf_V_M_2300.x - param1.x;
         var _loc3_:int = this.obf_V_M_2300.y - param1.y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      private function obf_r_x_3651(param1:obf_E_U_3120) : Number
      {
         var _loc2_:int = this.obf_V_M_2300.x - param1.x;
         var _loc3_:int = this.obf_V_M_2300.y - param1.y;
         if(_loc2_ < 0)
         {
            _loc2_ *= -1;
         }
         if(_loc3_ < 0)
         {
            _loc3_ *= -1;
         }
         var _loc4_:int = _loc2_ < _loc3_ ? _loc2_ : _loc3_;
         return _loc4_ * this.sqrt_2 + (_loc2_ + _loc3_ - 2 * _loc4_);
      }
      
      private function manhattan(param1:obf_E_U_3120) : int
      {
         var _loc2_:int = this.obf_V_M_2300.x - param1.x;
         var _loc3_:int = this.obf_V_M_2300.y - param1.y;
         if(_loc2_ < 0)
         {
            _loc2_ *= -1;
         }
         if(_loc3_ < 0)
         {
            _loc3_ *= -1;
         }
         return _loc2_ + _loc3_;
      }
   }
}

class Single
{
   
   public function Single()
   {
      super();
   }
}
