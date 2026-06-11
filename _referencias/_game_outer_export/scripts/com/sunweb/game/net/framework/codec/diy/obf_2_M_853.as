package com.sunweb.game.net.framework.codec.diy
{
   import flash.errors.EOFError;
   import flash.utils.getQualifiedClassName;
   
   public class obf_2_M_853 implements obf_U_l_3209
   {
      
      private static const obf_O_P_1374:int = 65535;
      
      public function obf_2_M_853()
      {
         super();
      }
      
      public function toBytes() : obf_o_3_1715
      {
         var buf:obf_o_3_1715 = null;
         var fieldArray:Array = null;
         var field:obf_0_7_I_681 = null;
         var value:* = undefined;
         try
         {
            buf = new obf_o_3_1715();
            fieldArray = obf_z_v_3729.getParsedFieldList(this);
            for each(field in fieldArray)
            {
               value = this[field.obf_J_g_2260];
               buf.obf_0_7_v_350(value,field.obf_M_A_4351,field.arrayType,field.mapKeyType,field.mapValueType);
            }
            return buf;
         }
         catch(e:Error)
         {
            trace("DIYObject.toBytes() error: " + e.toString());
            obf_g_a_1279(obf_z_v_3729.getParsedFieldList(this));
            throw e;
         }
      }
      
      public function obf_0_6_h_240(param1:obf_o_3_1715) : void
      {
         var fieldArray:Array = null;
         var field:obf_0_7_I_681 = null;
         var value:* = undefined;
         var bytes:obf_o_3_1715 = param1;
         try
         {
            bytes.position = 0;
            fieldArray = obf_z_v_3729.getParsedFieldList(this);
            for each(field in fieldArray)
            {
               value = bytes.obf_R_S_3797(field.obf_M_A_4351,field.arrayType,field.mapKeyType,field.mapValueType);
               this[field.obf_J_g_2260] = value;
            }
         }
         catch(e:Error)
         {
            trace("DIYObject.fromBytes() error: " + e.toString());
            obf_g_a_1279(obf_z_v_3729.getParsedFieldList(this));
            throw e;
         }
      }
      
      public function obf_C_g_3882(param1:obf_o_3_1715) : void
      {
         var posOrg:int = 0;
         var posFrom:int = 0;
         var fieldArray:Array = null;
         var field:obf_0_7_I_681 = null;
         var posTo:int = 0;
         var len:int = 0;
         var value:* = undefined;
         var stream:obf_o_3_1715 = param1;
         try
         {
            posOrg = int(stream.position);
            stream.writeShort(0);
            posFrom = int(stream.position);
            fieldArray = obf_z_v_3729.getParsedFieldList(this);
            for each(field in fieldArray)
            {
               value = this[field.obf_J_g_2260];
               stream.obf_0_7_v_350(value,field.obf_M_A_4351,field.arrayType,field.mapKeyType,field.mapValueType);
            }
            posTo = int(stream.position);
            len = posTo - posFrom;
            if(len > obf_O_P_1374)
            {
               throw new Error("object too big: " + len);
            }
            stream.position = posOrg;
            stream.writeShort(len);
            stream.position = posTo;
         }
         catch(e:Error)
         {
            trace(getQualifiedClassName(this) + " DIYObject.toBytes() error: " + e.toString());
            obf_g_a_1279(obf_z_v_3729.getParsedFieldList(this));
            throw e;
         }
      }
      
      public function obf_X_1_992(param1:obf_o_3_1715) : Boolean
      {
         var posOrg:int = 0;
         var len:int = 0;
         var fieldArray:Array = null;
         var field:obf_0_7_I_681 = null;
         var value:* = undefined;
         var stream:obf_o_3_1715 = param1;
         posOrg = int(stream.position);
         try
         {
            len = int(stream.readUnsignedShort());
            if(len == 0)
            {
               return false;
            }
            if(stream.bytesAvailable < len)
            {
               throw new EOFError();
            }
            fieldArray = obf_z_v_3729.getParsedFieldList(this);
            for each(field in fieldArray)
            {
               value = stream.obf_R_S_3797(field.obf_M_A_4351,field.arrayType,field.mapKeyType,field.mapValueType);
               this[field.obf_J_g_2260] = value;
            }
         }
         catch(e:Error)
         {
            trace(getQualifiedClassName(this) + " DIYObject.fromBytes() error: " + e.toString());
            obf_g_a_1279(obf_z_v_3729.getParsedFieldList(this));
            if(stream != null)
            {
               stream.position = posOrg;
            }
            throw e;
         }
         return true;
      }
      
      protected function obf_g_a_1279(param1:Array) : void
      {
         var _loc2_:obf_0_7_I_681 = null;
         for each(_loc2_ in param1)
         {
            trace(_loc2_.getDefinition());
         }
      }
      
      public function obf_0_5_A_522(param1:obf_2_M_853) : Boolean
      {
         var toObject:obf_2_M_853 = param1;
         try
         {
            toObject.obf_0_6_h_240(this.toBytes());
         }
         catch(e:Error)
         {
            trace("DIYObject.copyTo failed: " + e.toString());
            return false;
         }
         return true;
      }
      
      public function getFieldList() : Array
      {
         return null;
      }
   }
}

