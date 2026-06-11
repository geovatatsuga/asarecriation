package com.sunweb.game.net.framework.codec.diy
{
   import flash.errors.EOFError;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class obf_o_3_1715 extends ByteArray
   {
      
      private const obf_y_h_2768:int = 127;
      
      private const FLAG_NUMBER:int = 128;
      
      private const obf_v_r_3775:int = 7;
      
      public function obf_o_3_1715()
      {
         super();
         this.endian = Endian.BIG_ENDIAN;
      }
      
      public static function test() : void
      {
         var _loc1_:obf_o_3_1715 = new obf_o_3_1715();
         trace("null value test ...");
         _loc1_.writeString(null);
         _loc1_.obf_r_k_4489(null);
         _loc1_.obf_0_3_M_651(null,"int");
         trace("byte array length: " + _loc1_.length);
         _loc1_.position = 0;
         trace(_loc1_.readString().length);
         trace(_loc1_.obf_4_o_4196().length);
         trace(_loc1_.obf_9_v_812("string").length);
         _loc1_ = new obf_o_3_1715();
         trace("random value test ...");
         _loc1_.writeByte(256 * Math.random());
         _loc1_.writeShort(65536 * Math.random());
         _loc1_.writeInt(int.MAX_VALUE * Math.random());
         _loc1_.writeString("obf_____4778");
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.length = 500;
         _loc1_.obf_r_k_4489(_loc2_);
         _loc1_.obf_0_3_M_651(["s1","s2","s3","obf___4_4859"],"string");
         trace("byte array length: " + _loc1_.length);
         _loc1_.position = 0;
         trace(_loc1_.readUnsignedByte());
         trace(_loc1_.readUnsignedShort());
         trace(_loc1_.readInt());
         trace(_loc1_.readString());
         trace(_loc1_.obf_4_o_4196().length);
         var _loc3_:Array = _loc1_.obf_9_v_812("string");
         trace(_loc3_.length);
         _loc1_ = new obf_o_3_1715();
         trace("obf___4969 test ...");
         _loc1_.writeByte(-127);
         _loc1_.writeByte(-128);
         _loc1_.writeByte(-129);
         _loc1_.writeShort(-32767);
         _loc1_.writeShort(-32768);
         _loc1_.writeShort(-32769);
         _loc1_.writeInt(-65536);
         _loc1_.position = 0;
         trace(_loc1_.readByte());
         trace(_loc1_.readByte());
         trace(_loc1_.readByte());
         trace(_loc1_.readShort());
         trace(_loc1_.readShort());
         trace(_loc1_.readShort());
         trace(_loc1_.readInt());
      }
      
      public function getCRC() : int
      {
         var b:ByteArray = null;
         try
         {
            b = MD5.hash(this);
            return ((b[0] - b[5] + b[7] - b[14] & 0xFF) << 8 | b[3] - b[4] + b[11] - b[12] & 0xFF) & 0xFFFF;
         }
         catch(e:Error)
         {
         }
         return 0;
      }
      
      public function getDigest(param1:int) : int
      {
         return this.setBitNot(this.getCRC(),param1) & 0xFFFF;
      }
      
      private function setBitNot(param1:int, param2:int) : int
      {
         return param1 & ~param2 | ~(param1 & param2) & param2;
      }
      
      public function clone() : obf_o_3_1715
      {
         var _loc1_:obf_o_3_1715 = new obf_o_3_1715();
         var _loc2_:int = int(this.position);
         this.position = 0;
         this.readBytes(_loc1_,0,this.bytesAvailable);
         this.position = _loc2_;
         return _loc1_;
      }
      
      public function obf_r_K_2434(param1:int) : void
      {
         var _loc2_:int = 0;
         while(true)
         {
            _loc2_ = param1 & this.obf_y_h_2768;
            param1 >>>= this.obf_v_r_3775;
            if(param1 == 0)
            {
               break;
            }
            _loc2_ += this.FLAG_NUMBER;
            this.writeByte(_loc2_);
         }
         this.writeByte(_loc2_);
      }
      
      public function obf_y_x_4063() : int
      {
         var _loc4_:int = 0;
         var _loc1_:int = int(this.position);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(this.bytesAvailable != 0)
         {
            _loc4_ = int(this.readUnsignedByte());
            if(_loc4_ < this.FLAG_NUMBER)
            {
               return int(_loc2_ + (_loc4_ << this.obf_v_r_3775 * _loc3_));
            }
            _loc4_ -= this.FLAG_NUMBER;
            _loc2_ += _loc4_ << this.obf_v_r_3775 * _loc3_;
            _loc3_++;
         }
         this.position = _loc1_;
         throw new EOFError("readVariableLength eof error!");
      }
      
      public function writeString(param1:String, param2:String = "utf-8") : void
      {
         if(param1 == null)
         {
            param1 = "";
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,param2);
         this.obf_r_K_2434(_loc3_.length);
         this.writeBytes(_loc3_);
      }
      
      public function readString(param1:String = "utf-8") : String
      {
         var posMark:int = 0;
         var s:String = null;
         var len:int = 0;
         var charset:String = param1;
         posMark = int(this.position);
         try
         {
            len = this.obf_y_x_4063();
            if(len == 0)
            {
               s = "";
            }
            else
            {
               s = this.readMultiByte(len,charset);
            }
         }
         catch(e:Error)
         {
            this.position = posMark;
            throw new Error("readString error: " + e.toString());
         }
         return s;
      }
      
      public function writeTransportableObject(param1:obf_U_l_3209) : void
      {
         if(param1 == null)
         {
            this.writeShort(0);
         }
         else
         {
            param1.obf_C_g_3882(this);
         }
      }
      
      public function readTransportableObject(param1:String) : obf_U_l_3209
      {
         var posMark:int = 0;
         var className:String = param1;
         posMark = int(this.position);
         var obj:obf_U_l_3209 = null;
         try
         {
            obj = obf_z_v_3729.newTransportableObject(className);
            if(!obj.obf_X_1_992(this))
            {
               return null;
            }
         }
         catch(e:Error)
         {
            this.position = posMark;
            throw new Error("readTransportableObject error: " + e.toString() + "  :" + className);
         }
         return obj;
      }
      
      public function obf_r_k_4489(param1:ByteArray) : void
      {
         if(param1 == null)
         {
            param1 = new ByteArray();
         }
         this.obf_r_K_2434(param1.length);
         this.writeBytes(param1);
      }
      
      public function obf_4_o_4196() : ByteArray
      {
         var posMark:int = 0;
         var len:int = 0;
         posMark = int(this.position);
         var data:ByteArray = new ByteArray();
         try
         {
            len = this.obf_y_x_4063();
            if(len > 0)
            {
               this.readBytes(data,0,len);
            }
         }
         catch(e:Error)
         {
            this.position = posMark;
            throw new Error("readByteArray error: " + e.toString());
         }
         return data;
      }
      
      public function obf_0_3_M_651(param1:Array, param2:String) : void
      {
         var _loc3_:* = undefined;
         if(param1 == null)
         {
            param1 = new Array();
         }
         this.obf_r_K_2434(param1.length);
         for each(_loc3_ in param1)
         {
            this.obf_0_7_v_350(_loc3_,param2);
         }
      }
      
      public function obf_9_v_812(param1:String) : Array
      {
         var posMark:int = 0;
         var len:int = 0;
         var i:int = 0;
         var dataType:String = param1;
         posMark = int(this.position);
         var arr:Array = new Array();
         try
         {
            len = this.obf_y_x_4063();
            i = 0;
            while(i < len)
            {
               arr.push(this.obf_R_S_3797(dataType));
               i++;
            }
         }
         catch(e:Error)
         {
            this.position = posMark;
            throw new Error("readArray error: " + e.toString());
         }
         return arr;
      }
      
      public function obf_N_x_4265(param1:Object, param2:String, param3:String) : void
      {
         var _loc5_:* = undefined;
         if(param1 == null)
         {
            param1 = new Object();
         }
         var _loc4_:int = 0;
         for(_loc5_ in param1)
         {
            _loc4_++;
         }
         this.obf_r_K_2434(_loc4_);
         for(_loc5_ in param1)
         {
            this.obf_0_7_v_350(_loc5_,param2);
            this.obf_0_7_v_350(param1[_loc5_],param3);
         }
      }
      
      public function obf_2_P_2779(param1:String, param2:String) : Object
      {
         var posMark:int = 0;
         var len:int = 0;
         var i:int = 0;
         var key:* = undefined;
         var value:* = undefined;
         var keyType:String = param1;
         var valueType:String = param2;
         posMark = int(this.position);
         var map:Object = new Object();
         try
         {
            len = this.obf_y_x_4063();
            i = 0;
            while(i < len)
            {
               key = this.obf_R_S_3797(keyType);
               value = this.obf_R_S_3797(valueType);
               map[key] = value;
               i++;
            }
         }
         catch(e:Error)
         {
            this.position = posMark;
            throw new Error("readMap error: " + e.toString());
         }
         return map;
      }
      
      public function obf_0_7_v_350(param1:*, param2:String, param3:String = null, param4:String = null, param5:String = null) : void
      {
         switch(param2)
         {
            case obf_P_Y_2777.STRING:
               this.writeString(param1);
               break;
            case obf_P_Y_2777.obf_C_1_1648:
            case obf_P_Y_2777.obf_U_t_4431:
               this.writeByte(param1);
               break;
            case obf_P_Y_2777.obf_C_x_1041:
            case obf_P_Y_2777.obf_V_k_1478:
               this.writeShort(param1);
               break;
            case obf_P_Y_2777.obf_6_7_3803:
               this.writeInt(param1);
               break;
            case obf_P_Y_2777.obf_X_S_1101:
               this.writeUnsignedInt(param1);
               break;
            case obf_P_Y_2777.obf_b_y_4226:
               this.obf_r_K_2434(param1);
               break;
            case obf_P_Y_2777.obf_5_C_1501:
               this.writeFloat(param1);
               break;
            case obf_P_Y_2777.obf_a_I_1869:
               this.writeDouble(param1);
               break;
            case obf_P_Y_2777.obf_0_5_b_728:
               this.writeBoolean(param1);
               break;
            case obf_P_Y_2777.obf_T_0_4552:
               this.obf_r_k_4489(param1);
               break;
            case obf_P_Y_2777.obf_j_P_1033:
               this.obf_0_3_M_651(param1,param3);
               break;
            case obf_P_Y_2777.MAP:
               this.obf_N_x_4265(param1,param4,param5);
               break;
            default:
               if(obf_z_v_3729.isTransportableClass(param2))
               {
                  this.writeTransportableObject(param1 as obf_U_l_3209);
                  break;
               }
               throw new Error("invalid data type: " + param2);
         }
      }
      
      public function obf_R_S_3797(param1:String, param2:String = null, param3:String = null, param4:String = null) : *
      {
         var _loc5_:* = undefined;
         switch(param1)
         {
            case obf_P_Y_2777.STRING:
               _loc5_ = this.readString();
               break;
            case obf_P_Y_2777.obf_C_1_1648:
               _loc5_ = this.readByte();
               break;
            case obf_P_Y_2777.obf_U_t_4431:
               _loc5_ = this.readUnsignedByte();
               break;
            case obf_P_Y_2777.obf_C_x_1041:
               _loc5_ = this.readShort();
               break;
            case obf_P_Y_2777.obf_V_k_1478:
               _loc5_ = this.readUnsignedShort();
               break;
            case obf_P_Y_2777.obf_6_7_3803:
               _loc5_ = this.readInt();
               break;
            case obf_P_Y_2777.obf_X_S_1101:
               _loc5_ = this.readUnsignedInt();
               break;
            case obf_P_Y_2777.obf_b_y_4226:
               _loc5_ = this.obf_y_x_4063();
               break;
            case obf_P_Y_2777.obf_5_C_1501:
               _loc5_ = this.readFloat();
               break;
            case obf_P_Y_2777.obf_a_I_1869:
               _loc5_ = this.readDouble();
               break;
            case obf_P_Y_2777.obf_0_5_b_728:
               _loc5_ = this.readBoolean();
               break;
            case obf_P_Y_2777.obf_T_0_4552:
               _loc5_ = this.obf_4_o_4196();
               break;
            case obf_P_Y_2777.obf_j_P_1033:
               _loc5_ = this.obf_9_v_812(param2);
               break;
            case obf_P_Y_2777.MAP:
               _loc5_ = this.obf_2_P_2779(param3,param4);
               break;
            default:
               if(obf_z_v_3729.isTransportableClass(param1))
               {
                  _loc5_ = this.readTransportableObject(param1);
                  break;
               }
               throw new Error("invalid data type: " + param1);
         }
         return _loc5_;
      }
   }
}

