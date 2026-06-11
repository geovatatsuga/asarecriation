package obf_g_A_3629
{
   import flash.events.Event;
   import flash.text.TextField;
   
   public class obf_g_u_3212
   {
      
      public static const obf_f_t_4250:String = "￡";
      
      public static const obf_n_M_2117:String = obf_f_t_4250 + "([0-9]{2})";
      
      private static var obf_0_2_x_463:TextField = new TextField();
      
      public var obf_6_0_1107:TextField;
      
      public function obf_g_u_3212(param1:TextField)
      {
         super();
         this.obf_6_0_1107 = param1;
         this.obf_6_0_1107.addEventListener(Event.CHANGE,this.obf_T_O_4464);
      }
      
      public static function getFinallyLinkCode(param1:String) : String
      {
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:String = param1.substring(1,param1.length - 1);
         var _loc3_:Array = _loc2_.split("^");
         if(_loc3_.length < 2)
         {
            return _loc2_;
         }
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(_loc3_.length == 2 && _loc3_[0] == ChatDecoder.obf_W_v_983)
         {
            _loc5_ = "^" + _loc3_[1];
         }
         if(_loc3_.length > 2)
         {
            _loc6_ = 2;
            while(_loc6_ < _loc3_.length)
            {
               _loc5_ = _loc5_ + "^" + _loc3_[_loc6_];
               _loc6_++;
            }
         }
         if(_loc3_[0] == ChatDecoder.obf_d_Y_2785)
         {
            _loc4_ = _loc3_[0] + _loc5_;
         }
         else
         {
            _loc4_ = _loc3_[0] + "^" + _loc3_[1] + _loc5_;
         }
         return "[" + _loc4_ + "]";
      }
      
      public static function getItemLinkCode(param1:String, param2:String, param3:String = null) : String
      {
         if(param3 == null)
         {
            param3 = "";
         }
         param3 = param3 == "" ? param3 : "^" + param3;
         param1 = param1.replace(new RegExp(/'/g),"");
         param1 = param1.replace(new RegExp(/\"/g),"");
         return "[" + ChatDecoder.obf_d_Y_2785 + "^" + param1 + "^" + param2 + param3 + "]";
      }
      
      public static function getRoleLinkCode(param1:String) : String
      {
         return "[" + ChatDecoder.obf_W_v_983 + "^" + param1 + "]";
      }
      
      public static function getMapLinkCode(param1:String, param2:String, param3:int, param4:int) : String
      {
         param1 = param1.replace(new RegExp(/'/g),"");
         param1 = param1.replace(new RegExp(/\"/g),"");
         return "[" + ChatDecoder.MAP + "^" + param1 + "^" + param3 + "," + param4 + "@" + param2 + "]";
      }
      
      public static function getNpcLinkCode(param1:String, param2:String, param3:String) : String
      {
         param1 = param1.replace(new RegExp(/'/g),"");
         param1 = param1.replace(new RegExp(/\"/g),"");
         return "[" + ChatDecoder.NPC + "^" + param1 + "^" + param3 + "@" + param2 + "]";
      }
      
      public static function getFarmLinkCode(param1:String, param2:String, param3:String) : String
      {
         return "[" + ChatDecoder.FARM + "^" + param1 + "^" + param3 + "@" + param2 + "]";
      }
      
      public static function getItemAtPlaceLinkCode(param1:String) : String
      {
         return "[" + ChatDecoder.obf_F_N_1408 + "^" + param1 + "]";
      }
      
      public static function getMonsterAtPlaceLinkCode(param1:String) : String
      {
         return "[" + ChatDecoder.obf_6_Y_2207 + "^" + param1 + "]";
      }
      
      public static function getMacroLinkCode(param1:String, param2:String) : String
      {
         return "[" + ChatDecoder.obf_E_4_4245 + "^" + param1 + "^" + param2 + "]";
      }
      
      public static function obf_h_l_3958(param1:String) : Boolean
      {
         var _loc2_:RegExp = new RegExp(obf_n_M_2117,"ig");
         var _loc3_:Object = _loc2_.exec(param1);
         return null != _loc3_;
      }
      
      public static function sendText(param1:String, param2:String, param3:XML) : String
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = param1;
         var _loc5_:RegExp = new RegExp("<FONT COLOR.*?><A.*?HREF=\"event:(.*?)\\☞(.*?)\".*?><U>(.*?)</U></A></FONT>","ig");
         var _loc6_:Object = _loc5_.exec(param1);
         while(_loc6_ != null)
         {
            _loc8_ = _loc6_[2];
            _loc9_ = _loc6_[3];
            if(_loc8_ != _loc9_ || _loc6_.index - 1 < 0 || param1.substr(_loc6_.index - 1,1) != "[" || _loc5_.lastIndex == param1.length || param1.substr(_loc5_.lastIndex,1) != "]")
            {
               _loc4_ = _loc4_.replace(_loc6_[0],_loc6_[3]);
            }
            else
            {
               _loc4_ = _loc4_.replace(_loc6_[0],_loc6_[1]);
            }
            _loc6_ = _loc5_.exec(param1);
         }
         obf_0_2_x_463.htmlText = _loc4_;
         var _loc7_:String = obf_0_2_x_463.text;
         return getFaceCode(_loc7_,param2,param3);
      }
      
      public static function getFaceCode(param1:String, param2:String, param3:XML) : String
      {
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc4_:int = int(param3.sprites.sprite.length());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param3.sprites.sprite[_loc5_];
            _loc7_ = String(_loc6_.@src);
            _loc7_ = obf_f_t_4250 + _loc7_.substr(1,2);
            param1 = param1.replace(param2,_loc7_);
            _loc5_++;
         }
         return param1;
      }
      
      public static function getNoCode(param1:String) : String
      {
         var _loc2_:String = "VIP" + "([0-9]{2})";
         var _loc3_:RegExp = new RegExp(_loc2_,"i");
         var _loc4_:Object = _loc3_.exec(param1);
         var _loc5_:String = "";
         var _loc6_:int = 0;
         if(_loc4_)
         {
            if(_loc4_)
            {
               _loc5_ += param1.slice(_loc6_,_loc4_.index);
               _loc6_ = _loc4_.index + 5;
            }
            if(_loc6_ != param1.length)
            {
               _loc5_ += param1.slice(_loc6_,param1.length);
            }
         }
         else
         {
            _loc5_ = param1;
         }
         var _loc7_:RegExp = new RegExp(obf_n_M_2117,"ig");
         var _loc8_:Object = _loc7_.exec(_loc5_);
         var _loc9_:String = "";
         var _loc10_:int = 0;
         if(!_loc8_)
         {
            return _loc5_;
         }
         if(_loc8_)
         {
            while(_loc8_)
            {
               _loc9_ += _loc5_.slice(_loc10_,_loc8_.index);
               _loc10_ = _loc8_.index + 3;
               _loc8_ = _loc7_.exec(_loc5_);
            }
         }
         if(_loc10_ != _loc5_.length)
         {
            _loc9_ += _loc5_.slice(_loc10_,_loc5_.length);
         }
         return _loc9_;
      }
      
      public static function getNoFaceCode(param1:String) : String
      {
         var _loc2_:RegExp = new RegExp(obf_n_M_2117,"ig");
         var _loc3_:Object = _loc2_.exec(param1);
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc3_)
         {
            _loc4_ += param1.slice(_loc5_,_loc3_.index);
            _loc5_ = _loc3_.index + 3;
            _loc3_ = _loc2_.exec(param1);
         }
         if(_loc5_ != param1.length)
         {
            _loc4_ += param1.slice(_loc5_,param1.length);
         }
         return _loc4_;
      }
      
      public static function obf_r_F_1391(param1:String) : String
      {
         var _loc2_:RegExp = new RegExp(obf_n_M_2117,"ig");
         var _loc3_:Object = _loc2_.exec(param1);
         if(!_loc3_)
         {
            return param1;
         }
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc3_)
         {
            _loc4_ += param1.slice(_loc5_,_loc3_.index);
            _loc5_ = _loc3_.index + 3;
            _loc3_ = _loc2_.exec(param1);
         }
         if(_loc5_ != param1.length)
         {
            _loc4_ += param1.slice(_loc5_,param1.length);
         }
         return _loc4_;
      }
      
      public static function getTextStr(param1:String) : String
      {
         obf_0_2_x_463.htmlText = param1;
         return obf_0_2_x_463.text;
      }
      
      public static function getNoVipCode(param1:String) : String
      {
         var _loc2_:String = "VIP" + "([0-9]{2})";
         var _loc3_:RegExp = new RegExp(_loc2_,"ig");
         var _loc4_:Object = _loc3_.exec(param1);
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:String = "";
         var _loc6_:int = 0;
         if(_loc4_)
         {
            _loc5_ += param1.slice(_loc6_,_loc4_.index);
            _loc6_ = _loc4_.index + 5;
         }
         if(_loc6_ != param1.length)
         {
            _loc5_ += param1.slice(_loc6_,param1.length);
         }
         return _loc5_;
      }
      
      public function destroy() : void
      {
         this.obf_6_0_1107.removeEventListener(Event.CHANGE,this.obf_T_O_4464);
      }
      
      public function insertLink(param1:String, param2:String) : void
      {
         var _loc3_:String = param1;
         param1 = param1.substring(1,param1.length - 1);
         var _loc4_:Array = param1.split("^");
         if(_loc4_.length < 2)
         {
            return;
         }
         var _loc5_:String = getFinallyLinkCode(_loc3_);
         _loc5_ = _loc5_.substring(1,_loc5_.length - 1);
         var _loc6_:String = "[<FONT COLOR=\'#" + param2 + "\'><A HREF=\"event:" + _loc5_ + "☞" + _loc4_[1] + "\"><U>" + _loc4_[1] + "</U></A></FONT>]";
         this.obf_6_0_1107.htmlText += _loc6_;
      }
      
      public function get sendText() : String
      {
         var _loc1_:String = this.obf_6_0_1107.htmlText;
         var _loc2_:RegExp = new RegExp("<FONT COLOR.*?><A.*?HREF=\"event:(.*?)\\☞.*?\".*?><U>.*?</U></A></FONT>","ig");
         this.obf_6_0_1107.htmlText = this.obf_6_0_1107.htmlText.replace(_loc2_,"$1");
         var _loc3_:String = this.obf_6_0_1107.text;
         this.obf_6_0_1107.htmlText = _loc1_;
         return _loc3_;
      }
      
      private function obf_T_O_4464(param1:Event) : void
      {
         var _loc4_:RegExp = null;
         var _loc5_:String = null;
         var _loc6_:RegExp = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:RegExp = new RegExp("<FONT COLOR.*?><A.*?><U>.*?</U></A>.*?</FONT>","ig");
         var _loc3_:Object = _loc2_.exec(this.obf_6_0_1107.htmlText);
         while(_loc3_ != null)
         {
            _loc4_ = /HREF="(.*?)"/i;
            _loc5_ = _loc4_.exec(_loc3_[0])[1];
            _loc6_ = new RegExp("<A.*?><U>(.*?)</U></A>","i");
            _loc7_ = _loc6_.exec(_loc3_[0])[1];
            if(_loc5_.split("☞")[1] != _loc7_ || _loc3_.index - 1 < 0 || this.obf_6_0_1107.htmlText.substr(_loc3_.index - 1,1) != "[" || _loc2_.lastIndex == this.obf_6_0_1107.htmlText.length || this.obf_6_0_1107.htmlText.substr(_loc2_.lastIndex,1) != "]")
            {
               _loc8_ = this.obf_6_0_1107.htmlText.substring(0,_loc3_.index);
               _loc9_ = this.obf_6_0_1107.htmlText.substring(_loc3_.index,_loc2_.lastIndex);
               _loc10_ = this.obf_6_0_1107.htmlText.substring(_loc2_.lastIndex);
               this.obf_6_0_1107.htmlText = _loc8_ + _loc9_.replace(_loc3_[0],_loc7_) + _loc10_;
            }
            _loc3_ = _loc2_.exec(this.obf_6_0_1107.htmlText);
         }
      }
   }
}

