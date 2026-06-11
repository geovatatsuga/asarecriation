package com.sunweb.game.rpg.script
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class DynamicVars extends obf_2_M_853
   {
      
      public static var systemVar:DynamicVars;
      
      public static var mapVar:DynamicVars;
      
      public static var familyVar:DynamicVars;
      
      public var boolVars:Object = new Object();
      
      public var intVars:Object = new Object();
      
      public var strVars:Object = new Object();
      
      public function DynamicVars()
      {
         super();
      }
      
      public function get conditionFunArray() : Array
      {
         return [{
            "funName":"intVar=",
            "fun":this.intVarsEQ
         },{
            "funName":"intVar>",
            "fun":this.intVarsGT
         },{
            "funName":"intVar<",
            "fun":this.intVarsLT
         },{
            "funName":"intVar>=",
            "fun":this.intVarsGE
         },{
            "funName":"intVar<=",
            "fun":this.intVarsLE
         },{
            "funName":"boolVar=",
            "fun":this.boolVarsEQ
         },{
            "funName":"strVar=",
            "fun":this.strVarsEQ
         }];
      }
      
      public function getBoolVarHTML(param1:String, param2:Boolean, param3:String) : String
      {
         var _loc4_:String = "";
         var _loc5_:String = obf_7_6_4416.getVarLinkA(param1);
         if(obf_L_l_4100.isEmpty(_loc5_))
         {
            _loc5_ = param1;
         }
         if(param2)
         {
            _loc4_ = DiversityManager.getString("ConditionPrompt","varIs",[_loc5_]);
         }
         else
         {
            _loc4_ = DiversityManager.getString("ConditionPrompt","varNot",[_loc5_]);
         }
         if(this.boolVarEQ(param1,param2))
         {
            _loc4_ += param3;
         }
         return _loc4_;
      }
      
      public function getStringVarHTML(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:String = "";
         var _loc5_:String = obf_7_6_4416.getVarLinkA(param1);
         if(obf_L_l_4100.isEmpty(_loc5_))
         {
            _loc5_ = param1;
         }
         _loc4_ = DiversityManager.getString("ConditionPrompt","varIs",[_loc5_]);
         if(this.strVarEQ(param1,param2))
         {
            _loc4_ += param3;
         }
         return _loc4_;
      }
      
      public function getIntVarHTML(param1:String, param2:int, param3:String, param4:String) : String
      {
         var _loc5_:String = "";
         var _loc6_:String = obf_7_6_4416.getVarLinkA(param1);
         if(obf_L_l_4100.isEmpty(_loc6_))
         {
            _loc6_ = param1;
         }
         var _loc7_:String = "var=";
         var _loc8_:String = "";
         if(param3.indexOf(">") > -1)
         {
            _loc7_ = "var>";
            if(this.intVarGT(param1,param2))
            {
               _loc8_ = param4;
            }
         }
         else if(param3.indexOf(">=") > -1)
         {
            _loc7_ = "var>";
            if(this.intVarGE(param1,param2))
            {
               _loc8_ = param4;
            }
         }
         else if(param3.indexOf("<") > -1)
         {
            _loc7_ = "var<";
            if(this.intVarLT(param1,param2))
            {
               _loc8_ = param4;
            }
         }
         else if(param3.indexOf("<=") > -1)
         {
            _loc7_ = "var<";
            if(this.intVarLE(param1,param2))
            {
               _loc8_ = param4;
            }
         }
         else
         {
            _loc7_ = "var=";
            if(this.intVarEQ(param1,param2))
            {
               _loc8_ = param4;
            }
         }
         return DiversityManager.getString("ConditionPrompt",_loc7_,[_loc6_,this.getIntVar(param1) + "/" + param2]) + _loc8_;
      }
      
      public function getVarsShow() : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:String = "";
         _loc1_ += "[BoolVar]\n";
         for(_loc2_ in this.boolVars)
         {
            _loc1_ += _loc2_ + "=" + this.boolVars[_loc2_] + "\n";
         }
         _loc1_ += "[IntVar]\n";
         for(_loc3_ in this.intVars)
         {
            _loc1_ += _loc3_ + "=" + this.intVars[_loc3_] + "\n";
         }
         _loc1_ += "[StrVar]\n";
         for(_loc4_ in this.strVars)
         {
            _loc1_ += _loc4_ + "=" + this.strVars[_loc4_] + "\n";
         }
         return _loc1_;
      }
      
      public function intVarEQ(param1:String, param2:int) : Boolean
      {
         return this.getIntVar(param1) == param2;
      }
      
      public function intVarsEQ(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.intVarEQ(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function intVarGT(param1:String, param2:int) : Boolean
      {
         return this.getIntVar(param1) > param2;
      }
      
      public function intVarsGT(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.intVarGT(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function intVarGE(param1:String, param2:int) : Boolean
      {
         return this.getIntVar(param1) >= param2;
      }
      
      public function intVarsGE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.intVarGE(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function intVarLT(param1:String, param2:int) : Boolean
      {
         return this.getIntVar(param1) < param2;
      }
      
      public function intVarsLT(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.intVarLT(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function intVarLE(param1:String, param2:int) : Boolean
      {
         return this.getIntVar(param1) <= param2;
      }
      
      public function intVarsLE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.intVarLE(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function boolVarEQ(param1:String, param2:Boolean) : Boolean
      {
         return this.getBoolVar(param1) == param2;
      }
      
      public function boolVarsEQ(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.boolVarEQ(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function strVarEQ(param1:String, param2:String) : Boolean
      {
         return this.getStrVar(param1) == param2;
      }
      
      public function strVarsEQ(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!this.strVarEQ(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public function addIntVar(param1:String, param2:int) : void
      {
         this.intVars[param1] = param2;
      }
      
      public function addBoolVar(param1:String, param2:Boolean) : void
      {
         this.boolVars[param1] = param2;
      }
      
      public function addStrVar(param1:String, param2:String) : void
      {
         this.strVars[param1] = param2;
      }
      
      public function getIntVar(param1:String, param2:int = 0) : int
      {
         if(!this.intVars.hasOwnProperty(param1))
         {
            return param2;
         }
         return this.intVars[param1];
      }
      
      public function getBoolVar(param1:String, param2:Boolean = false) : Boolean
      {
         if(!this.boolVars.hasOwnProperty(param1))
         {
            return param2;
         }
         return this.boolVars[param1];
      }
      
      public function getStrVar(param1:String, param2:String = "") : String
      {
         if(!this.strVars.hasOwnProperty(param1))
         {
            return param2;
         }
         return this.strVars[param1];
      }
      
      public function obf_8_W_2534() : void
      {
         this.boolVars = new Object();
      }
      
      public function obf_E_t_1531() : void
      {
         this.strVars = new Object();
      }
      
      public function obf_f_1820() : void
      {
         this.intVars = new Object();
      }
      
      public function delIntVar(param1:String) : void
      {
         delete this.intVars[param1];
      }
      
      public function delBoolVar(param1:String) : void
      {
         delete this.boolVars[param1];
      }
      
      public function delStrVar(param1:String) : void
      {
         delete this.strVars[param1];
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:map(string,boolean)","intVars:map(string,vint)","strVars:map(string,string)"];
      }
   }
}

