package obf_0_2_D_106
{
   import flash.utils.ByteArray;
   
   public class obf_I_X_2705
   {
      
      private var obf_z_Q_2532:Array;
      
      private var _width:int;
      
      private var _height:int;
      
      public function obf_I_X_2705()
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
            _loc4_.length = Math.ceil(param1 / 8);
            _loc3_++;
         }
      }
      
      public function setFullPassable(param1:Boolean) : void
      {
         var _loc4_:ByteArray = null;
         var _loc2_:int = param1 ? 255 : 0;
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
         var _loc3_:ByteArray = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._height)
         {
            _loc3_ = this.obf_z_Q_2532[_loc2_] as ByteArray;
            _loc1_.push(this.byteArrayToArray(_loc3_));
            _loc2_++;
         }
         _loc1_.push({
            "width":this._width,
            "height":this._height
         });
         return _loc1_;
      }
      
      public function decode(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc2_:Object = param1[param1.length - 1];
         this._width = _loc2_.width;
         this._height = _loc2_.height;
         this.obf_z_Q_2532 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._height)
         {
            _loc4_ = param1[_loc3_];
            this.obf_z_Q_2532.push(this.arrayToByteArray(_loc4_));
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
         var _loc4_:int = Math.floor(param1 / 8);
         var _loc5_:int = param1 % 8;
         _loc3_.position = _loc4_;
         var _loc6_:int = _loc3_.readByte();
         _loc6_ = _loc6_ & 1 << _loc5_;
         return _loc6_ != 0;
      }
      
      public function setPassable(param1:int, param2:int, param3:Boolean) : void
      {
         if(param1 < 0 || param1 >= this._width || param2 < 0 || param2 >= this._height)
         {
            return;
         }
         var _loc4_:ByteArray = this.obf_z_Q_2532[param2] as ByteArray;
         var _loc5_:int = Math.floor(param1 / 8);
         var _loc6_:int = param1 % 8;
         _loc4_.position = _loc5_;
         var _loc7_:int = _loc4_.readByte();
         if(param3)
         {
            _loc7_ |= 1 << _loc6_;
         }
         else
         {
            _loc7_ &= 255 - (1 << _loc6_);
         }
         _loc4_.position = _loc5_;
         _loc4_.writeByte(_loc7_);
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      private function cloneObject(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      private function byteArrayToArray(param1:ByteArray) : Array
      {
         param1.position = 0;
         var _loc2_:Array = new Array();
         while(param1.bytesAvailable > 0)
         {
            _loc2_.push(param1.readByte());
         }
         return _loc2_;
      }
      
      private function arrayToByteArray(param1:Array) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeByte(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

