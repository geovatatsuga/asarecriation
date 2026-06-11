package com.sunweb.game.net.framework.codec.amf3
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.net.framework.command.obf_N_F_4206;
   import obf_d_e_f_a_u_l_t_29.obf_B_X_1793;
   import flash.net.ObjectEncoding;
   import flash.utils.ByteArray;
   
   public class obf_L_d_4379 implements obf_B_X_1793
   {
      
      private var obf_y_q_2041:int = 65536;
      
      private var obf_X_P_2249:ByteArray = new ByteArray();
      
      private var obf_0_9_0_466:obf_N_F_4206;
      
      public function obf_L_d_4379(param1:obf_N_F_4206)
      {
         super();
         this.obf_0_9_0_466 = param1;
      }
      
      public function encode(param1:obf_C_m_1350) : ByteArray
      {
         var _loc2_:obf_9_r_3159 = param1 as obf_9_r_3159;
         if(_loc2_ == null)
         {
            trace("amf3 command encode error: " + param1);
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.objectEncoding = ObjectEncoding.AMF3;
         _loc3_.writeObject(_loc2_.obf_3_5_3429);
         trace("amf3 encode length: " + _loc3_.length);
         return _loc3_;
      }
      
      public function decode(param1:ByteArray) : Array
      {
         var cmdArray:Array;
         var cmd:obf_9_r_3159;
         var cmdFields:Object;
         var rawDataBuffer:ByteArray = param1;
         var posMark:int = int(this.obf_X_P_2249.position);
         this.obf_X_P_2249.position = this.obf_X_P_2249.length;
         this.obf_X_P_2249.writeBytes(rawDataBuffer);
         this.obf_X_P_2249.position = posMark;
         cmdArray = null;
         cmd = null;
         cmdFields = null;
         while(true)
         {
            cmd = null;
            cmdFields = null;
            if(this.obf_X_P_2249.bytesAvailable == 0)
            {
               break;
            }
            try
            {
               cmdFields = this.obf_X_P_2249.readObject();
            }
            catch(e:Error)
            {
               break;
            }
            if(cmdFields == null)
            {
               break;
            }
            try
            {
               cmd = this.obf_0_9_0_466.obf_F_t_3602(cmdFields.code) as obf_9_r_3159;
               if(cmd != null)
               {
                  cmd.obf_3_5_3429 = cmdFields;
               }
            }
            catch(e:Error)
            {
            }
            if(cmd == null)
            {
               trace("unable to decode command, code = " + cmdFields.code);
            }
            else
            {
               if(cmdArray == null)
               {
                  cmdArray = new Array();
               }
               cmdArray.push(cmd);
            }
         }
         if(this.obf_X_P_2249.length >= this.obf_y_q_2041)
         {
            this.obf_X_P_2249 = this.obf_2_n_2556(this.obf_X_P_2249);
         }
         return cmdArray;
      }
      
      private function obf_2_n_2556(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         if(param1.bytesAvailable > 0)
         {
            param1.readBytes(_loc2_);
            _loc2_.position = 0;
         }
         return _loc2_;
      }
   }
}

