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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4692")]
   public dynamic class RideEquBoxUIMC extends MovieClip
   {
      
      public var strength:MainButton;
      
      public var txtName2:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var partPoint:MovieClip;
      
      public var part1:MovieClip;
      
      public var part2:MovieClip;
      
      public var part3:MovieClip;
      
      public var part4:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtExplain:TextField;
      
      public var refine:MainButton;
      
      public var recreate:MainButton;
      
      public var txtName0:TextField;
      
      public var txtName1:TextField;
      
      public var txtName3:TextField;
      
      public var inherit:MainButton;
      
      public var ridePoint:MovieClip;
      
      public function RideEquBoxUIMC()
      {
         super();
         obf_m_s_2374();
         obf_0_1_Q_195();
         obf_V_d_3588();
         obf_3_r_1823();
      }
      
      internal function obf_3_r_1823() : *
      {
         try
         {
            refine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         refine.emphasized = false;
         refine.enabled = true;
         refine.label = "obf___4965";
         refine.labelPlacement = "right";
         refine.selected = false;
         refine.toggle = false;
         refine.visible = true;
         try
         {
            refine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_Q_195() : *
      {
         try
         {
            recreate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         recreate.emphasized = false;
         recreate.enabled = true;
         recreate.label = "obf___4976";
         recreate.labelPlacement = "right";
         recreate.selected = false;
         recreate.toggle = false;
         recreate.visible = true;
         try
         {
            recreate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_d_3588() : *
      {
         try
         {
            inherit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inherit.emphasized = false;
         inherit.enabled = true;
         inherit.label = "obf___4880";
         inherit.labelPlacement = "right";
         inherit.selected = false;
         inherit.toggle = false;
         inherit.visible = true;
         try
         {
            inherit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_s_2374() : *
      {
         try
         {
            strength["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         strength.emphasized = false;
         strength.enabled = true;
         strength.label = "obf___4967";
         strength.labelPlacement = "right";
         strength.selected = false;
         strength.toggle = false;
         strength.visible = true;
         try
         {
            strength["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

