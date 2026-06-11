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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3500")]
   public dynamic class DepictBoxUIMC extends MovieClip
   {
      
      public var cmdDepict:MainButton;
      
      public var txtStunted:TextField;
      
      public var txtName:TextField;
      
      public var txtExplain:TextField;
      
      public var txtExplainBar:UIScrollBar;
      
      public var txtPentacle:TextField;
      
      public var obf_L_b_1645:MovieClip;
      
      public var obf_0_9_L_212:MovieClip;
      
      public var obf_p_s_2213:MovieClip;
      
      public var obf_e_D_4578:MovieClip;
      
      public var masterPonit:MovieClip;
      
      public var obf_x_u_1880:MovieClip;
      
      public function DepictBoxUIMC()
      {
         super();
         obf_b_I_2116();
         obf_J_y_1825();
      }
      
      internal function obf_J_y_1825() : *
      {
         try
         {
            txtExplainBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtExplainBar.direction = "vertical";
         txtExplainBar.scrollTargetName = "txtExplain";
         txtExplainBar.visible = true;
         try
         {
            txtExplainBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_I_2116() : *
      {
         try
         {
            cmdDepict["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDepict.emphasized = false;
         cmdDepict.enabled = true;
         cmdDepict.label = "obf_____4734";
         cmdDepict.labelPlacement = "right";
         cmdDepict.selected = false;
         cmdDepict.toggle = false;
         cmdDepict.visible = true;
         try
         {
            cmdDepict["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

