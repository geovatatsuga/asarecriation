package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2318")]
   public dynamic class GenieMagicSkillUIMC extends MovieClip
   {
      
      public var digIcon4:IconBarMC;
      
      public var txtRideMagicSum:TextField;
      
      public var txtGhostSum:TextField;
      
      public var obf_e_h_3725:IconBarMC;
      
      public var txtGenieSum:TextField;
      
      public var cmdRideSum:MainButton;
      
      public var rideSumIcon:IconBarMC;
      
      public var cmdGhostSum:MainButton;
      
      public var cmdBless:MainButton;
      
      public var cmdElemSum:MainButton;
      
      public var obf_0_0_D_211:TextField;
      
      public var pointRollBox:MovieClip;
      
      public var txtDryDig:TextField;
      
      public var obf_P_Q_4429:UIScrollBar;
      
      public var cmdDig:MainButton;
      
      public var elementPoint:MovieClip;
      
      public var digIcon1:IconBarMC;
      
      public var digIcon2:IconBarMC;
      
      public var digIcon3:IconBarMC;
      
      public var txtGenieBless:TextField;
      
      public function GenieMagicSkillUIMC()
      {
         super();
         obf_7_p_3142();
         obf_z_B_1468();
         obf_1_D_4235();
         obf_2_G_852();
         obf_X_I_4331();
      }
      
      internal function obf_1_D_4235() : *
      {
         try
         {
            cmdBless["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBless.emphasized = false;
         cmdBless.enabled = true;
         cmdBless.label = "obf___4896";
         cmdBless.labelPlacement = "right";
         cmdBless.selected = false;
         cmdBless.toggle = false;
         cmdBless.visible = true;
         try
         {
            cmdBless["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_7_p_3142() : *
      {
         try
         {
            cmdElemSum["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdElemSum.emphasized = false;
         cmdElemSum.enabled = true;
         cmdElemSum.label = "obf___4895";
         cmdElemSum.labelPlacement = "right";
         cmdElemSum.selected = false;
         cmdElemSum.toggle = false;
         cmdElemSum.visible = true;
         try
         {
            cmdElemSum["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_2_G_852() : *
      {
         try
         {
            cmdGhostSum["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGhostSum.emphasized = false;
         cmdGhostSum.enabled = true;
         cmdGhostSum.label = "obf___4895";
         cmdGhostSum.labelPlacement = "right";
         cmdGhostSum.selected = false;
         cmdGhostSum.toggle = false;
         cmdGhostSum.visible = true;
         try
         {
            cmdGhostSum["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_z_B_1468() : *
      {
         try
         {
            cmdRideSum["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRideSum.emphasized = false;
         cmdRideSum.enabled = true;
         cmdRideSum.label = "obf___4895";
         cmdRideSum.labelPlacement = "right";
         cmdRideSum.selected = false;
         cmdRideSum.toggle = false;
         cmdRideSum.visible = true;
         try
         {
            cmdRideSum["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_X_I_4331() : *
      {
         try
         {
            cmdDig["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDig.emphasized = false;
         cmdDig.enabled = true;
         cmdDig.label = "obf____4862";
         cmdDig.labelPlacement = "right";
         cmdDig.selected = false;
         cmdDig.toggle = false;
         cmdDig.visible = true;
         try
         {
            cmdDig["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

