package com.sunweb.game.rpg.map.pathfind.astar
{
   import com.sunweb.game.rpg.map.pathfind.astar.astarInterface.Igrid;
   import com.sunweb.game.rpg.map.pathfind.astar.astarInterface.obf_G_L_1125;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class Grid implements Igrid
   {
      
      private var _nodes:Array;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _row:int;
      
      private var obf_0_8_8_616:int;
      
      private var obf_a_7_4522:Boolean;
      
      private var obf_k_k_1914:BitmapData;
      
      private var obf_I_w_2873:Number;
      
      private var obf_0_1_0_284:Number;
      
      private var nodePool:Array;
      
      private var _startShape:Shape;
      
      private var _endShape:Shape;
      
      private var obf_F_0_3693:obf_E_U_3120;
      
      private var obf_V_M_2300:obf_E_U_3120;
      
      public function Grid(param1:Number, param2:Number, param3:int = 30, param4:int = 30)
      {
         super();
         this._width = param1;
         this._height = param2;
         this._row = param3;
         this.obf_0_8_8_616 = param4;
         this.obf_a_7_4522 = false;
         this.init();
      }
      
      private function init() : void
      {
         this.nodePool = [];
         this._nodes = [];
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         this.obf_a_7_4522 = false;
      }
      
      public function setRCnum(param1:int, param2:int) : void
      {
         this._row = param1;
         this.obf_0_8_8_616 = param2;
         this.obf_a_7_4522 = false;
      }
      
      public function drawGrid(param1:Graphics) : void
      {
         this.updata();
         param1.clear();
         param1.lineStyle(1,10066176,0.6);
         var _loc2_:Number = 0;
         while(_loc2_ < this._width)
         {
            param1.moveTo(_loc2_,0);
            param1.lineTo(_loc2_,this._height);
            _loc2_ += this.obf_I_w_2873;
         }
         param1.moveTo(_loc2_,0);
         param1.lineTo(_loc2_,this._height);
         var _loc3_:Number = 0;
         while(_loc3_ < this._height)
         {
            param1.moveTo(0,_loc3_);
            param1.lineTo(this._width,_loc3_);
            _loc3_ += this.obf_0_1_0_284;
         }
         param1.moveTo(0,_loc3_);
         param1.lineTo(this._width,_loc3_);
      }
      
      public function canvasGrid(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.fillRect(param1.rect,268435455);
         var _loc2_:Shape = new Shape();
         this.drawGrid(_loc2_.graphics);
         param1.draw(_loc2_,null,null,null,null,false);
         _loc2_ = null;
         this.obf_k_k_1914 = param1;
      }
      
      public function updata() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:obf_E_U_3120 = null;
         if(this.obf_a_7_4522)
         {
            return;
         }
         this.obf_a_7_4522 = true;
         for each(_loc1_ in this._nodes)
         {
            this.nodePool.concat(_loc1_);
         }
         this._nodes = null;
         this._nodes = [];
         this.obf_I_w_2873 = this._width / this._row;
         this.obf_0_1_0_284 = this._height / this.obf_0_8_8_616;
         trace("nodeWidth " + this.obf_I_w_2873 + "  _nodeHeight " + this.obf_0_1_0_284);
         _loc2_ = 0;
         while(_loc2_ < this.obf_0_8_8_616)
         {
            this._nodes[_loc2_] = [];
            _loc3_ = 0;
            while(_loc3_ < this._row)
            {
               _loc4_ = this.getNodeFormPool();
               _loc4_.reset();
               _loc4_.x = _loc3_;
               _loc4_.y = _loc2_;
               this._nodes[_loc2_][_loc3_] = _loc4_;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get nodeWidth() : Number
      {
         return this.obf_I_w_2873;
      }
      
      public function get nodeHeight() : Number
      {
         return this.obf_0_1_0_284;
      }
      
      private function getNodeFormPool() : obf_E_U_3120
      {
         return this.nodePool.pop() || new obf_E_U_3120();
      }
      
      public function set startNode(param1:obf_G_L_1125) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this.obf_F_0_3693 = param1 as obf_E_U_3120;
         if(this.obf_F_0_3693 == null)
         {
            return;
         }
         if(this._startShape == null)
         {
            this._startShape = new Shape();
            this._startShape.graphics.beginFill(16711680,1);
            _loc2_ = this.nodeWidth / 3;
            _loc3_ = this.nodeWidth / 2;
            this._startShape.graphics.drawCircle(_loc3_,_loc3_,_loc2_);
            this._startShape.graphics.endFill();
         }
         if(this.obf_k_k_1914)
         {
            _loc4_ = this.obf_F_0_3693.x * this.nodeWidth;
            _loc5_ = this.obf_F_0_3693.y * this.nodeHeight;
            this.obf_k_k_1914.draw(this._startShape,new Matrix(1,0,0,1,_loc4_,_loc5_),null,null,null,false);
         }
      }
      
      public function get startNode() : obf_G_L_1125
      {
         return this.obf_F_0_3693 as obf_G_L_1125;
      }
      
      public function set endNode(param1:obf_G_L_1125) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.obf_V_M_2300 != param1)
         {
            this.obf_V_M_2300 = param1 as obf_E_U_3120;
         }
         if(this.obf_V_M_2300 == null)
         {
            return;
         }
         if(this._endShape == null)
         {
            this._endShape = new Shape();
            this._endShape.graphics.beginFill(65280,1);
            _loc2_ = this.nodeWidth / 3;
            _loc3_ = this.nodeWidth / 2;
            this._endShape.graphics.drawCircle(_loc3_,_loc3_,_loc2_);
            this._endShape.graphics.endFill();
         }
         if(this.obf_k_k_1914)
         {
            _loc4_ = this.obf_V_M_2300.x * this.nodeWidth;
            _loc5_ = this.obf_V_M_2300.y * this.nodeHeight;
            this.obf_k_k_1914.draw(this._endShape,new Matrix(1,0,0,1,_loc4_,_loc5_),null,null,null,false);
         }
      }
      
      public function get endNode() : obf_G_L_1125
      {
         return this.obf_V_M_2300 as obf_G_L_1125;
      }
      
      public function drawRectByArr(param1:Array, param2:uint) : void
      {
         var _loc3_:obf_E_U_3120 = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Rectangle = null;
         if(this.obf_k_k_1914)
         {
            for each(_loc3_ in param1)
            {
               _loc4_ = _loc3_.x * this.nodeWidth;
               _loc5_ = _loc3_.y * this.nodeHeight;
               _loc6_ = new Rectangle(_loc4_ + 1,_loc5_ + 1,this.obf_I_w_2873 - 2,this.obf_0_1_0_284 - 2);
               this.obf_k_k_1914.fillRect(_loc6_,param2);
            }
         }
      }
      
      public function drawPathLine(param1:Graphics, param2:Array, param3:uint) : void
      {
         var _loc4_:obf_E_U_3120 = null;
         param1.lineStyle(0.1,param3);
         param1.moveTo((param2[0].x + 0.5) * this.obf_I_w_2873,(param2[0].y + 0.5) * this.obf_0_1_0_284);
         var _loc5_:int = 1;
         while(_loc5_ < param2.length)
         {
            _loc4_ = param2[_loc5_] as obf_E_U_3120;
            param1.lineTo((_loc4_.x + 0.5) * this.obf_I_w_2873,(_loc4_.y + 0.5) * this.obf_0_1_0_284);
            _loc5_++;
         }
      }
      
      public function drawUnWalks() : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:obf_E_U_3120 = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._nodes)
         {
            for each(_loc4_ in _loc2_)
            {
               if(!_loc4_.walkAble)
               {
                  _loc1_.push(_loc4_);
               }
            }
         }
         _loc3_ = 0;
         this.drawRectByArr(_loc1_,_loc3_);
      }
      
      public function obf_k_d_740(param1:Number, param2:Number, param3:int = -1) : void
      {
         var _loc4_:obf_E_U_3120 = this.getNodeByXY(param1,param2);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Boolean = !_loc4_.walkAble;
         if(param3 == 1)
         {
            _loc5_ = true;
         }
         else if(param3 == 0)
         {
            _loc5_ = false;
         }
         _loc4_.walkAble = _loc5_;
      }
      
      public function getNodeByXY(param1:Number, param2:Number) : obf_E_U_3120
      {
         if(param1 < 0 || param2 < 0 || param1 > this._width || param2 > this._height)
         {
            throw new Error("obf_______________10." + " x: " + param1 + "  y: " + param2);
         }
         var _loc3_:int = int(param2 / this.obf_0_1_0_284);
         var _loc4_:int = int(param1 / this.obf_I_w_2873);
         if(this._nodes[_loc3_] == null || this._nodes[_loc3_][_loc4_] == null)
         {
            throw new Error("obf____________20." + _loc3_ + " " + _loc4_ + "  x: " + param1 + "  y:" + param2);
         }
         return this._nodes[_loc3_][_loc4_] as obf_E_U_3120;
      }
      
      public function get nodes() : Array
      {
         return this._nodes;
      }
      
      public function get row() : int
      {
         return this._row;
      }
      
      public function get obf_0_7_e_155() : int
      {
         return this.obf_0_8_8_616;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function get numRows() : int
      {
         return this._row;
      }
      
      public function get numCols() : int
      {
         return this.obf_0_8_8_616;
      }
      
      public function nodesRest() : void
      {
         var _loc1_:Array = null;
         var _loc2_:obf_E_U_3120 = null;
         for each(_loc1_ in this._nodes)
         {
            for each(_loc2_ in _loc1_)
            {
               if(_loc2_.obf_y_R_2352)
               {
                  _loc2_.obf_y_R_2352 = false;
               }
            }
         }
      }
   }
}

