package com.sunweb.game.rpg.map.pathfind.astar
{
   public class AcorrsLineGrid
   {
      
      private var _grid:Grid;
      
      private var _astartNodes:Array;
      
      private var nodes:Array;
      
      private var nodeWidth:Number;
      
      private var nodeHeight:Number;
      
      private var arrange:Arrange;
      
      private var obf_0_2_L_433:Number;
      
      private var obf_i_c_2996:Number;
      
      private var obf_N_a_4180:Boolean = false;
      
      private var _panXvalue:int;
      
      private var obf_w_4643:Boolean = false;
      
      private var _panYvalue:int;
      
      public function AcorrsLineGrid(param1:Grid, param2:Array = null)
      {
         super();
         this._grid = param1;
         this._astartNodes = param2;
         this.nodes = this._grid.nodes;
         this.nodeWidth = this._grid.nodeWidth;
         this.nodeHeight = this._grid.nodeHeight;
         this.arrange = new Arrange();
         this.arrange.key = "f";
      }
      
      public function getPsnode(param1:Array = null) : Array
      {
         var _loc7_:* = 0;
         var _loc8_:obf_E_U_3120 = null;
         var _loc9_:Boolean = false;
         if(param1 == null)
         {
            param1 = this._astartNodes;
         }
         if(param1 == null || this._grid == null)
         {
            throw new Error("obf____________i_n_12 AcorrsLineGrid");
         }
         var _loc2_:uint = param1.length;
         if(_loc2_ < 3)
         {
            return param1;
         }
         var _loc3_:Array = [];
         var _loc4_:obf_E_U_3120 = param1[0] as obf_E_U_3120;
         var _loc5_:obf_E_U_3120 = param1[_loc2_ - 1] as obf_E_U_3120;
         var _loc6_:uint = 0;
         _loc3_.push(_loc4_);
         while(_loc4_ != _loc5_)
         {
            _loc7_ = int(_loc2_ - 1);
            while(_loc7_ > _loc6_)
            {
               _loc8_ = param1[_loc7_] as obf_E_U_3120;
               _loc9_ = Boolean(_loc7_ - _loc6_ == 1);
               if((_loc9_) || this.isCorrsed(_loc4_,_loc8_))
               {
                  if(!_loc9_)
                  {
                     trace(_loc7_ + " >> " + _loc6_);
                  }
                  _loc4_ = _loc8_;
                  _loc6_ = _loc7_;
                  _loc3_.push(_loc8_);
                  break;
               }
               _loc7_--;
            }
         }
         return _loc3_;
      }
      
      private function isCorrsed(param1:obf_E_U_3120, param2:obf_E_U_3120) : Boolean
      {
         var minx:int;
         var maxx:int;
         var miny:int;
         var maxy:int;
         var startPx:int;
         var endPx:int;
         var startPy:int;
         var endPy:int;
         var node:obf_E_U_3120 = null;
         var px:int = 0;
         var py:int = 0;
         var acnode:obf_E_U_3120 = null;
         var i:int = 0;
         var s:obf_E_U_3120 = param1;
         var e:obf_E_U_3120 = param2;
         var getPx:Function = function(param1:Number):Number
         {
            if(obf_w_4643)
            {
               return _panYvalue;
            }
            return (param1 - obf_i_c_2996) / obf_0_2_L_433;
         };
         var getPy:Function = function(param1:Number):Number
         {
            if(obf_N_a_4180)
            {
               return _panXvalue;
            }
            return obf_0_2_L_433 * param1 + obf_i_c_2996;
         };
         var checkCorner:Function = function(param1:obf_E_U_3120):Boolean
         {
            var _loc3_:obf_E_U_3120 = null;
            var _loc4_:obf_E_U_3120 = null;
            var _loc2_:int = int(getface(param1));
            switch(_loc2_)
            {
               case 4:
                  _loc3_ = nodes[param1.y][param1.x - 1] as obf_E_U_3120;
                  _loc4_ = nodes[param1.y - 1][param1.x] as obf_E_U_3120;
                  break;
               case -2:
                  _loc3_ = nodes[param1.y][param1.x - 1] as obf_E_U_3120;
                  _loc4_ = nodes[param1.y + 1][param1.x] as obf_E_U_3120;
                  break;
               case -4:
                  _loc3_ = nodes[param1.y][param1.x + 1] as obf_E_U_3120;
                  _loc4_ = nodes[param1.y + 1][param1.x] as obf_E_U_3120;
                  break;
               case 2:
                  _loc3_ = nodes[param1.y][param1.x + 1] as obf_E_U_3120;
                  _loc4_ = nodes[param1.y + 1][param1.x] as obf_E_U_3120;
                  break;
               default:
                  return false;
            }
            if(!_loc3_.walkAble && !_loc4_.walkAble)
            {
               return true;
            }
            return false;
         };
         var getface:Function = function(param1:obf_E_U_3120):int
         {
            return int((param1.y - node.y) * 3 + (param1.x - node.x));
         };
         if(!s || !e)
         {
            return false;
         }
         this.obf_N_a_4180 = s.y == e.y;
         this.obf_w_4643 = s.x == e.x;
         if(this.obf_N_a_4180 || this.obf_w_4643)
         {
            if(this.obf_N_a_4180)
            {
               this._panXvalue = s.y * this.nodeHeight;
            }
            if(this.obf_w_4643)
            {
               this._panYvalue = s.x * this.nodeWidth;
            }
         }
         else
         {
            this.obf_0_2_L_433 = (e.y - s.y) * this.nodeHeight / ((e.x - s.x) * this.nodeWidth);
            this.obf_i_c_2996 = (e.y + 0.5) * this.nodeHeight - (e.x + 0.5) * this.nodeWidth * this.obf_0_2_L_433;
         }
         minx = Math.min(e.x,s.x);
         maxx = Math.max(e.x,s.x);
         miny = Math.min(s.y,e.y);
         maxy = Math.max(s.y,e.y);
         startPx = (minx + 0.5) * this.nodeWidth;
         endPx = (maxx + 0.5) * this.nodeWidth;
         startPy = (miny + 0.5) * this.nodeHeight;
         endPy = (maxy + 0.5) * this.nodeHeight;
         node = s.x < e.x ? s : e;
         i = minx;
         while(i <= maxx)
         {
            px = i * this.nodeWidth + 1;
            if(px >= startPx && px <= endPx)
            {
               py = getPy(px);
               acnode = this._grid.getNodeByXY(px,py);
               if(!acnode.walkAble)
               {
                  return false;
               }
               if(checkCorner(acnode))
               {
                  return false;
               }
               node = acnode;
            }
            px = (i + 1) * this.nodeWidth - 1;
            if(px >= startPx && px <= endPx)
            {
               py = getPy(px);
               acnode = this._grid.getNodeByXY(px,py);
               if(!acnode.walkAble)
               {
                  return false;
               }
               if(checkCorner(acnode))
               {
                  return false;
               }
               node = acnode;
            }
            i++;
         }
         acnode = s.y < e.y ? s : e;
         i = miny;
         while(i <= maxy)
         {
            py = i * this.nodeHeight + 1;
            if(py >= startPy && py <= endPy)
            {
               px = getPx(py);
               acnode = this._grid.getNodeByXY(px,py);
               if(!acnode.walkAble)
               {
                  return false;
               }
               if(checkCorner(acnode))
               {
                  return false;
               }
               node = acnode;
            }
            py = (i + 1) * this.nodeHeight - 1;
            if(py >= startPy && py <= endPy)
            {
               px = getPx(py);
               acnode = this._grid.getNodeByXY(px,py);
               if(!acnode.walkAble)
               {
                  return false;
               }
               if(checkCorner(acnode))
               {
                  return false;
               }
               node = acnode;
            }
            i++;
         }
         return true;
      }
   }
}

