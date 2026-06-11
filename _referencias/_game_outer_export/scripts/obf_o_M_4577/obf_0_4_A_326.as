package obf_o_M_4577
{
   import com.sunweb.game.net.framework.codec.amf3.obf_L_d_4379;
   import com.sunweb.game.net.framework.codec.diy.obf_0_6_T_533;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.net.framework.command.obf_N_F_4206;
   import obf_d_e_f_a_u_l_t_29.obf_B_X_1793;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   
   public class obf_0_4_A_326 extends EventDispatcher
   {
      
      protected var obf_Q_M_1511:Socket;
      
      protected var _host:String;
      
      protected var _port:int;
      
      protected var obf_0_9_0_466:obf_N_F_4206 = new obf_N_F_4206();
      
      protected var _commandCodecMode:String = "diy";
      
      protected var obf_D_P_2011:obf_B_X_1793;
      
      public function obf_0_4_A_326(param1:String, param2:int, param3:String = "diy")
      {
         super();
         this._host = param1;
         this._port = param2;
         this.obf_Q_M_1511 = new Socket();
         this.obf_Q_M_1511.addEventListener(Event.CONNECT,this.obf_Q_3_1444);
         this.obf_Q_M_1511.addEventListener(ProgressEvent.SOCKET_DATA,this.obf_R_l_1809);
         this.obf_Q_M_1511.addEventListener(Event.CLOSE,this.onClose);
         this.obf_Q_M_1511.addEventListener(IOErrorEvent.IO_ERROR,this.obf_0_v_3463);
         this.obf_Q_M_1511.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.obf_0_v_3463);
         if(this._commandCodecMode == "amf3")
         {
            this.obf_D_P_2011 = new obf_L_d_4379(this.obf_0_9_0_466);
         }
         else
         {
            if(this._commandCodecMode != "diy")
            {
               throw new Error("Invalid command codec mode: " + this._commandCodecMode);
            }
            this.obf_D_P_2011 = new obf_0_6_T_533(this.obf_0_9_0_466);
         }
      }
      
      public function get commandSet() : obf_N_F_4206
      {
         return this.obf_0_9_0_466;
      }
      
      public function get commandCodec() : obf_B_X_1793
      {
         return this.obf_D_P_2011;
      }
      
      public function connect() : void
      {
         this.obf_Q_M_1511.connect(this._host,this._port);
      }
      
      public function close() : void
      {
         if(this.obf_Q_M_1511.connected)
         {
            this.obf_Q_M_1511.close();
         }
      }
      
      public function sendCommand(param1:obf_C_m_1350) : void
      {
         if(this.obf_Q_M_1511.connected)
         {
            this.obf_Q_M_1511.writeBytes(this.obf_D_P_2011.encode(param1));
            this.obf_Q_M_1511.flush();
         }
      }
      
      public function sendMultiByte() : void
      {
         if(!this.obf_Q_M_1511.connected)
         {
            return;
         }
         var _loc1_:String = "tgw_l7_forward\r\nHost: " + this._host + ":" + this._port + "\r\n\r\n";
         this.obf_Q_M_1511.writeMultiByte(_loc1_,"gbk");
         this.obf_Q_M_1511.flush();
      }
      
      public function get isConnected() : Boolean
      {
         return this.obf_Q_M_1511.connected;
      }
      
      private function obf_Q_3_1444(param1:Event) : void
      {
         dispatchEvent(new obf_l_N_3214(obf_l_N_3214.obf_R_4392));
      }
      
      private function onClose(param1:Event) : void
      {
         dispatchEvent(new obf_l_N_3214(obf_l_N_3214.obf_N_7_3895));
      }
      
      private function obf_0_v_3463(param1:Event) : void
      {
         var _loc2_:obf_l_N_3214 = new obf_l_N_3214(obf_l_N_3214.obf_r_H_4569);
         _loc2_.detail = param1.toString();
         dispatchEvent(_loc2_);
         trace("error: " + param1.toString());
      }
      
      private function obf_R_l_1809(param1:ProgressEvent) : void
      {
         var _loc5_:obf_C_m_1350 = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         this.obf_Q_M_1511.readBytes(_loc2_);
         var _loc3_:Array = this.obf_D_P_2011.decode(_loc2_);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = _loc5_.code;
            _loc7_ = _loc6_ & 0xFF00;
            if(this.execCommandFilter(_loc5_))
            {
               dispatchEvent(new obf_l_N_3214(obf_l_N_3214.obf_m_x_2716,_loc5_));
            }
            _loc4_++;
         }
      }
      
      private function execCommandFilter(param1:obf_C_m_1350) : Boolean
      {
         return true;
      }
   }
}

