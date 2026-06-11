package obf_0_2_D_106
{
   import flash.utils.ByteArray;
   
   public class obf_8_0_1527
   {
      
      private var obf_z_Q_2532:Array;
      
      private var _width:int;
      
      private var _height:int;
      
      public function obf_8_0_1527()
      {
         super();
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         var _loc4_:ByteArray = null;
         this._width = param1;
         this._height = param2;
         if(this.obf_z_Q_2532 == null)
         {
            this.obf_z_Q_2532 = new Array();
         }
         this.obf_z_Q_2532.length = param2;
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = this.obf_z_Q_2532[_loc3_] as ByteArray;
            if(_loc4_ == null)
            {
               _loc4_ = new ByteArray();
               this.obf_z_Q_2532[_loc3_] = _loc4_;
            }
            _loc4_.length = param1;
            _loc3_++;
         }
      }
      
      public function setFullPassable(param1:Boolean) : void
      {
         var _loc4_:ByteArray = null;
         var _loc2_:int = param1 ? 1 : 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._height)
         {
            _loc4_ = this.obf_z_Q_2532[_loc3_] as ByteArray;
            _loc4_.position = 0;
            while(_loc4_.bytesAvailable > 0)
            {
               _loc4_.writeByte(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function encode() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:obf_I_X_2705 = new obf_I_X_2705();
         _loc1_.setSize(this._width,this._height);
         var _loc2_:int = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = 0;
            while(_loc3_ < this._width)
            {
               _loc1_.setPassable(_loc3_,_loc2_,this.getPassable(_loc3_,_loc2_));
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_.encode();
      }
      
      public function decode(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:obf_I_X_2705 = new obf_I_X_2705();
         _loc2_.decode(param1);
         this.setSize(_loc2_.width,_loc2_.height);
         var _loc3_:int = 0;
         while(_loc3_ < this._height)
         {
            _loc4_ = 0;
            while(_loc4_ < this._width)
            {
               this.setPassable(_loc4_,_loc3_,_loc2_.getPassable(_loc4_,_loc3_));
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function getPassable(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= this._width || param2 < 0 || param2 >= this._height)
         {
            return false;
         }
         var _loc3_:ByteArray = this.obf_z_Q_2532[param2] as ByteArray;
         _loc3_.position = param1;
         return _loc3_.readByte() != 0;
      }
      
      public function setPassable(param1:int, param2:int, param3:Boolean) : void
      {
         if(param1 < 0 || param1 >= this._width || param2 < 0 || param2 >= this._height)
         {
            return;
         }
         var _loc4_:ByteArray = this.obf_z_Q_2532[param2] as ByteArray;
         _loc4_.position = param1;
         _loc4_.writeByte(param3 ? 1 : 0);
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
   }
}

