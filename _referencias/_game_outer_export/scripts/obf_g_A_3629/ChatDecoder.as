package obf_g_A_3629
{
   public class ChatDecoder
   {
      
      public static var obf_1_o_3955:Function;
      
      public static var obf_0_4_m_107:Function;
      
      public static var getNpcName:Function;
      
      public static var getMonster:Function;
      
      public static const obf_W_v_983:String = "r";
      
      public static const obf_d_Y_2785:String = "i";
      
      public static const MAP:String = "a";
      
      public static const NPC:String = "n";
      
      public static const FARM:String = "f";
      
      public static const obf_9_K_1802:String = "h";
      
      public static const obf_C_4677:String = "u";
      
      public static const obf_F_N_1408:String = "ia";
      
      public static const obf_6_Y_2207:String = "ma";
      
      public static const obf_E_4_4245:String = "mr";
      
      public static const obf_P_U_3808:String = "*";
      
      public static var obf_0_4_R_115:String = "0000FF";
      
      public static var obf_l_W_4297:String = "0000FF";
      
      public static var obf_H_O_3489:String = "0000FF";
      
      public static var obf_0_2_I_312:String = "0000FF";
      
      public static var macroColor:String = "0000FF";
      
      public static var urlColor:String = "00ff00";
      
      public static var mrColor:String = "ff0000";
      
      public function ChatDecoder()
      {
         super();
      }
      
      public static function obf_3_8_1066(param1:Function, param2:Function, param3:Function, param4:Function) : void
      {
         obf_1_o_3955 = param1;
         obf_0_4_m_107 = param2;
         getNpcName = param3;
         getMonster = param4;
      }
      
      public static function decode(param1:String, param2:String = null, param3:Array = null) : String
      {
         var _loc5_:RegExp = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:Object = null;
         var _loc19_:String = null;
         var _loc20_:Object = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc4_:String = param1;
         if(obf_1_o_3955 != null && obf_0_4_m_107 != null)
         {
            _loc5_ = /\[([^\[\]]+)\]/ig;
            _loc6_ = _loc5_.exec(param1);
            for(; _loc6_ != null; _loc6_ = _loc5_.exec(param1))
            {
               _loc7_ = _loc6_[1];
               _loc8_ = _loc7_.split("^");
               if(_loc8_.length <= 1)
               {
                  continue;
               }
               switch(_loc8_[0])
               {
                  case obf_d_Y_2785:
                     if(!(param3 != null && param3.indexOf(obf_d_Y_2785) > -1))
                     {
                        if(_loc8_.length <= 3)
                        {
                           _loc9_ = obf_1_o_3955(_loc8_[1],_loc8_.length == 3 ? _loc8_[2] : null);
                           if(_loc9_ !== null)
                           {
                              _loc10_ = "<FONT COLOR=\'#" + _loc9_.color + "\'><A HREF=\"event:" + _loc7_ + "\">[<U>" + (param2 == null ? _loc9_.name : param2) + "</U>]</A></FONT>";
                              _loc4_ = _loc4_.replace(_loc6_[0],_loc10_);
                           }
                        }
                     }
                     break;
                  case obf_W_v_983:
                     if(!(param3 != null && param3.indexOf(obf_W_v_983) > -1))
                     {
                        if(_loc8_.length == 2)
                        {
                           _loc11_ = obf_0_4_m_107(_loc8_[1]);
                           if(_loc11_ != null)
                           {
                              _loc12_ = "<FONT COLOR=\'#" + _loc11_ + "\'><A HREF=\"event:" + _loc7_ + "\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                              _loc4_ = _loc4_.replace(_loc6_[0],_loc12_);
                           }
                        }
                     }
                     break;
                  case MAP:
                     if(!(param3 != null && param3.indexOf(MAP) > -1))
                     {
                        if(_loc8_.length == 3)
                        {
                           _loc13_ = "<FONT COLOR=\'#" + obf_l_W_4297 + "\'><A HREF=\"event:" + MAP + "^" + _loc8_[2] + "\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc13_);
                        }
                     }
                     break;
                  case NPC:
                     if(!(param3 != null && param3.indexOf(NPC) > -1))
                     {
                        if(_loc8_.length == 3)
                        {
                           _loc14_ = _loc8_[1];
                           if(_loc14_ == obf_P_U_3808)
                           {
                              _loc14_ = getNpcName(_loc8_[2]);
                           }
                           _loc15_ = "<FONT COLOR=\'#" + obf_0_4_R_115 + "\'><A HREF=\"event:" + NPC + "^" + _loc8_[2] + "\">[<U>" + (param2 == null ? _loc14_ : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc15_);
                        }
                     }
                     break;
                  case FARM:
                     if(!(param3 != null && param3.indexOf(FARM) > -1))
                     {
                        if(_loc8_.length == 3)
                        {
                           _loc16_ = "<FONT COLOR=\'#" + obf_H_O_3489 + "\'><A HREF=\"event:" + FARM + "^" + _loc8_[2] + "\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc16_);
                        }
                     }
                     break;
                  case obf_9_K_1802:
                     if(!(param3 != null && param3.indexOf(obf_9_K_1802) > -1))
                     {
                        if(_loc8_.length == 3)
                        {
                           _loc17_ = "<FONT COLOR=\'#" + obf_0_2_I_312 + "\'><A HREF=\"" + _loc8_[2] + "\" TARGET=\"_blank\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc17_);
                        }
                     }
                     break;
                  case obf_F_N_1408:
                     if(!(param3 != null && param3.indexOf(obf_F_N_1408) > -1))
                     {
                        if(_loc8_.length == 2)
                        {
                           _loc18_ = obf_1_o_3955(_loc8_[1],null);
                           if(_loc18_ != null)
                           {
                              _loc19_ = "<FONT COLOR=\'#" + _loc18_.color + "\'><A HREF=\"event:" + MAP + "^" + _loc18_.atPlace + "\">[<U>" + (param2 == null ? _loc18_.name : param2) + "</U>]</A></FONT>";
                              _loc4_ = _loc4_.replace(_loc6_[0],_loc19_);
                           }
                        }
                     }
                     break;
                  case obf_6_Y_2207:
                     if(!(param3 != null && param3.indexOf(obf_6_Y_2207) > -1))
                     {
                        if(_loc8_.length == 2)
                        {
                           _loc20_ = getMonster(_loc8_[1]);
                           if(_loc20_ != null)
                           {
                              _loc21_ = "<FONT COLOR=\'#" + _loc20_.color + "\'><A HREF=\"event:" + MAP + "^" + _loc20_.atPlace + "\">[<U>" + (param2 == null ? _loc20_.name : param2) + "</U>]</A></FONT>";
                              _loc4_ = _loc4_.replace(_loc6_[0],_loc21_);
                           }
                        }
                     }
                     break;
                  case obf_E_4_4245:
                     if(!(param3 != null && param3.indexOf(obf_E_4_4245) > -1))
                     {
                        if(_loc8_.length == 3)
                        {
                           _loc22_ = "<FONT COLOR=\'#" + mrColor + "\'><A HREF=\"event:" + obf_E_4_4245 + "^" + _loc8_[2] + "\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc22_);
                        }
                     }
                     break;
                  case obf_C_4677:
                     if(!(param3 != null && param3.indexOf(obf_C_4677) > -1))
                     {
                        if(_loc8_.length == 2)
                        {
                           _loc23_ = "<FONT COLOR=\'#" + urlColor + "\'><A HREF=\"event:" + obf_C_4677 + "^" + _loc8_[1] + "\">[<U>" + (param2 == null ? _loc8_[1] : param2) + "</U>]</A></FONT>";
                           _loc4_ = _loc4_.replace(_loc6_[0],_loc23_);
                        }
                     }
               }
            }
         }
         return _loc4_;
      }
   }
}

