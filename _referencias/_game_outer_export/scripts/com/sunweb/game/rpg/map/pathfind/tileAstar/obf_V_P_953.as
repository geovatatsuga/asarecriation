package com.sunweb.game.rpg.map.pathfind.tileAstar
{
   import com.sunweb.game.rpg.map.Map;
   import flash.geom.Point;
   
   public class obf_V_P_953
   {
      
      private const obf_f_S_898:int = 10;
      
      private const obf_x_C_1192:int = 5;
      
      private const obf_d_B_3681:int = 11;
      
      private const obf_f_b_3286:int = 0;
      
      private const obf_3_H_4272:int = 1;
      
      private const obf_0_3_w_662:int = 2;
      
      private var m_map:Map;
      
      private var m_maxTry:int;
      
      private var m_openList:Array;
      
      private var m_openCount:int;
      
      private var m_openId:int;
      
      private var m_xList:Array;
      
      private var m_yList:Array;
      
      private var m_pathScoreList:Array;
      
      private var m_movementCostList:Array;
      
      private var m_fatherList:Array;
      
      private var m_nodeMap:Array;
      
      public function obf_V_P_953(param1:Map, param2:int = 5000)
      {
         super();
         this.m_map = param1;
         this.m_maxTry = param2;
      }
      
      public function get maxTry() : int
      {
         return this.m_maxTry;
      }
      
      public function set maxTry(param1:int) : void
      {
         this.m_maxTry = param1;
      }
      
      public function obf_u_g_1166(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Point = null;
         this.initLists();
         this.m_openCount = 0;
         this.m_openId = -1;
         this.openNode(param1,param2,0,0,0);
         var _loc5_:int = 0;
         while(this.m_openCount > 0)
         {
            if(++_loc5_ > this.m_maxTry)
            {
               this.destroyLists();
               return null;
            }
            _loc6_ = int(this.m_openList[0]);
            this.closeNode(_loc6_);
            _loc7_ = int(this.m_xList[_loc6_]);
            _loc8_ = int(this.m_yList[_loc6_]);
            if(_loc7_ == param3 && _loc8_ == param4)
            {
               return this.getPath(param1,param2,_loc6_);
            }
            _loc9_ = this.getArounds(_loc7_,_loc8_);
            for each(_loc13_ in _loc9_)
            {
               _loc11_ = this.m_movementCostList[_loc6_] + (_loc13_.x == _loc7_ ? this.obf_f_S_898 : (_loc13_.y == _loc8_ ? this.obf_x_C_1192 : this.obf_d_B_3681));
               _loc12_ = _loc11_ + Math.abs(param3 - _loc13_.x) * this.obf_f_S_898 + Math.abs(param4 - _loc13_.y) * this.obf_x_C_1192;
               if(this.isOpen(_loc13_.x,_loc13_.y))
               {
                  _loc10_ = int(this.m_nodeMap[_loc13_.y][_loc13_.x][this.obf_f_b_3286]);
                  if(_loc11_ < this.m_movementCostList[_loc10_])
                  {
                     this.m_movementCostList[_loc10_] = _loc11_;
                     this.m_pathScoreList[_loc10_] = _loc12_;
                     this.m_fatherList[_loc10_] = _loc6_;
                     this.obf_H_8_3387(this.getIndex(_loc10_));
                  }
               }
               else
               {
                  this.openNode(_loc13_.x,_loc13_.y,_loc12_,_loc11_,_loc6_);
               }
            }
         }
         this.destroyLists();
         return null;
      }
      
      private function openNode(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         ++this.m_openCount;
         ++this.m_openId;
         if(this.m_nodeMap[param2] == null)
         {
            this.m_nodeMap[param2] = [];
         }
         this.m_nodeMap[param2][param1] = [];
         this.m_nodeMap[param2][param1][this.obf_3_H_4272] = true;
         this.m_nodeMap[param2][param1][this.obf_f_b_3286] = this.m_openId;
         this.m_xList.push(param1);
         this.m_yList.push(param2);
         this.m_pathScoreList.push(param3);
         this.m_movementCostList.push(param4);
         this.m_fatherList.push(param5);
         this.m_openList.push(this.m_openId);
         this.obf_H_8_3387(this.m_openCount);
      }
      
      private function closeNode(param1:int) : void
      {
         --this.m_openCount;
         var _loc2_:int = int(this.m_xList[param1]);
         var _loc3_:int = int(this.m_yList[param1]);
         this.m_nodeMap[_loc3_][_loc2_][this.obf_3_H_4272] = false;
         this.m_nodeMap[_loc3_][_loc2_][this.obf_0_3_w_662] = true;
         if(this.m_openCount <= 0)
         {
            this.m_openCount = 0;
            this.m_openList = [];
            return;
         }
         this.m_openList[0] = this.m_openList.pop();
         this.backNode();
      }
      
      private function obf_H_8_3387(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(param1 > 1)
         {
            _loc2_ = Math.floor(param1 / 2);
            if(this.getScore(param1) >= this.getScore(_loc2_))
            {
               break;
            }
            _loc3_ = int(this.m_openList[param1 - 1]);
            this.m_openList[param1 - 1] = this.m_openList[_loc2_ - 1];
            this.m_openList[_loc2_ - 1] = _loc3_;
            param1 = _loc2_;
         }
      }
      
      private function backNode() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 1;
         while(true)
         {
            _loc2_ = _loc1_;
            if(2 * _loc2_ <= this.m_openCount)
            {
               if(this.getScore(_loc1_) > this.getScore(2 * _loc2_))
               {
                  _loc1_ = 2 * _loc2_;
               }
               if(2 * _loc2_ + 1 <= this.m_openCount)
               {
                  if(this.getScore(_loc1_) > this.getScore(2 * _loc2_ + 1))
                  {
                     _loc1_ = 2 * _loc2_ + 1;
                  }
               }
            }
            if(_loc2_ == _loc1_)
            {
               break;
            }
            _loc3_ = int(this.m_openList[_loc2_ - 1]);
            this.m_openList[_loc2_ - 1] = this.m_openList[_loc1_ - 1];
            this.m_openList[_loc1_ - 1] = _loc3_;
         }
      }
      
      private function isOpen(param1:int, param2:int) : Boolean
      {
         if(this.m_nodeMap[param2] == null)
         {
            return false;
         }
         if(this.m_nodeMap[param2][param1] == null)
         {
            return false;
         }
         return this.m_nodeMap[param2][param1][this.obf_3_H_4272];
      }
      
      private function isClosed(param1:int, param2:int) : Boolean
      {
         if(this.m_nodeMap[param2] == null)
         {
            return false;
         }
         if(this.m_nodeMap[param2][param1] == null)
         {
            return false;
         }
         return this.m_nodeMap[param2][param1][this.obf_0_3_w_662];
      }
      
      private function getArounds(param1:int, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc3_:Array = [];
         _loc4_ = param1 + 1;
         _loc5_ = param2;
         var _loc7_:Boolean = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc7_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1;
         _loc5_ = param2 + 1;
         var _loc8_:Boolean = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc8_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2;
         var _loc9_:Boolean = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc9_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1;
         _loc5_ = param2 - 1;
         var _loc10_:Boolean = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc10_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 + 1;
         _loc6_ = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc6_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 + 1;
         _loc6_ = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc6_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 - 1;
         _loc6_ = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc6_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 - 1;
         _loc6_ = this.m_map.obf_0_3_m_391(_loc4_,_loc5_);
         if((_loc6_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push(new Point(_loc4_,_loc5_));
         }
         return _loc3_;
      }
      
      private function getPath(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:int = int(this.m_xList[param3]);
         var _loc6_:int = int(this.m_yList[param3]);
         while(_loc5_ != param1 || _loc6_ != param2)
         {
            _loc4_.push(new Point(_loc5_,_loc6_));
            param3 = int(this.m_fatherList[param3]);
            _loc5_ = int(this.m_xList[param3]);
            _loc6_ = int(this.m_yList[param3]);
         }
         _loc4_.push(new Point(param1,param2));
         _loc4_.reverse();
         this.destroyLists();
         return _loc4_;
      }
      
      private function getIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 1;
         for each(_loc3_ in this.m_openList)
         {
            if(_loc3_ == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function getScore(param1:int) : int
      {
         return this.m_pathScoreList[this.m_openList[param1 - 1]];
      }
      
      private function initLists() : void
      {
         this.m_openList = [];
         this.m_xList = [];
         this.m_yList = [];
         this.m_pathScoreList = [];
         this.m_movementCostList = [];
         this.m_fatherList = [];
         this.m_nodeMap = [];
      }
      
      private function destroyLists() : void
      {
         this.m_openList = null;
         this.m_xList = null;
         this.m_yList = null;
         this.m_pathScoreList = null;
         this.m_movementCostList = null;
         this.m_fatherList = null;
         this.m_nodeMap = null;
      }
   }
}

