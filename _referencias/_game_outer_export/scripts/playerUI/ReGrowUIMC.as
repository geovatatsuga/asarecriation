package playerUI
{
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3679")]
   public dynamic class ReGrowUIMC extends MovieClip
   {
      
      public var txtAttrPoint1:TextField;
      
      public var txtAttrPoint2:TextField;
      
      public var txtNextLevelCond:TextField;
      
      public var txtExp:TextField;
      
      public var inputCopper2:TextField;
      
      public var txtDeyExpBall:TextField;
      
      public var inputCopper1:TextField;
      
      public var inputSilver1:TextField;
      
      public var inputSilver2:TextField;
      
      public var fusionIcon:IconBarMC;
      
      public var cmdPickExp:MainButton;
      
      public var inputGold1:TextField;
      
      public var txtName:TextField;
      
      public var txtExpBall:TextField;
      
      public var inputGold2:TextField;
      
      public var txtCurrentLevel:TextField;
      
      public var cmdReset:MainButton;
      
      public var nextAttrsValue:TextField;
      
      public var expBall:MovieClip;
      
      public var fusionCond:TextField;
      
      public var inputDiamond1:TextField;
      
      public var currentAttrsValue:TextField;
      
      public var cmdInputExp:MainButton;
      
      public var inputDiamond2:TextField;
      
      public var txtNextLevel:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtCurrentLv:TextField;
      
      public var currentAttrsName:TextField;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var icon3:IconBarMC;
      
      public var icon4:IconBarMC;
      
      public var icon5:IconBarMC;
      
      public var icon6:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyAttrPoint1:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdFusion:MainButton;
      
      public var txtExplain:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtNextLv:TextField;
      
      public var nextAttrsName:TextField;
      
      public var expBar:MovieClip;
      
      public var fusionCodIcon:IconBarMC;
      
      public var txtDeyExp:TextField;
      
      public var txtDeyAttrPoint2:TextField;
      
      public function ReGrowUIMC()
      {
         super();
         obf_n_3_2203();
         obf_f_y_3104();
         obf_z_E_4548();
         obf_4_Z_1582();
      }
      
      internal function obf_f_y_3104() : *
      {
         try
         {
            cmdPickExp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPickExp.emphasized = false;
         cmdPickExp.enabled = true;
         cmdPickExp.label = "obf_____4828";
         cmdPickExp.labelPlacement = "right";
         cmdPickExp.selected = false;
         cmdPickExp.toggle = false;
         cmdPickExp.visible = true;
         try
         {
            cmdPickExp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_Z_1582() : *
      {
         try
         {
            cmdReset["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdReset.emphasized = false;
         cmdReset.enabled = true;
         cmdReset.label = "obf___4876";
         cmdReset.labelPlacement = "right";
         cmdReset.selected = false;
         cmdReset.toggle = false;
         cmdReset.visible = true;
         try
         {
            cmdReset["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_n_3_2203() : *
      {
         try
         {
            cmdInputExp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdInputExp.emphasized = false;
         cmdInputExp.enabled = true;
         cmdInputExp.label = "obf_____4736";
         cmdInputExp.labelPlacement = "right";
         cmdInputExp.selected = false;
         cmdInputExp.toggle = false;
         cmdInputExp.visible = true;
         try
         {
            cmdInputExp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_z_E_4548() : *
      {
         try
         {
            cmdFusion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFusion.emphasized = false;
         cmdFusion.enabled = true;
         cmdFusion.label = "obf______4644";
         cmdFusion.labelPlacement = "right";
         cmdFusion.selected = false;
         cmdFusion.toggle = false;
         cmdFusion.visible = true;
         try
         {
            cmdFusion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

