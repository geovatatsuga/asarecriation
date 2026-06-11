package com.sunweb.game.net.framework.codec.diy
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.net.framework.command.obf_N_F_4206;
   import obf_d_e_f_a_u_l_t_29.obf_B_X_1793;
   import flash.utils.ByteArray;
   
   public class obf_0_6_T_533 implements obf_B_X_1793
   {
      
      private var obf_0_9_0_466:obf_N_F_4206;
      
      private var obf_y_q_2041:int = 524288;
      
      private var obf_d_J_3225:obf_o_3_1715 = new obf_o_3_1715();
      
      public function obf_0_6_T_533(param1:obf_N_F_4206)
      {
         super();
         this.obf_0_9_0_466 = param1;
      }
      
      public function encode(param1:obf_C_m_1350) : ByteArray
      {
         var _loc2_:obf_O_8_1034 = param1 as obf_O_8_1034;
         var _loc3_:obf_o_3_1715 = _loc2_.toBytes();
         var _loc4_:int = _loc2_.code;
         if(_loc2_.getCompressThreshold() > 0 && _loc3_.length >= _loc2_.getCompressThreshold())
         {
            _loc3_.compress();
            _loc4_ |= 32768;
         }
         var _loc5_:obf_o_3_1715 = new obf_o_3_1715();
         _loc5_.obf_r_K_2434(_loc3_.length + 4);
         _loc5_.writeShort(_loc4_);
         if(_loc2_.getDigestKey() != 0)
         {
            _loc5_.writeShort(_loc3_.getDigest(_loc2_.getDigestKey()));
         }
         else
         {
            _loc5_.writeShort(0);
         }
         _loc5_.writeBytes(_loc3_);
         return _loc5_;
      }
      
      public function decode(param1:ByteArray) : Array
      {
         var _loc2_:int = int(this.obf_d_J_3225.position);
         this.obf_d_J_3225.position = this.obf_d_J_3225.length;
         this.obf_d_J_3225.writeBytes(param1);
         this.obf_d_J_3225.position = _loc2_;
         var _loc3_:Array = null;
         var _loc4_:obf_O_8_1034 = null;
         while(true)
         {
            _loc4_ = this.obf_P_q_2295();
            if(_loc4_ == null)
            {
               break;
            }
            if(_loc3_ == null)
            {
               _loc3_ = new Array();
            }
            _loc3_.push(_loc4_);
         }
         if(this.obf_d_J_3225.length >= this.obf_y_q_2041)
         {
            this.obf_d_J_3225 = this.obf_2_n_2556(this.obf_d_J_3225);
         }
         return _loc3_;
      }
      
      private function isCommandDataReady() : Boolean
      {
         var posMark:int;
         var isReady:Boolean;
         var cmdLen:int = 0;
         if(this.obf_d_J_3225.bytesAvailable == 0)
         {
            return false;
         }
         posMark = int(this.obf_d_J_3225.position);
         try
         {
            cmdLen = this.obf_d_J_3225.obf_y_x_4063();
         }
         catch(e:Error)
         {
            cmdLen = -1;
         }
         isReady = cmdLen > 0 && this.obf_d_J_3225.bytesAvailable >= cmdLen;
         this.obf_d_J_3225.position = posMark;
         return isReady;
      }
      
      private function obf_P_q_2295() : obf_O_8_1034
      {
         var cmdLen:int;
         var cmdCode:int;
         var crcNum:int;
         var cmdData:obf_o_3_1715;
         var cmdDataLen:int;
         var cmdDataRaw:obf_o_3_1715;
         var cmd:obf_O_8_1034;
         if(!this.isCommandDataReady())
         {
            return null;
         }
         cmdLen = this.obf_d_J_3225.obf_y_x_4063();
         cmdCode = int(this.obf_d_J_3225.readUnsignedShort());
         crcNum = int(this.obf_d_J_3225.readUnsignedShort());
         cmdData = new obf_o_3_1715();
         cmdDataLen = cmdLen - 4;
         if(cmdDataLen > 0)
         {
            this.obf_d_J_3225.readBytes(cmdData,0,cmdDataLen);
         }
         cmdDataRaw = cmdData;
         if((cmdCode & 0x8000) != 0)
         {
            cmdDataRaw = cmdData.clone();
            try
            {
               cmdData.uncompress();
               cmdCode &= 32767;
            }
            catch(e:Error)
            {
               trace("==== DIYCodec.readOneCommand() uncompress error!");
               return null;
            }
         }
         cmd = this.obf_0_9_0_466.obf_F_t_3602(cmdCode) as obf_O_8_1034;
         if(cmd == null)
         {
            trace("command read error, invalid command code: " + cmdCode);
            return this.obf_P_q_2295();
         }
         cmd.obf_0_6_h_240(cmdData);
         if(cmd.getDigestKey() != 0)
         {
            if(crcNum != cmdDataRaw.getDigest(cmd.getDigestKey()))
            {
               trace("command crc error!");
               return null;
            }
         }
         return cmd;
      }
      
      private function obf_2_n_2556(param1:obf_o_3_1715) : obf_o_3_1715
      {
         var _loc2_:obf_o_3_1715 = new obf_o_3_1715();
         if(param1.bytesAvailable > 0)
         {
            param1.readBytes(_loc2_);
            _loc2_.position = 0;
         }
         return _loc2_;
      }
   }
}

