package playerUI
{
   import ControlClass.MJCheckBox;
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1378")]
   public dynamic class DragonBoxUIMC extends MovieClip
   {
      
      public var txtLuckNum:TextField;
      
      public var txtExp:TextField;
      
      public var txtName:TextField;
      
      public var cmdHide:MJCheckBox;
      
      public var cmdProbability:MainButton;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var txtForceNum:TextField;
      
      public var bag4:IconBarMC;
      
      public var val1:TextField;
      
      public var val3:TextField;
      
      public var val4:TextField;
      
      public var val5:TextField;
      
      public var val6:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var val2:TextField;
      
      public var bag3:IconBarMC;
      
      public var txtLuck:TextField;
      
      public var txt2:TextField;
      
      public var txt3:TextField;
      
      public var txt4:TextField;
      
      public var txt5:TextField;
      
      public var txt6:TextField;
      
      public var txtSpare:TextField;
      
      public var bg:MovieClip;
      
      public var txtSpareNum:TextField;
      
      public var cmdTenLvUP:MainButton;
      
      public var txt1:TextField;
      
      public var titleBox:MovieClip;
      
      public var obf_0_5_N_657:MovieClip;
      
      public var txtForce:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var lookLvUP:TextField;
      
      public var expBar:MovieClip;
      
      public var cmdLvUP:MainButton;
      
      public function DragonBoxUIMC()
      {
         super();
         obf_X_B_1607();
         obf_4_p_3559();
         obf_T_4675();
         obf_P_y_3479();
      }
      
      internal function obf_P_y_3479() : *
      {
         try
         {
            cmdHide["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdHide.enabled = true;
         cmdHide.label = "obf_____4839";
         cmdHide.labelPlacement = "right";
         cmdHide.selected = false;
         cmdHide.visible = true;
         try
         {
            cmdHide["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_p_3559() : *
      {
         try
         {
            cmdTenLvUP["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTenLvUP.emphasized = false;
         cmdTenLvUP.enabled = true;
         cmdTenLvUP.label = "obf_1_0____4638";
         cmdTenLvUP.labelPlacement = "right";
         cmdTenLvUP.selected = false;
         cmdTenLvUP.toggle = false;
         cmdTenLvUP.visible = true;
         try
         {
            cmdTenLvUP["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_B_1607() : *
      {
         try
         {
            cmdLvUP["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLvUP.emphasized = false;
         cmdLvUP.enabled = true;
         cmdLvUP.label = "obf___4963";
         cmdLvUP.labelPlacement = "right";
         cmdLvUP.selected = false;
         cmdLvUP.toggle = false;
         cmdLvUP.visible = true;
         try
         {
            cmdLvUP["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_T_4675() : *
      {
         try
         {
            cmdProbability["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdProbability.emphasized = false;
         cmdProbability.enabled = true;
         cmdProbability.label = "obf_____4848";
         cmdProbability.labelPlacement = "right";
         cmdProbability.selected = false;
         cmdProbability.toggle = false;
         cmdProbability.visible = true;
         try
         {
            cmdProbability["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

